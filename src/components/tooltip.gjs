/* eslint-disable ember/no-runloop, no-unused-vars */

import { action } from '@ember/object';
import { cancel, later, next } from '@ember/runloop';
import { defer } from 'rsvp';
import { getPosition, getCoords } from '@zestia/position-utils';
import { guidFor } from '@ember/object/internals';
import { htmlSafe } from '@ember/template';
import { modifier } from 'ember-modifier';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { waitFor } from '@ember/test-waiters';
import { waitForAnimation } from '@zestia/animation-utils';
import autoPosition from '@zestia/ember-async-tooltips/utils/auto-position';
import Component from '@glimmer/component';
const { max } = Math;

export default class TooltipComponent extends Component {
  @service('tooltip') tooltipService;

  @tracked element;
  @tracked isLoading;
  @tracked loadedData = null;
  @tracked loadError = null;
  @tracked shouldRenderTooltip;
  @tracked shouldShowTooltip;
  @tracked tooltipCoords = [0, 0];
  @tracked tooltipElement;

  hideTimer;
  isLoaded;
  isOverTooltipElement;
  isOverTooltipperElement;
  tooltipperElementIsFocused;
  tooltipElementIsFocused;
  loadDuration = 0;
  showTimer;
  stickyTimer;
  tetherID;
  willInsertTooltip;

  get id() {
    return guidFor(this);
  }

  get columns() {
    return this.args.columns ?? 3;
  }

  get rows() {
    return this.args.rows ?? 3;
  }

  get tooltipStyle() {
    const [x, y] = this.tooltipCoords;

    return htmlSafe(`top: ${y}px; left: ${x}px`);
  }

  get hideDelay() {
    return this.args.hideDelay ?? 0;
  }

  get showDelay() {
    return this.args.showDelay ?? 0;
  }

  get actualShowDelay() {
    if (this.isSticky) {
      return 0;
    }

    if (this.isEager) {
      return max(this.showDelay - this.loadDuration, 0);
    }

    return this.showDelay;
  }

  get stickyTimeout() {
    return this.args.stickyTimeout ?? this.showDelay / 2;
  }

  get canRenderTooltip() {
    return (
      this.tooltipperElement && this.needsToShowTooltip && !this.childTooltip
    );
  }

  get needsToShowTooltip() {
    if (this.args.show === false) {
      return false;
    }

    if (this.isOverTooltipperElement || this.isOverTooltipElement) {
      return true;
    }

    if (
      this.args.useFocus &&
      (this.tooltipperElementIsFocused || this.tooltipElementIsFocused)
    ) {
      return true;
    }

    return this.args.show;
  }

  get tooltips() {
    return this.tooltipService.tooltips.filter((tooltip) => tooltip !== this);
  }

  get childTooltip() {
    return this.tooltips.find((tooltip) => {
      return this.tooltipperElement?.contains(tooltip.tooltipperElement);
    });
  }

  get parentTooltip() {
    return this.tooltips.find((tooltip) => {
      return tooltip.tooltipperElement?.contains(this.tooltipperElement);
    });
  }

  get stickyTooltips() {
    return this.tooltipService.tooltips.filter((tooltip) => {
      return tooltip.args.stickyID === this.args.stickyID && tooltip.isSticky;
    });
  }

  get shouldLoad() {
    return (
      typeof this.args.onLoad === 'function' &&
      !(this.isLoading || this.isLoaded)
    );
  }

  get shouldLoadEagerly() {
    return this.isEager && this.shouldLoad;
  }

  get isEager() {
    return this.args.eager ?? true;
  }

  get isSticky() {
    return this.tooltipService._sticky[this.args.stickyID] === true;
  }

  get destinationElement() {
    return this.args.destination
      ? this._getElement(this.args.destination)
      : this.element.parentElement;
  }

  get positionElement() {
    return this.args.attachTo
      ? this._getElement(this.args.attachTo)
      : this.tooltipperElement;
  }

  get tooltipperElement() {
    return this.args.element
      ? this._getElement(this.args.element)
      : this.element.parentElement;
  }

  get referencePosition() {
    return getPosition(this.positionElement, window, this.columns, this.rows);
  }

  get tooltipPosition() {
    const { position } = this.args;

    if (typeof position === 'string') {
      return position;
    }

    if (typeof position === 'function') {
      return position(this.referencePosition);
    }

    return autoPosition(this.referencePosition);
  }

