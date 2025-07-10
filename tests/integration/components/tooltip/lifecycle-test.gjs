import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, findAll, waitUntil, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | lifecycle', function (hooks) {
  setupRenderingTest(hooks);

  test('multiple tooltips can be present at a time', async function (assert) {
    assert.expect(2);

    const tooltipService = this.owner.lookup('service:tooltip');

    // Move mouse across all tooltippers
    // The first ones will be animating out as the
    // newer ones are animating in (except for the fact
    // that we delay starting the hide animation for
    // test purposes)

    await render(
      <template>
        <div class="t1">1 <Tooltip @hideDelay={{300}}>1</Tooltip></div>
        <div class="t2">2 <Tooltip @hideDelay={{200}}>2</Tooltip></div>
        <div class="t3">3 <Tooltip @hideDelay={{100}}>3</Tooltip></div>
      </template>
    );

    triggerEvent('.t1', 'mouseenter');

    await waitUntil(() => findAll('.tooltip').length === 1);

    triggerEvent('.t1', 'mouseleave');
    triggerEvent('.t2', 'mouseenter');

    await waitUntil(() => findAll('.tooltip').length === 2);

    triggerEvent('.t2', 'mouseleave');
    triggerEvent('.t3', 'mouseenter');

    await waitUntil(() => findAll('.tooltip').length === 3);

    assert.strictEqual(tooltipService.tooltips.length, 3);

    triggerEvent('.t3', 'mouseleave');

    await waitUntil(() => findAll('.tooltip').length === 2);
    await waitUntil(() => findAll('.tooltip').length === 1);
    await waitUntil(() => findAll('.tooltip').length === 0);

    assert.strictEqual(tooltipService.tooltips.length, 0);
  });
});
