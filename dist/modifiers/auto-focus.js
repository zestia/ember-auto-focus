import Modifier from 'ember-modifier';
import focus from '../utils/focus.js';
import { renderSettled } from '@ember/renderer';

class AutoFocusModifier extends Modifier {
  didSetup = false;
  async modify(element, positional, named) {
    if (this.didSetup) {
      return;
    }
    this.didSetup = true;
    const {
      disabled
    } = named;
    if (disabled) {
      return;
    }
    await renderSettled();
    const [selector] = positional;
    if (selector) {
      element = element.querySelector(selector);
    }
    if (!element) {
      return;
    }
    if (element.contains(document.activeElement)) {
      return;
    }
    focus(element, named);
  }
}

export { AutoFocusModifier as default };
//# sourceMappingURL=auto-focus.js.map