  @action
  handleMouseEnterTooltipperElement() {
    this.isOverTooltipperElement = true;

    this._prepareToShowTooltip();
  }

  @action
  handleMouseLeaveTooltipperElement() {
    this.isOverTooltipperElement = false;

    this._scheduleHideTooltip();
  }

  @action
  handleMouseEnterTooltip() {
    this.isOverTooltipElement = true;
  }

  @action
  handleMouseLeaveTooltip() {
    this.isOverTooltipElement = false;

    this._scheduleHideTooltip();
  }

  @action
  handleFocusTooltipperElement() {
    this.tooltipperElementIsFocused = true;

    this._prepareToShowTooltip();
  }

  @action
  handleBlurTooltipperElement() {
    this.tooltipperElementIsFocused = false;

    this._scheduleHideTooltip();
  }

  @action
  handleFocusTooltipElement() {
    this.tooltipElementIsFocused = true;
  }

  @action
  handleBlurTooltipElement() {
    this.tooltipElementIsFocused = false;

    this._scheduleHideTooltip();
  }

  @action
  hide() {
    return this._hideTooltip();
  }

  @action
  show() {
    this._showTooltip();
  }

  async _load() {
    const start = Date.now();

    try {
      this.isLoading = true;
      this.loadDuration = 0;
      this.loadedData = await this.args.onLoad?.();
      this.isLoaded = true;
    } catch (error) {
      this.loadError = error;
      this.isLoaded = false;
    } finally {
      const end = Date.now();
      this.loadDuration = end - start;
      this.isLoading = false;
    }
  }

  _scheduleShowTooltip() {
    this._cancelTimers();
    this.showTimer = later(this, '_attemptShowTooltip', this.actualShowDelay);
  }

  _attemptShowTooltip() {
    if (!this.canRenderTooltip) {
      return;
    }

    if (this.parentTooltip) {
      this.parentTooltip.hide();
    }

    this._showTooltip();
  }

  async _prepareToShowTooltip() {
    this.loadDuration = 0;

    if (this.shouldLoadEagerly) {
      await this._load();
    }

    this._scheduleShowTooltip();
  }

  async _showTooltip() {
    this.shouldShowTooltip = true;

    if (this.shouldRenderTooltip) {
      return;
    }

    if (this.shouldLoad) {
      this._load();
    }

    await this._renderTooltip();
    await this._waitForAnimation();

    this._handleShow();
  }

  _renderTooltip() {
    this.willInsertTooltip = defer();
    this.shouldRenderTooltip = true;

    return this.willInsertTooltip.promise;
  }

  _scheduleHideTooltip() {
    this._cancelTimers();

    this.hideTimer = later(this, '_attemptHideTooltip', this.hideDelay);
  }

  _attemptHideTooltip() {
    if (this.needsToShowTooltip) {
      return;
    }

    this._hideTooltip();
  }

  async _hideTooltip() {
    if (!this.tooltipElement) {
      return;
    }

    this.shouldShowTooltip = false;

    await this._waitForAnimation();

    this._handleHide();
  }

  _cancelTimers() {
    cancel(this.showTimer);
    cancel(this.hideTimer);
    cancel(this.stickyTimer);
  }

  _scheduleResetSticky() {
    this.stickyTimer = later(this, '_attemptResetSticky', this.stickyTimeout);
  }

  _attemptResetSticky() {
    if (this.stickyTooltips.length) {
      return;
    }

    this.tooltipService._setSticky(this, false);
  }

  _handleShow() {
    if (this.args.stickyID) {
      this.tooltipService._setSticky(this, true);
    }

    this.args.onShow?.();
  }

  _handleHide() {
    if (this.args.stickyID) {
      this._scheduleResetSticky();
    }

    this._attemptDestroyTooltip();

    this.args.onHide?.();
  }

  @waitFor
  async _waitForAnimation() {
    await waitForAnimation(this.tooltipElement, { maybe: true });
  }

  _attemptDestroyTooltip() {
    if (this.shouldShowTooltip) {
      return;
    }

    this._destroyTooltip();
  }

  _destroyTooltip() {
    this.shouldRenderTooltip = false;
  }

  _getElement(element) {
    if (typeof element === 'string') {
      return document.querySelector(element);
    }

    if (element instanceof HTMLElement) {
      return element;
    }
  }

