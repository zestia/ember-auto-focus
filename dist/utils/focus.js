import { next } from '@ember/runloop';

/* eslint-disable ember/no-runloop */

function focus(element, options) {
  element.dataset.programmaticallyFocused = 'true';
  element.focus(options);
  next(() => delete element.dataset.programmaticallyFocused);
}

export { focus as default };
//# sourceMappingURL=focus.js.map
