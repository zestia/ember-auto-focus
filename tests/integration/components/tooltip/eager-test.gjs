import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, settled, waitUntil, triggerEvent } from '@ember/test-helpers';
import {
  Timer,
  wait,
  hasText
} from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | eager loading', function (hooks) {
  setupRenderingTest(hooks);

  test('load time is less than the show delay', async function (assert) {
    assert.expect(2);

    const load = async () => {
      await wait(50);
      return { greeting: 'Hello World' };
    };

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{load}} @showDelay={{100}} as |tooltip|>
            {{tooltip.data.greeting}}
          </Tooltip>
        </div>
      </template>
    );

    const timer = new Timer();

    timer.start();

    triggerEvent('.tooltipper', 'mouseenter');

    await waitUntil(() => hasText('.tooltip', 'Hello World'));

    timer.stop();

    timer.assertBetween(100, 150); // combined show delay and load duration

    timer.start();

    await settled();

    timer.stop();

    timer.assertBetween(280, 350); // animation duration
  });

  test('load time is more than the show delay', async function (assert) {
    assert.expect(2);

    const load = async () => {
      await wait(1000);
      return { greeting: 'Hello World' };
    };

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{load}} @showDelay={{100}} as |tooltip|>
            {{tooltip.data.greeting}}
          </Tooltip>
        </div>
      </template>
    );

    const timer = new Timer();

    timer.start();

    triggerEvent('.tooltipper', 'mouseenter');

    await waitUntil(() => hasText('.tooltip', 'Hello World'));

    timer.stop();

    timer.assertBetween(1000, 1100); // combined show delay and load duration

    await triggerEvent('.tooltipper', 'mouseleave');

    timer.start();

    await triggerEvent('.tooltipper', 'mouseenter');

    timer.stop();

    timer.assertBetween(400, 450); // combined show delay and animation duration (already loaded)
  });
});
