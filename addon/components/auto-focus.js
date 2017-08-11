import Component from '@ember/component';
import { scheduleOnce } from '@ember/runloop';

const AutoFocusComponent = Component.extend({
  tagName: 'span',

  didInsertElement() {
    this._super(...arguments);
    scheduleOnce('afterRender', this, '_autofocus');
  },

  _autofocus() {
    if (this.get('disabled')) {
      return false;
    }

    const selector = this.getWithDefault('selector', ':first-child');
    const child    = this.get('element').querySelector(selector);

    if (child) {
      child.focus();
    }
  }
});

AutoFocusComponent.reopenClass({
  positionalParams: ['selector']
});

export default AutoFocusComponent;