  _tether() {
    if (!this.positionElement) {
      return;
    }

    this.tooltipCoords = getCoords(
      this.tooltipPosition,
      this.tooltipElement,
      this.positionElement
    );

    this.tetherID = requestAnimationFrame(this._tether.bind(this));
  }

  _startTether() {
    requestAnimationFrame(this._tether.bind(this));
  }

  _stopTether() {
    cancelAnimationFrame(this.tetherID);
  }

  _add(element, ...args) {
    element.addEventListener(...args);
  }

  _remove(element, ...args) {
    element.removeEventListener(...args);
  }

  get _api() {
    return {
      data: this.loadedData,
      error: this.loadError,
      hide: this.hide
    };
  }

  api = new Proxy(this, {
    get(target, key) {
      return target._api[key];
    },
    set() {}
  });

  visibility = modifier((_, [show]) => {
    next(() => {
      if (show === true) {
        this._showTooltip();
      } else if (show === false) {
        this._hideTooltip();
      }
    });
  });

  position = modifier((_, [position, columns, rows, destination, attachTo]) => {
    this._startTether();
    return () => this._stopTether();
  });

  tooltipperEvents = modifier((element, [otherElement]) => {
    this.element = element;
    const { tooltipperElement: el } = this;

    this._add(el, 'mouseenter', this.handleMouseEnterTooltipperElement);
    this._add(el, 'mouseleave', this.handleMouseLeaveTooltipperElement);

    if (this.args.useFocus) {
      this._add(el, 'focus', this.handleFocusTooltipperElement);
      this._add(el, 'blur', this.handleBlurTooltipperElement);
    }

    return () => {
      this._remove(el, 'mouseenter', this.handleMouseEnterTooltipperElement);
      this._remove(el, 'mouseleave', this.handleMouseLeaveTooltipperElement);

      if (this.args.useFocus) {
        this._remove(el, 'focus', this.handleFocusTooltipperElement);
        this._remove(el, 'blur', this.handleBlurTooltipperElement);
      }
    };
  });

  tooltipEvents = modifier((element) => {
    this._add(element, 'mouseenter', this.handleMouseEnterTooltip);
    this._add(element, 'mouseleave', this.handleMouseLeaveTooltip);

    if (this.args.useFocus) {
      this._add(element, 'focusin', this.handleFocusTooltipElement);
      this._add(element, 'focusout', this.handleBlurTooltipElement);
    }

    return () => {
      this._remove(element, 'mouseenter', this.handleMouseEnterTooltip);
      this._remove(element, 'mouseleave', this.handleMouseLeaveTooltip);

      if (this.args.useFocus) {
        this._remove(element, 'focusin', this.handleFocusTooltipElement);
        this._remove(element, 'focusout', this.handleBlurTooltipElement);
      }
    };
  });

  className = modifier(() => {
    this.tooltipperElement.classList.add('tooltipper');
    return () => this.tooltipperElement?.classList.remove('tooltipper');
  });

  loading = modifier((_, [isLoading]) => {
    if (this.isLoading) {
      this.tooltipperElement.dataset.loading = 'true';
    } else {
      delete this.tooltipperElement?.dataset.loading;
    }
  });

  aria = modifier(() => {
    this.tooltipperElement.setAttribute('aria-describedby', this.id);
    return () => this.tooltipperElement?.removeAttribute('aria-describedby');
  });

  register = modifier((element) => {
    this.tooltipElement = element;
    this.willInsertTooltip.resolve();
    this.tooltipService._add(this);

    return () => this.tooltipService._remove(this);
  });

  <template>
    {{~""~}}
    <span
      class="__tooltip__"
      hidden
      {{this.tooltipperEvents @element}}
      {{this.className}}
      {{this.visibility @show}}
      {{this.loading this.isLoading}}
    ></span>
    {{~#if this.shouldRenderTooltip~}}
      {{~#in-element this.destinationElement insertBefore=null~}}
        <div
          class="tooltip"
          data-showing="{{this.shouldShowTooltip}}"
          data-position={{this.tooltipPosition}}
          data-sticky="{{this.isSticky}}"
          id={{this.id}}
          style={{this.tooltipStyle}}
          role="tooltip"
          aria-live="polite"
          {{this.tooltipEvents}}
          {{this.register}}
          {{this.aria}}
          {{this.position @position @columns @rows @destination @attachTo}}
          ...attributes
        >
          {{~yield this.api~}}
        </div>
      {{~/in-element~}}
    {{/if}}
    {{~""~}}
  </template>
}
