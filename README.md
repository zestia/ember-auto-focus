# @zestia/ember-auto-focus

[![Latest npm release][npm-badge]][npm-badge-url]
[![Ember Observer][ember-observer-badge]][ember-observer-url]

<!-- [![GitHub Actions][github-actions-badge]][github-actions-url] -->

[npm-badge]: https://img.shields.io/npm/v/@zestia/ember-auto-focus.svg
[npm-badge-url]: https://www.npmjs.com/package/@zestia/ember-auto-focus
[github-actions-badge]: https://github.com/zestia/ember-auto-focus/workflows/CI/badge.svg
[github-actions-url]: https://github.com/zestia/ember-auto-focus/actions
[ember-observer-badge]: https://emberobserver.com/badges/-zestia-ember-auto-focus.svg
[ember-observer-url]: https://emberobserver.com/addons/@zestia/ember-auto-focus

HTML's `autofocus` attribute focuses an element on the first occurrence of the attribute. But, does nothing on subsequent renders of the same element.

This addon provides an element modifier, which auto focuses the element when it is inserted into the DOM.

## Installation

```
ember install @zestia/ember-auto-focus
```

Add the following to `~/.npmrc` to pull @zestia scoped packages from Github instead of NPM.

```
@zestia:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=<YOUR_GH_TOKEN>
```

## Demo

https://zestia.github.io/ember-auto-focus

## Example

```handlebars
{{#if this.showField}}
  <input {{auto-focus}} />
{{/if}}
```

## `{{auto-focus}}`

### Arguments

#### `selector`

Optional. This _positional_ argument allows you to auto focus a child element. Useful for occasions when you don't have access to the children.

<details>
  <summary>Example</summary>

```handlebars
<ExampleComponent {{auto-focus '.some-child'}} />
```

</details>

#### `disabled`

Optional. This _named_ argument turns off auto focusing. Note that this behaviour can now also be achieved with a conditional modifier (this wasn't always the case).

## Notes

This modifier has certain benefits over other implementations:

1. It waits until after render, so that in your actions you can be sure `document.activeElement` is as you'd expect ([Example](https://github.com/zestia/ember-auto-focus/blob/845ea30035aa55fb69164e9eb9001c6fe08fa73b/tests/integration/modifiers/auto-focus-test.js#L86-L98)).

2. It compensates for the fact that child modifiers run their installation before parents in the DOM tree. So nesting `{{auto-focus}}` will work as you would expect. ([Example](https://github.com/zestia/ember-auto-focus/blob/845ea30035aa55fb69164e9eb9001c6fe08fa73b/tests/integration/modifiers/auto-focus-test.js#L100-L114)).

3. It allows you to differentiate between an element that was focused by a user interacting with it, and an element that was focused programmatically. Through `element.dataset.programmaticallyFocused`. ([Example](https://github.com/zestia/ember-auto-focus/blob/8ba15763e5b21e5cc7924339dd65521c965ce722/tests/integration/modifiers/auto-focus-test.js#L116-L144))
