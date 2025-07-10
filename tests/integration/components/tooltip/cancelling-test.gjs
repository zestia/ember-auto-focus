import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent, settled } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import { wait } from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | cancelling', function (hooks) {
  setupRenderingTest(hooks);

  test('tooltips scheduled to show, will be cancelled', async function (assert) {
    assert.expect(1);

    const state = new (class {
      @tracked show = true;
    })();

    await render(
      <template>
        <div>
          <Tooltip @showDelay={{1000}} @show={{state.show}} />
        </div>
      </template>
    );

    triggerEvent('.tooltipper', 'mouseenter');

    await wait(500);

    state.show = false;

    await settled();

    assert.dom('.tooltip').doesNotExist();
  });
});
