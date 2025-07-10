import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, waitFor, triggerEvent, settled } from '@ember/test-helpers';
import { Timer } from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | delays', function (hooks) {
  setupRenderingTest(hooks);

  test('hide delay', async function (assert) {
    assert.expect(4);

    await render(
      <template>
        <div>
          <Tooltip @hideDelay={{100}} />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').hasAttribute('data-showing', 'true');

    const timer = new Timer();

    timer.start();

    triggerEvent('.tooltipper', 'mouseleave');

    await waitFor(".tooltip[data-showing='false']");

    timer.stop();

    timer.assertBetween(100, 150);

    assert.dom('.tooltip').exists();

    await settled();

    assert.dom('.tooltip').doesNotExist();
  });
});
