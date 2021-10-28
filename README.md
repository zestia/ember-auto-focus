# @zestia/ember-auto-focus

<p>
  <!--
  <a href="https://github.com/zestia/ember-auto-focus/actions/workflows/ci.yml">
    <img src="https://github.com/zestia/ember-auto-focus/actions/workflows/ci.yml/badge.svg">
  </a>
  -->

  <a href="https://david-dm.org/zestia/ember-auto-focus#badge-embed">
    <img src="https://david-dm.org/zestia/ember-auto-focus.svg">
  </a>

  <a href="https://david-dm.org/zestia/ember-auto-focus#dev-badge-embed">
    <img src="https://david-dm.org/zestia/ember-auto-focus/dev-status.svg">
  </a>

  <a href="https://emberobserver.com/addons/@zestia/ember-auto-focus">
    <img src="https://emberobserver.com/badges/-zestia-ember-auto-focus.svg">
  </a>

  <img src="https://img.shields.io/badge/Ember-%3E%3D%203.16-brightgreen">
</p>

HTML's `autofocus` attribute focuses an element on the first occurrence of the attribute. But, does nothing on subsequent renders of the same element.

This addon provides an element modifier, which auto focuses the element when it is inserted into the DOM.

## Installation

```
ember install @zestia/ember-auto-focus
```

## Demo

https://zestia.github.io/ember-auto-focus/

## Example

```handlebars
{{#if this.showField}}
  <input {{auto-focus}} />
{{/if}}
```

Alternatively, you can pass in a selector:

```handlebars
<div {{auto-focus '.my-child'}}>
  <div class='my-child' tabindex='0'></div>
</div>
```

You can set disabled to true to prevent autofocusing:

```handlebars
<div {{auto-focus disabled=this.shouldAutoFocus}} tabindex='0'>
  ...
</div>
```

## Notes

This modifier has certain benefits over other implementations:

1. It waits until after render, so that in your actions you can be sure `document.activeElement` is as you'd expect ([Example](https://github.com/zestia/ember-auto-focus/blob/845ea30035aa55fb69164e9eb9001c6fe08fa73b/tests/integration/modifiers/auto-focus-test.js#L86-L98)).

2. It compensates for the fact that child modifiers run their installation before parents in the DOM tree, so nesting `{{auto-focus}}` would not work as you might expect. ([Example](https://github.com/zestia/ember-auto-focus/blob/845ea30035aa55fb69164e9eb9001c6fe08fa73b/tests/integration/modifiers/auto-focus-test.js#L100-L114)).

3. It allows you to differentiate between an element that was focused by a user interacting with it, and an element that was focused programmatically. Through `element.dataset.programmaticallyFocused`. ([Example](https://github.com/zestia/ember-auto-focus/blob/8ba15763e5b21e5cc7924339dd65521c965ce722/tests/integration/modifiers/auto-focus-test.js#L116-L144))
