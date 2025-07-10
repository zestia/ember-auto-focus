import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import {
  render,
  waitUntil,
  settled,
  triggerEvent,
  focus
} from '@ember/test-helpers';
import {
  wait,
  hasText,
  assertPosition
} from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | loading data', function (hooks) {
  setupRenderingTest(hooks);

  test('loading data', async function (assert) {
    assert.expect(6);

    const deferred = Promise.withResolvers();

    const load = () => {
      assert.step('load tooltip');

      return deferred.promise;
    };

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{load}} as |tooltip|>
            {{tooltip.data.greeting}}
          </Tooltip>
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.verifySteps(['load tooltip']);

    assert.dom('.tooltip').doesNotExist();

    deferred.resolve({ greeting: 'Hello World' });

    await settled();

    assert.dom('.tooltip').containsText('Hello World');

    await triggerEvent('.tooltipper', 'mouseleave');
    await triggerEvent('.tooltipper', 'mouseenter');

    assert.verifySteps([]);

    assert.dom('.tooltip').containsText('Hello World');
  });

  test('mouse enter / loading data', async function (assert) {
    assert.expect(3);

    const load = () => assert.step('loading data');

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{load}} />
        </div>
      </template>
    );

    triggerEvent('.tooltipper', 'mouseenter');
    triggerEvent('.tooltipper', 'mouseenter');

    await settled();

    assert.verifySteps(['loading data']);

    assert.dom('.tooltip').exists();
  });

  test('mouse leave / loading data', async function (assert) {
    assert.expect(3);

    const load = () => assert.step('loading data');

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{load}} />
        </div>
      </template>
    );

    triggerEvent('.tooltipper', 'mouseenter');
    triggerEvent('.tooltipper', 'mouseleave');

    await settled();

    assert.verifySteps(['loading data']);

    assert.dom('.tooltip').doesNotExist();
  });

  test('focus / loading data', async function (assert) {
    assert.expect(3);

    const load = () => assert.step('loading data');

    await render(
      <template>
        <button type="button">
          <Tooltip @onLoad={{load}} @useFocus={{true}} />
        </button>
      </template>
    );

    await focus('.tooltipper');

    assert.verifySteps(['loading data']);

    assert.dom('.tooltip').exists();
  });

  test('blur / loading data', async function (assert) {
    assert.expect(3);

    const load = () => assert.step('loading data');

    await render(
      <template>
        <button type="button">
          <Tooltip @onLoad={{load}} @useFocus={{true}} />
        </button>
      </template>
    );

    triggerEvent('.tooltipper', 'focus');
    triggerEvent('.tooltipper', 'blur');

    await settled();

    assert.verifySteps(['loading data']);

    assert.dom('.tooltip').doesNotExist();
  });

  test('loading data with show arg renders correct position straight away', async function (assert) {
    assert.expect(2);

    const load = async () => {
      await wait(50);
      return { greeting: 'Hello World' };
    };

    render(
      <template>
        <div>
          Hover over me

          <Tooltip
            @onLoad={{load}}
            @show={{true}}
            @position="bottom center"
            as |tooltip|
          >
            {{tooltip.data.greeting}}
          </Tooltip>
        </div>
      </template>
    );

    await waitUntil(() => hasText('.tooltip', 'Hello World'));

    assertPosition('.tooltip', { left: 8, top: 14 });
  });
});
