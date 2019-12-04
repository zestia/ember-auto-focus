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

  test('it focuses the element', async function(assert) {
    assert.expect(3);

    this.set('show', true);

    await render(hbs`
      {{#if this.show}}
        <div class="foo" tabindex="0" {{auto-focus}}></div>
      {{/if}}
    `);

    assert.dom('.foo').isFocused('the element is focused on initial render');

    this.set('show', false);

    assert
      .dom('.foo')
      .doesNotExist('precondition, element is removed from the DOM');

    this.set('show', true);

    assert
      .dom('.foo')
      .isFocused('the element is focused on subsequent renders');
  });

  test('it can focus a specific child element', async function(assert) {
    assert.expect(1);

    this.set('selector', '.inner > .foo');

    await render(hbs`
      <div class="outer" {{auto-focus this.selector}}>
        <div class="inner">
          <div class="foo" tabindex="0"></div>
        </div>
      </div>
    `);

    assert
      .dom(this.selector)
      .isFocused('the element specified by the selector is focused');
  });

  test('it does not focus an element outside of itself', async function(assert) {
    assert.expect(1);

    await render(hbs`
      <div class="focusable" tabindex="0"></div>
      <div {{auto-focus ".focusable"}}></div>
    `);

    assert
      .dom('.focusable')
      .isNotFocused('the selector is scoped to child elements only');
  });

  test('disabled argument', async function(assert) {
    assert.expect(1);

    await render(hbs`
      <div class="foo" tabindex="0" {{auto-focus disabled=true}}>/</div>
    `);

    assert.dom('.foo').isNotFocused('does not focus the element');
  });

  test('enabled argument', async function(assert) {
    assert.expect(1);

    await render(hbs`
      <div class="foo" tabindex="0" {{auto-focus disabled=false}}>/</div>
    `);

    assert.dom('.foo').isFocused('focus the element');
  });

  test('programatic focus', async function(assert) {
    assert.expect(2);

    render(hbs`
      <div class="foo" tabindex="0" {{auto-focus}}>/</div>
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
