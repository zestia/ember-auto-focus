import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, waitFor, settled } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import waitForAnimation from 'dummy/tests/helpers/wait-for-animation';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | showing & hiding', function (hooks) {
  setupRenderingTest(hooks);

  test('showing & hiding', async function (assert) {
    assert.expect(8);

    let animations;

    const state = new (class {
      @tracked show;
    })();

    const tooltipShown = () => assert.step('tooltip shown');
    const tooltipHidden = () => assert.step('tooltip hidden');

    await render(
      <template>
        <div>
          <Tooltip
            @show={{state.show}}
            @onShow={{tooltipShown}}
            @onHide={{tooltipHidden}}
          />
        </div>
      </template>
    );

    state.show = true;

    await waitFor(".tooltip[data-showing='true']");

    assert.verifySteps([]);

    animations = await waitForAnimation('.tooltip', {
      animationName: 'fade-in'
    });

    assert.strictEqual(animations.length, 1);

    await settled();

    assert.verifySteps(['tooltip shown']);

    state.show = false;

    await waitFor(".tooltip[data-showing='false']");

    assert.verifySteps([]);

    animations = await waitForAnimation('.tooltip', {
      animationName: 'fade-out'
    });

    assert.strictEqual(animations.length, 1);

    await settled();

    assert.verifySteps(['tooltip hidden']);
  });
});
