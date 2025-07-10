import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, settled, triggerEvent } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import { assertPosition } from 'dummy/tests/integration/components/tooltip/helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | attach to', function (hooks) {
  setupRenderingTest(hooks);

  test('display tooltip on mouse over tooltipper, but position it next to another element', async function (assert) {
    assert.expect(5);

    const state = new (class {
      @tracked attachTo = '#one';
    })();

    await render(
      <template>
        <div class="parent">
          Hover over me

          <div id="one">
            one
          </div>

          <div id="two">
            two
          </div>

          <Tooltip @attachTo={{state.attachTo}} @position="bottom center" />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.parent > .tooltip').exists();

    assertPosition('.tooltip', { left: 37, top: 33 });

    state.attachTo = '#two';

    await settled();
    await new Promise(requestAnimationFrame);

    assertPosition('.tooltip', { left: 37, top: 42 });
  });
});
