import Component from '@ember/component';
import focus from '../../utils/focus';
import layout from './template';

export default Component.extend({
  layout,
  tagName: '',

  actions: {
    autoFocus(element) {
      if (this.disabled) {
        return;
      }

      const selector = this.selector || ':first-child';
      const childElement = element.querySelector(selector);

      if (childElement) {
        focus(childElement);
      }
    }
  }
});
