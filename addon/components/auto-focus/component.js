import Component from '@ember/component';
import { scheduleOnce, next } from '@ember/runloop';
import layout from './template';

export default Component.extend({
  layout,
  tagName: 'span',
  classNames: ['auto-focus'],

  didInsertElement() {
    this._super(...arguments);
    scheduleOnce('afterRender', this, '_autofocus');
  },

  _autofocus() {
    if (this.disabled) {
      return;
    }

    const selector = this.selector || ':first-child';
    const element = this.element.querySelector(selector);

    if (element) {
      element.dataset.programaticallyFocused = true;
      element.focus();
      next(() => delete element.dataset.programaticallyFocused);
    }
  }
});
