import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, settled, waitUntil, triggerEvent } from '@ember/test-helpers';
import {
  Timer,
  wait,
  hasText
} from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | lazy loading', function (hooks) {
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
          <Tooltip
            @onLoad={{load}}
            @eager={{false}}
            @showDelay={{100}}
            as |tooltip|
          >
            {{#if tooltip.data}}
              {{tooltip.data.greeting}}
            {{else}}
              Loading...
            {{/if}}
          </Tooltip>
        </div>
      </template>
    );

    const timer = new Timer();

    timer.start();

    triggerEvent('.tooltipper', 'mouseenter');

    await waitUntil(() => hasText('.tooltip', 'Loading...'));
    await waitUntil(() => hasText('.tooltip', 'Hello World'));

    timer.stop();

    timer.assertBetween(150, 200); // combined show delay and load duration

    timer.start();

    await settled();

    timer.stop();

    timer.assertBetween(240, 300); // animation duration
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
          <Tooltip
            @onLoad={{load}}
            @eager={{false}}
            @showDelay={{100}}
            as |tooltip|
          >
            {{#if tooltip.data}}
              {{tooltip.data.greeting}}
            {{else}}
              Loading...
            {{/if}}
          </Tooltip>
        </div>
      </template>
    );

    const timer = new Timer();

    timer.start();

    triggerEvent('.tooltipper', 'mouseenter');

    await waitUntil(() => hasText('.tooltip', 'Loading...'));
    await waitUntil(() => hasText('.tooltip', 'Hello World'));

    timer.stop();

    timer.assertBetween(1100, 1200); // combined show delay and load duration

    await triggerEvent('.tooltipper', 'mouseleave');

    timer.start();

    await triggerEvent('.tooltipper', 'mouseenter');

    timer.stop();

    timer.assertBetween(400, 450); // combined show delay and animation duration
  });
});
