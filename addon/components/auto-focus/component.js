import Component from '@ember/component';
import { scheduleOnce } from '@ember/runloop';
import layout from './template';

const AutoFocusComponent = Component.extend({
  layout,
  tagName: 'span',
  classNames: ['auto-focus'],

  didInsertElement() {
    this._super(...arguments);
    scheduleOnce('afterRender', this, '_autofocus');
  },

  _autofocus() {
    if (this.disabled) {
      return false;
    }

    const selector = this.selector || ':first-child';
    const child = this.element.querySelector(selector);

    if (child) {
      child.focus();
    }
  }
});

AutoFocusComponent.reopenClass({
  positionalParams: ['selector']
});

export default AutoFocusComponent;
