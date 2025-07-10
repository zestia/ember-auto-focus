import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, settled, click, triggerEvent } from '@ember/test-helpers';
import { on } from '@ember/modifier';
import { tracked } from '@glimmer/tracking';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | manual', function (hooks) {
  setupRenderingTest(hooks);

  test('manually showing / hiding test', async function (assert) {
    assert.expect(3);

    const state = new (class {
      @tracked show;
    })();

    await render(
      <template>
        <div>
          <Tooltip @show={{state.show}} />
        </div>
      </template>
    );

    assert.dom('.tooltip').doesNotExist();

    state.show = true;

    await settled();

    assert.dom('.tooltip').exists();

    state.show = false;

    await settled();

    assert.dom('.tooltip').doesNotExist();
  });

  test('mouse/keyboard events do not effect tooltip when manually showing / hiding', async function (assert) {
    assert.expect(6);

    const state = new (class {
      @tracked show;
    })();

    const toggleTooltip = () => {
      state.show = !state.show;
    };

    await render(
      <template>
        <button
          type="button"
          class="tooltipper-element"
          {{on "click" toggleTooltip}}
        >
          <Tooltip @show={{state.show}} />
        </button>
      </template>
    );

    assert.dom('.tooltip').doesNotExist();

    await triggerEvent('.tooltipper-element', 'mouseenter');
    await click('.tooltipper-element');

    assert.dom('.tooltip').exists();

    await triggerEvent('.tooltipper-element', 'mouseleave');

    assert
      .dom('.tooltip')
      .exists(
        'it still shows the tooltip despite the mouse leaving the tooltipper as we are manually showing and hiding'
      );

    await click('.tooltipper-element');

    assert.dom('.tooltip').doesNotExist();

    await triggerEvent('.tooltipper-element', 'focus');
    await click('.tooltipper-element');

    assert.dom('.tooltip').exists();

    await triggerEvent('.tooltipper-element', 'blur');

    assert
      .dom('.tooltip')
      .exists(
        'it still shows the tooltip despite the blur event as we are manually showing and hiding'
      );
  });
});
