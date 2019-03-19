import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render, find } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('auto-focus', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function(assert) {
    assert.expect(1);

    await render(hbs`{{component "auto-focus"}}`);

    assert
      .dom('span.auto-focus')
      .exists({ count: 1 }, 'renders as an inline element (ideally there would be no element!)');
  });

  test('it focuses the first child by default', async function(assert) {
    assert.expect(3);

    this.set('show', true);

    await render(hbs`
      {{#if this.show}}
        {{#auto-focus}}
          <div class="foo" tabindex="0"></div>
        {{/auto-focus}}
      {{/if}}
    `);

    assert.ok(document.activeElement === find('.foo'), 'first child is focused on initial render');

    this.set('show', false);

    assert.dom('.foo').exists({ count: 0 }, 'precondition, element is removed from the DOM');

    this.set('show', true);

    assert.ok(
      document.activeElement === find('.foo'),
      'first child is focused on subsequent renders'
    );
  });

  test('it can focus a specific child element', async function(assert) {
    assert.expect(1);

    this.set('selector', '.outer > .inner > .foo');

    await render(hbs`
      {{! template-lint-disable no-implicit-this }}
      {{#auto-focus selector}}
        <div class="outer">
          <div class="inner">
            <div class="foo" tabindex="0"></div>
          </div>
        </div>
      {{/auto-focus}}
    `);

    assert.ok(
      document.activeElement === find(this.selector),
      'focuses the element specified by the selector'
    );
  });

  test('it does not focus any old element', async function(assert) {
    assert.expect(1);

    await render(hbs`
      <div class="focusable" tabindex=0></div>
      {{#auto-focus ".focusable"}}{{/auto-focus}}
    `);

    assert.ok(
      document.activeElement !== find('.focusable'),
      'selector should be scoped to child elements only'
    );
  });

  test('disabling', async function(assert) {
    assert.expect(1);

    await render(hbs`
      {{#auto-focus disabled=true}}
        <div class="foo" tabindex=0></div>
      {{/auto-focus}}
    `);

    assert.ok(
      document.activeElement !== find('.foo'),
      'does not focus the first child if disabled'
    );
  });
});
