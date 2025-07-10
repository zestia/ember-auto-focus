import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | basic', function (hooks) {
  setupRenderingTest(hooks);

  test('basic rendering test', async function (assert) {
    assert.expect(7);

    await render(
      <template>
        <div class="parent"><Tooltip class="example" /></div>
      </template>
    );

    assert.dom('.parent').hasClass('tooltipper');
    assert.dom('.tooltipper > span.__tooltip__').isNotVisible();
    assert.dom('.example').doesNotExist();
    assert.dom('.tooltip').doesNotExist();

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltipper > .tooltip').exists();
    assert.dom('.tooltip').hasClass('example');
    assert.dom('.tooltipper').hasText(/^$/);
  });
});
