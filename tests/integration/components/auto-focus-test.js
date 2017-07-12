import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import { next } from '@ember/runloop';

moduleForComponent('auto-focus', {
  integration: true
});

test('it renders', function(assert) {
  assert.expect(1);

  this.render(hbs `{{auto-focus}}`);

  assert.equal(this.$('span').length, 1,
    'renders as an inline element (ideally there would be no element)');
});


test('it focuses the first child by default', function(assert) {
  assert.expect(3);

  this.set('show', true);

  this.render(hbs `
    {{#if show}}
      {{#auto-focus}}
        <div class='foo' tabindex=0></div>
      {{/auto-focus}}
    {{/if}}
  `);

  next(() => {
    assert.ok(document.activeElement === this.$('.foo').get(0),
      'first child is focused on initial render');
  });

  next(() => {
    this.set('show', false);
    assert.ok(!this.$('.foo').length,
      'precondition, element is removed from the DOM');
  });

  next(() => {
    this.set('show', true);
    assert.ok(document.activeElement === this.$('.foo').get(0),
      'first child is focused on subsequent renders');
  });
});


test('it can focus a specific child element', function(assert) {
  assert.expect(1);

  this.set('selector', '.outer > .inner > .foo');

  this.render(hbs `
    {{#auto-focus selector}}
      <div class="outer">
        <div class="inner">
          <div class="foo" tabindex=0"></div>
        </div>
      </div>
    {{/auto-focus}}
  `);

  next(() => {
    assert.ok(document.activeElement === this.$(this.get('selector')).get(0),
      'focuses the element specified by the selector');
  });
});


test('it does not focus any old element', function(assert) {
  assert.expect(1);

  this.render(hbs `
    <div class="focusable" tabindex=0></div>
    {{#auto-focus '.focusable'}}{{/auto-focus}}
  `);

  next(() => {
    assert.ok(document.activeElement !== this.$('.focusable').get(0),
      'selector should be scoped to child elements only');
  });
});


test('disabling', function(assert) {
  assert.expect(1);

  this.render(hbs `
    {{#auto-focus disabled=true}}
      <div class='foo' tabindex=0></div>
    {{/auto-focus}}
  `);

  next(() => {
    assert.ok(!this.$('.foo').is(':focus'),
      'does not focus the first child if disabled');
  });
});
