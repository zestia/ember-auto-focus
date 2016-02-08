# ember-cli-autofocus

<a href="http://emberobserver.com/addons/ember-cli-autofocus"><img src="http://emberobserver.com/badges/ember-cli-autofocus.svg"></a> &nbsp; <a href="https://david-dm.org/amk221/ember-cli-autofocus#badge-embed"><img src="https://david-dm.org/amk221/ember-cli-autofocus.svg"></a> &nbsp; <a href="https://david-dm.org/amk221/ember-cli-autofocus#dev-badge-embed"><img src="https://david-dm.org/amk221/ember-cli-autofocus/dev-status.svg"></a> &nbsp; <a href="https://codeclimate.com/github/amk221/ember-cli-autofocus"><img src="https://codeclimate.com/github/amk221/ember-cli-autofocus/badges/gpa.svg" /></a> &nbsp; <a href="http://travis-ci.org/amk221/ember-cli-autofocus"><img src="https://travis-ci.org/amk221/ember-cli-autofocus.svg?branch=master"></a>

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

## Installation

* `git clone` this repository
* `npm install`
* `bower install`

## Running

* `ember server`
* Visit your app at http://localhost:4200.

## Running Tests

* `npm test` (Runs `ember try:testall` to test your addon against multiple Ember versions)
* `ember test`
* `ember test --server`

## Building

* `ember build`

For more information on using ember-cli, visit [http://www.ember-cli.com/](http://www.ember-cli.com/).
