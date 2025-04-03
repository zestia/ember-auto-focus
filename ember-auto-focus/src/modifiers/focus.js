/* eslint-disable ember/no-runloop */

import Modifier from 'ember-modifier';
import focus from '@zestia/ember-auto-focus/utils/focus';
import { scheduleOnce } from '@ember/runloop';

export default class FocusModifier extends Modifier {
  didSetup = false;

  modify(element, positional, named) {
    if (this.didSetup) {
      return;
    }

    this.didSetup = true;

    const { disabled } = named;

    if (disabled) {
      return;
    }

    const [selector] = positional;

    if (selector) {
      element = element.querySelector(selector);
    }

    if (!element) {
      return;
    }

    scheduleOnce('afterRender', this, afterRender, element, named);
  }
}

function afterRender(element, options) {
  if (element.contains(document.activeElement)) {
    return;
  }

  focus(element, options);
}
