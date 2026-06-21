import Modifier from 'ember-modifier';
import focus from '../utils/focus.js';
import { scheduleOnce } from '@ember/runloop';

/* eslint-disable ember/no-runloop */

class AutoFocusModifier extends Modifier {
  didSetup = false;
  modify(element, positional, named) {
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

export { AutoFocusModifier as default };
//# sourceMappingURL=auto-focus.js.map
