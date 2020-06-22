# @zestia/ember-auto-focus

<p>
  <a href="http://travis-ci.org/zestia/ember-auto-focus">
    <img src="https://travis-ci.org/zestia/ember-auto-focus.svg?branch=master">
  </a>

  <a href="https://david-dm.org/zestia/ember-auto-focus#badge-embed">
    <img src="https://david-dm.org/zestia/ember-auto-focus.svg">
  </a>

  <a href="https://david-dm.org/zestia/ember-auto-focus#dev-badge-embed">
    <img src="https://david-dm.org/zestia/ember-auto-focus/dev-status.svg">
  </a>

  <a href="https://emberobserver.com/addons/@zestia/ember-auto-focus">
    <img src="https://emberobserver.com/badges/-zestia-ember-auto-focus.svg">
  </a>

  <img src="https://img.shields.io/badge/Ember-%3E%3D%203.12-brightgreen">
</p>

HTML's `autofocus` attribute focuses an element on the first occurence of the attribute. But, does nothing on subsquent renders of the same element.

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
  <input {{auto-focus}}>
{{/if}}
```

Alternatively, you can pass in a selector:

```handlebars
<div {{auto-focus ".my-child"}}>
  <div class="my-child" tabindex="0"></div>
</div>
```

You can set disabled to true to prevent autofocusing:

```handlebars
<div {{auto-focus disabled=this.shouldAutoFocus}} tabindex="0">
   ...
</div>
```

## Differentiating between user focus and programmatic focus

Sometimes it's useful to know whether the element that received focus, did so via a user interacting with it, or by _your code_.

This addon sets a temporary data attribute on the element being focused. `element.dataset.programmaticallyFocused` which will be true if focused by this addon, and false if focused by the user using your app.
