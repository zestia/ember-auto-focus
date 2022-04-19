import Modifier from 'ember-modifier';
import focus from '../utils/focus';
import { scheduleOnce } from '@ember/runloop';

export default class AutoFocusModifier extends Modifier {
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

    scheduleOnce('afterRender', this, afterRender, element);
  }
}

function afterRender(element) {
  if (element.contains(document.activeElement)) {
    return;
  }

  focus(element);
}
