import { next } from '@ember/runloop';

export default function focus(element) {
  element.dataset.programmaticallyFocused = 'true';
  element.focus();
  next(() => delete element.dataset.programmaticallyFocused);
}
