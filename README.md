# @zestia/ember-auto-focus

<a href="http://emberobserver.com/addons/ember-auto-focus"><img src="http://emberobserver.com/badges/ember-auto-focus.svg"></a> &nbsp; <a href="https://david-dm.org/zestia/ember-auto-focus#badge-embed"><img src="https://david-dm.org/zestia/ember-auto-focus.svg"></a> &nbsp; <a href="https://david-dm.org/zestia/ember-auto-focus#dev-badge-embed"><img src="https://david-dm.org/zestia/ember-auto-focus/dev-status.svg"></a> &nbsp; <a href="http://travis-ci.org/zestia/ember-auto-focus"><img src="https://travis-ci.org/zestia/ember-auto-focus.svg?branch=master"></a>

HTML's `autofocus` attribute focuses an element on _page load_.

However, in single page apps the page load event only happens once - so `autofocus` pretty much becomes useless.

## Example

When the auto-focus element is inserted, it will attempt to focus the first child contained within it:

```handlebars
{{#if showField}}
  <AutoFocus>
    <input>
  </AutoFocus>
{{/if}}
```
Alternatively, you can pass in a selector using a positonal param, or by `@selector` argument.

```handlebars
{{#auto-focus ".my-child"}}
  <div class="my-child" tabindex=0></div>
{{/auto-focus}}
```

You can set the disabled attribute to true to prevent autofocusing:

```handlebars
<AutoFocus @disabled={{shouldAutoFocus}}>
   ...
</AutoFocus>
```

### Installation
```
ember install @zestia/ember-auto-focus
```
