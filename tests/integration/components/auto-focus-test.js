import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';
import { next } from 'ember-runloop';

moduleForComponent('auto-focus', {
  integration: true
});

test('it renders', function(assert) {
  assert.expect(1);

  this.render(hbs `{{auto-focus}}`);

  assert.equal(this.$('span').length, 1,
    'renders as an inline element (ideally there would be no element)');
});


test('it focuses the first child', function(assert) {
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
    assert.ok(this.$('.foo').is(':focus'),
      'first child is focused on initial render');
  });

  next(() => {
    this.set('show', false);
    assert.ok(!this.$('.foo').length,
      'precondition, element is removed from the DOM');
  });

  next(() => {
    this.set('show', true);
    assert.ok(this.$('.foo').is(':focus'),
      'first child is focused on subsequent renders');
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
