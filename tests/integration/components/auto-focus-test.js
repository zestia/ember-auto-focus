import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import {
  render,
  settled,
  waitUntil,
  getSettledState,
  find
} from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('auto-focus', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function(assert) {
    assert.expect(1);

    await render(hbs`<AutoFocus />`);

    assert
      .dom('span.auto-focus')
      .exists({ count: 1 }, 'renders as an inline element (ideally there would be no element!)');
  });

  test('it focuses the first child by default', async function(assert) {
    assert.expect(3);

    this.set('show', true);

    await render(hbs`
      {{#if this.show}}
        <AutoFocus>
          <div class="foo" tabindex="0"></div>
        </AutoFocus>
      {{/if}}
    `);

    assert.dom('.foo').isFocused('first child is focused on initial render');

    this.set('show', false);

    assert.dom('.foo').exists({ count: 0 }, 'precondition, element is removed from the DOM');

    this.set('show', true);

    assert.dom('.foo').isFocused('first child is focused on subsequent renders');
  });

  test('it can focus a specific child element', async function(assert) {
    assert.expect(1);

    this.set('selector', '.outer > .inner > .foo');

    await render(hbs`
      <AutoFocus @selector={{this.selector}}>
        <div class="outer">
          <div class="inner">
            <div class="foo" tabindex="0"></div>
          </div>
        </div>
      </AutoFocus>
    `);

    assert.dom(this.selector).isFocused('focuses the element specified by the selector');
  });

  test('it does not focus an element outside of itself', async function(assert) {
    assert.expect(1);

    await render(hbs`
      <div class="focusable" tabindex="0"></div>
      <AutoFocus @selector=".focusable"></AutoFocus>
    `);

    assert.dom('.focusable').isNotFocused('selector should be scoped to child elements only');
  });

  test('disabling', async function(assert) {
    assert.expect(1);

    await render(hbs`
      <AutoFocus @disabled={{true}}>
        <div class="foo" tabindex="0">/</div>
      </AutoFocus>
    `);

    assert.dom('.foo').isNotFocused('does not focus the first child if disabled');
  });

  test('programatic focus dataset property', async function(assert) {
    assert.expect(2);

    render(hbs`
      <AutoFocus>
        <div class="foo" tabindex="0">/</div>
      </AutoFocus>
    `); // Intentionally no await

    await waitUntil(() => {
      const state = getSettledState();

      return state.hasPendingTimers === true && state.hasRunLoop === false;
    });

    assert.strictEqual(
      find('.foo').dataset.programaticallyFocused,
      'true',
      'property is true because this addon focused the element'
    );

    await settled();

    assert.strictEqual(
      find('.foo').dataset.programaticallyFocused,
      undefined,
      'property removed after focus'
    );
  });
});
