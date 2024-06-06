import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, find, rerender } from '@ember/test-helpers';
import autoFocus from '@zestia/ember-auto-focus/modifiers/auto-focus';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';

module('autoFocus', function (hooks) {
  setupRenderingTest(hooks);

  test('it focuses the element', async function (assert) {
    assert.expect(3);

    const state = new (class {
      @tracked show = true;
    })();

    state.show = true;

    await render(<template>
      {{#if state.show}}
        <div class="foo" tabindex="0" {{autoFocus}}></div>
      {{/if}}
    </template>);

    assert.dom('.foo').isFocused('the element is focused on initial render');

    state.show = false;

    await rerender();

    assert
      .dom('.foo')
      .doesNotExist('precondition, element is removed from the DOM');

    state.show = true;

    await rerender();

    assert
      .dom('.foo')
      .isFocused('the element is focused on subsequent renders');
  });

  test('it can focus a specific child element', async function (assert) {
    assert.expect(1);

    const selector = '.inner > .foo';

    await render(<template>
      <div class="outer" {{autoFocus selector}}>
        <div class="inner">
          <div class="foo" tabindex="0"></div>
        </div>
      </div>
    </template>);

    assert
      .dom(selector)
      .isFocused('the element specified by the selector is focused');
  });

  test('it does not focus an element outside of itself', async function (assert) {
    assert.expect(1);

    await render(<template>
      <div class="focusable" tabindex="0"></div>
      <div {{autoFocus ".focusable"}}></div>
    </template>);

    assert
      .dom('.focusable')
      .isNotFocused('the selector is scoped to child elements only');
  });

  test('disabled argument (disabled)', async function (assert) {
    assert.expect(1);

    await render(<template>
      <div class="foo" tabindex="0" {{autoFocus disabled=true}}>/</div>
    </template>);

    assert.dom('.foo').isNotFocused('does not focus the element');
  });

  test('disabled argument (enabled)', async function (assert) {
    assert.expect(1);

    await render(<template>
      <div class="foo" tabindex="0" {{autoFocus disabled=false}}>/</div>
    </template>);

    assert.dom('.foo').isFocused('focus the element');
  });

  test('rendering', async function (assert) {
    assert.expect(2);

    const focusInOuter = () => assert.step('focusin on parent node');

    await render(<template>
      <div {{on "focusin" focusInOuter}}>
        <input {{autoFocus}} class="foo" aria-label="Example" />
      </div>
    </template>);

    assert.verifySteps(['focusin on parent node']);
  });

  test('nesting', async function (assert) {
    assert.expect(1);

    await render(<template>
      <div {{autoFocus}} tabindex="0" class="outer">
        <div {{autoFocus}} tabindex="0" class="inner">
        </div>
      </div>
    </template>);

    assert.dom('.inner').isFocused(
      `child modifiers run before parents, but this scenario behaves as expected
      (because the parent renders first, then the child)`
    );
  });

  test('programmatic focus', async function (assert) {
    assert.expect(2);

    const focused = (e) => {
      assert
        .dom('.foo')
        .hasAttribute(
          'data-programmatically-focused',
          'true',
          'property is true because this addon focused the element'
        );
    };

    await render(<template>
      <div {{on "focus" focused}} {{autoFocus}} class="foo" tabindex="0"></div>
    </template>);

    assert
      .dom('.foo')
      .doesNotHaveAttribute(
        'data-programmatically-focused',
        'property removed after focus'
      );
  });

  test('other options', async function (assert) {
    assert.expect(1);

    await render(<template>
      {{! template-lint-disable no-forbidden-elements}}
      {{! prettier-ignore }}
      <style>
        .parent {
          height: 100px;
          overflow-y: scroll;
        }

        input {
          margin-top: 100px
        }
      </style>
      <div class="parent">
        <button type="button" {{autoFocus preventScroll=true}} />
      </div>
    </template>);

    assert.strictEqual(find('.parent').scrollTop, 0);
  });
});
