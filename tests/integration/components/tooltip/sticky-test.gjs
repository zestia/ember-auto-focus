import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, waitFor, settled, triggerEvent } from '@ember/test-helpers';
import { Timer } from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | sticky', function (hooks) {
  setupRenderingTest(hooks);

  test('stickyness', async function (assert) {
    assert.expect(7);

    const timer = new Timer();

    await render(
      <template>
        <div class="a1">a1
          <Tooltip @showDelay={{1000}} @stickyID="A">a1</Tooltip>
        </div>
        <div class="a2">a2
          <Tooltip @showDelay={{1000}} @stickyID="A">a1</Tooltip>
        </div>
        <div class="b1">b1
          <Tooltip @showDelay={{1000}} @stickyID="B">b1</Tooltip>
        </div>
        <div class="b2">b1
          <Tooltip @showDelay={{1000}} @stickyID="B">b2</Tooltip>
        </div>
      </template>
    );

    // A1

    timer.start();

    triggerEvent('.a1', 'mouseenter');

    await waitFor('.a1 .tooltip');

    assert.dom('.a1 .tooltip').hasAttribute('data-sticky', 'false');

    timer.stop();

    assert.ok(timer.time >= 1000);

    await settled();

    assert.dom('.a1 .tooltip').hasAttribute('data-sticky', 'true');

    // A2

    timer.start();

    await triggerEvent('.a2', 'mouseenter');

    assert.dom('.a2 .tooltip').hasAttribute('data-sticky', 'true');

    timer.stop();

    assert.ok(timer.time < 1000);

    // B1

    timer.start();

    await triggerEvent('.b1', 'mouseenter');

    timer.stop();

    assert.ok(timer.time >= 1000);

    // B2

    timer.start();

    await triggerEvent('.b2', 'mouseenter');

    timer.stop();

    assert.ok(timer.time < 1000);
  });
});
