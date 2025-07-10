import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | no animation', function (hooks) {
  setupRenderingTest(hooks);

  test('show/hide actions still fire when no animation', async function (assert) {
    assert.expect(6);

    const handleShow = () => assert.step('show');
    const handleHide = () => assert.step('hide');

    await render(
      <template>
        {{! template-lint-disable no-forbidden-elements }}
        <style>
          .tooltip {
            animation: none !important;
          }
        </style>

        <div>
          <Tooltip @onShow={{handleShow}} @onHide={{handleHide}} />
        </div>
      </template>
    );

    assert.dom('.tooltip').doesNotExist();

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').exists();

    await triggerEvent('.tooltipper', 'mouseleave');

    assert.dom('.tooltip').doesNotExist();

    assert.verifySteps(['show', 'hide']);
  });
});
