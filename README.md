# @zestia/ember-auto-focus

<a href="https://badge.fury.io/js/%40zestia%2Fember-auto-focus"><img src="https://badge.fury.io/js/%40zestia%2Fember-auto-focus.svg" alt="npm version" height="18"></a> &nbsp; <a href="http://travis-ci.org/zestia/ember-auto-focus"><img src="https://travis-ci.org/zestia/ember-auto-focus.svg?branch=master"></a> &nbsp; <a href="https://david-dm.org/zestia/ember-auto-focus#badge-embed"><img src="https://david-dm.org/zestia/ember-auto-focus.svg"></a> &nbsp; <a href="https://david-dm.org/zestia/ember-auto-focus#dev-badge-embed"><img src="https://david-dm.org/zestia/ember-auto-focus/dev-status.svg"></a> &nbsp; <a href="http://emberobserver.com/addons/ember-auto-focus"><img src="http://emberobserver.com/badges/ember-auto-focus.svg"></a>

HTML's `autofocus` focuses an element on the first occurence of the attribute. However, in single page apps this can mean autofocus will only work once.

## Example

When the auto-focus component is inserted, it will attempt to focus the first child contained within it:

```handlebars
{{#if this.showField}}
  <AutoFocus>
    <input>
  </AutoFocus>
{{/if}}
```
Alternatively, you can pass in a selector using a positonal param, or by the `@selector` argument.

```handlebars
<AutoFocus @selector=".my-child">
  <div class="my-child" tabindex="0"></div>
</AutoFocus>
```

```handlebars
{{#auto-focus ".my-child"}}
  <div class="my-child" tabindex="0"></div>
{{/auto-focus}}
```

You can set the disabled attribute to true to prevent autofocusing:

```handlebars
<AutoFocus @disabled={{this.shouldAutoFocus}}>
   ...
</AutoFocus>
```

### Installation
```
ember install @zestia/ember-auto-focus
```
