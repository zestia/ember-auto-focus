# ember-cli-autofocus

![Ember Observer score](http://emberobserver.com/badges/ember-cli-autofocus.svg)

The `autofocus` attribute of HTML focuses an element on _page load_.

However, in single page apps the page load event only happens once - so `autofocus` pretty much becomes useless.

This add allows you to focus an area of your application

## Example

```handlebars
{{#auto-focus}}
  <input>
{{/auto-focus}}
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
