import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent, settled } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import { wait } from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | destroying', function (hooks) {
  setupRenderingTest(hooks);

  let state;

  hooks.beforeEach(function () {
    state = new (class {
      @tracked show = true;
    })();
  });

  test('destroying a tooltipper when about to show its tooltip', async function (assert) {
    assert.expect(2);

    await render(
      <template>
        {{#if state.show}}
          <div id="tooltipper"></div>
        {{/if}}

        <Tooltip @element="#tooltipper" @showDelay={{1000}} />
      </template>
    );

    triggerEvent('.tooltipper', 'mouseenter');

    await wait(500);

    state.show = false;

    await settled();

    assert.dom('.tooltip').doesNotExist();
    assert.dom('.tooltipper').doesNotExist();
  });

  test('destroying a tooltipper when already showing a tooltip', async function (assert) {
    assert.expect(2);

    await render(
      <template>
        {{#if state.show}}
          <div id="tooltipper"></div>
        {{/if}}

        <Tooltip @element="#tooltipper" />
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    state.show = false;

    await settled();

    assert.dom('.tooltip').exists();
    assert.dom('.tooltipper').doesNotExist();
  });

  test('destroying a tooltip when attached to a tooltipper', async function (assert) {
    assert.expect(5);

    await render(
      <template>
        <div id="tooltipper"></div>

        {{#if state.show}}
          <Tooltip @element="#tooltipper" />
        {{/if}}
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').exists();
    assert.dom('.tooltipper').exists();

    state.show = false;

    await settled();

    assert.dom('.tooltip').doesNotExist();
    assert.dom('#tooltipper').doesNotHaveClass('tooltipper');
    assert.dom('#tooltipper').doesNotHaveAttribute('aria-describedby');
  });
});
