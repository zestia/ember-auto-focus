import Modifier from 'ember-modifier';
import focus from '../utils/focus';

export default class OnModifier extends Modifier {
  didInstall() {
    const { disabled } = this.args.named;

    if (disabled) {
      return;
    }

    let el = this.element;

    console.log(el, this.args.positional[0], this.args.named.disabled);

    const selector = this.args.positional[0];

    if (selector) {
      el = el.querySelector(selector);
    }

    if (el) {
      focus(el);
    }
  }
}
