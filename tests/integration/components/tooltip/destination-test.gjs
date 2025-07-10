import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent } from '@ember/test-helpers';
import { modifier } from 'ember-modifier';
import { tracked } from '@glimmer/tracking';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | destination', function (hooks) {
  setupRenderingTest(hooks);

  test('can specify an output destination', async function (assert) {
    assert.expect(3);

    const state = new (class {
      @tracked elsewhere;
    })();

    const register = modifier((element) => (state.elsewhere = element));

    await render(
      <template>
        <div>
          <Tooltip @destination={{state.elsewhere}} />
        </div>

        <div class="elsewhere" {{register}}></div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltipper > .__tooltip__').exists();
    assert.dom('.tooltipper > .tooltip').doesNotExist();
    assert.dom('.elsewhere > .tooltip').exists();
  });
});
