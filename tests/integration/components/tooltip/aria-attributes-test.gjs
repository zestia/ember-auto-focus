import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, find, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | aria', function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(async function () {
    await render(
      <template>
        <div>
          <Tooltip />
        </div>
      </template>
    );
  });

  test('the tooltip will be politely announced by screen readers', async function (assert) {
    assert.expect(2);

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').hasAttribute('role', 'tooltip');
    assert.dom('.tooltip').hasAttribute('aria-live', 'polite');
  });

  test('tooltippers are associated with a tooltip', async function (assert) {
    assert.expect(4);

    assert.dom('.tooltipper').doesNotHaveAttribute('aria-describedby');

    await triggerEvent('.tooltipper', 'mouseenter');

    const id = find('.tooltip').getAttribute('id');

    assert.true(/\w+\d+/.test(id));

    assert.dom('.tooltipper').hasAttribute('aria-describedby', id);

    await triggerEvent('.tooltipper', 'mouseleave');

    assert.dom('.tooltipper').doesNotHaveAttribute('aria-describedby');
  });
});
