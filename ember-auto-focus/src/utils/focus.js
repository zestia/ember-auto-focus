/* eslint-disable ember/no-runloop */

import { next } from '@ember/runloop';

export default function focus(element, options) {
  element.dataset.programmaticallyFocused = 'true';
  element.focus(options);
  next(() => delete element.dataset.programmaticallyFocused);
}
