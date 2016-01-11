import Component from 'ember-component';
import { scheduleOnce } from 'ember-runloop';

export default Component.extend({
  tagName: 'span',

  didInsertElement() {
    this._super(...arguments);
    scheduleOnce('afterRender', this, '_autofocus');
  },

  _autofocus() {
    if (!this.getAttr('disabled')) {
      this.$('>:first').focus();
    }
  }
});
