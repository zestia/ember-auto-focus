import { next } from '@ember/runloop';

export default function focus(element) {
  element.dataset.programaticallyFocused = true;
  element.focus();
  next(() => delete element.dataset.programaticallyFocused);
}
