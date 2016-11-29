import Component from 'ember-component';
import { scheduleOnce } from 'ember-runloop';

const AutoFocusComponent = Component.extend({
  tagName: 'span',

  didInsertElement() {
    this._super(...arguments);
    scheduleOnce('afterRender', this, '_autofocus');
  },

  _autofocus() {
    if (this.getAttr('disabled')) {
      return false;
    }
    const selector = this.getAttr('selector') || '>:first';
    this.$(selector).focus();
  }
});

AutoFocusComponent.reopenClass({
  positionalParams: ['selector']
});

export default AutoFocusComponent;
