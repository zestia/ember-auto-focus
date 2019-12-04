import { modifier } from 'ember-modifier';
import focus from '../utils/focus';

export default modifier((element, [selector], { disabled }) => {
  if (disabled) {
    return;
  }

  let el = element;

  if (selector) {
    el = el.querySelector(selector);
  }

  if (el) {
    focus(el);
  }
});
