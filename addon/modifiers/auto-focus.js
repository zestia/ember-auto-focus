import Modifier from 'ember-modifier';
import focus from '../utils/focus';
import { scheduleOnce } from '@ember/runloop';

export default class AutoFocusModifier extends Modifier {
  didInstall() {
    const { disabled } = this.args.named;

    if (disabled) {
      return;
    }

    let { element } = this;

    const selector = this.args.positional[0];

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
