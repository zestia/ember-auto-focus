# ember-autofocus

<a href="http://emberobserver.com/addons/ember-autofocus"><img src="http://emberobserver.com/badges/ember-autofocus.svg"></a> &nbsp; <a href="https://david-dm.org/amk221/ember-autofocus#badge-embed"><img src="https://david-dm.org/amk221/ember-autofocus.svg"></a> &nbsp; <a href="https://david-dm.org/amk221/ember-autofocus#dev-badge-embed"><img src="https://david-dm.org/amk221/ember-autofocus/dev-status.svg"></a> &nbsp; <a href="https://codeclimate.com/github/amk221/ember-autofocus"><img src="https://codeclimate.com/github/amk221/ember-autofocus/badges/gpa.svg" /></a> &nbsp; <a href="http://travis-ci.org/amk221/ember-autofocus"><img src="https://travis-ci.org/amk221/ember-autofocus.svg?branch=master"></a>

HTML's `autofocus` attribute focuses an element on _page load_.

However, in single page apps the page load event only happens once - so `autofocus` pretty much becomes useless.

This addon provides you with a helper that focuses the first child contained within it.

## Example

```handlebars
{{#if showField}}
  {{#auto-focus}}
    <input>
  {{/auto-focus}}
{{/if}}
```

Optionally, you can set the `disabled` attribute to true to prevent autofocusing.

### Installation
```
ember install @amk221/ember-autofocus
```