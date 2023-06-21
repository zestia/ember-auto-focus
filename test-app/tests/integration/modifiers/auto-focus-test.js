import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('auto-focus', function (hooks) {
  setupRenderingTest(hooks);

  test('it focuses the element', async function (assert) {
    assert.expect(3);

    this.show = true;

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

  test('it can focus a specific child element', async function (assert) {
    assert.expect(1);

    this.selector = '.inner > .foo';

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

  test('it does not focus an element outside of itself', async function (assert) {
    assert.expect(1);

    await render(hbs`
      <div class="focusable" tabindex="0"></div>
      <div {{auto-focus ".focusable"}}></div>
    `);

    assert
      .dom('.focusable')
      .isNotFocused('the selector is scoped to child elements only');
  });

  test('disabled argument (disabled)', async function (assert) {
    assert.expect(1);

    await render(hbs`
      <div class="foo" tabindex="0" {{auto-focus disabled=true}}>/</div>
    `);

    assert.dom('.foo').isNotFocused('does not focus the element');
  });

  test('disabled argument (enabled)', async function (assert) {
    assert.expect(1);

    await render(hbs`
      <div class="foo" tabindex="0" {{auto-focus disabled=false}}>/</div>
    `);

    assert.dom('.foo').isFocused('focus the element');
  });

  test('rendering', async function (assert) {
    assert.expect(2);

    this.focusInOuter = () => assert.step('focusin on parent node');

    await render(hbs`
      <div {{on "focusin" this.focusInOuter}}>
        <input {{auto-focus}} class="foo" aria-label="Example">
      </div>
    `);

    assert.verifySteps(['focusin on parent node']);
  });

  test('nesting', async function (assert) {
    assert.expect(1);

    await render(hbs`
      <div {{auto-focus}} tabindex="0" class="outer">
        <div {{auto-focus}} tabindex="0" class="inner">
        </div>
      </div>
    `);

    assert.dom('.inner').isFocused(
      `child modifiers run before parents, but this scenario behaves as expected
      (because the parent renders first, then the child)`
    );
  });

  test('programmatic focus', async function (assert) {
    assert.expect(2);

    this.focused = (e) => {
      assert
        .dom('.foo')
        .hasAttribute(
          'data-programmatically-focused',
          'true',
          'property is true because this addon focused the element'
        );
    };

    await render(hbs`
      <div
        {{on "focus" this.focused}}
        {{auto-focus}}
        class="foo"
        tabindex="0"
      ></div>
    `);

    assert
      .dom('.foo')
      .doesNotHaveAttribute(
        'data-programmatically-focused',
        'property removed after focus'
      );
  });
});
