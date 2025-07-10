import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, settled, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | hover', function (hooks) {
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

  test('mouse enter reference', async function (assert) {
    assert.expect(2);

    assert.dom('.tooltip').doesNotExist();

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').exists();
  });

  test('mouse leave reference', async function (assert) {
    assert.expect(2);

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').exists();

    await triggerEvent('.tooltipper', 'mouseleave');

    assert.dom('.tooltip').doesNotExist();
  });

  test('mouse leave tooltip', async function (assert) {
    assert.expect(2);

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').exists();

    await triggerEvent('.tooltip', 'mouseleave');

    assert.dom('.tooltip').doesNotExist();
  });

  test('mouse enter / mouse leave tooltipper', async function (assert) {
    assert.expect(1);

    triggerEvent('.tooltipper', 'mouseenter');
    triggerEvent('.tooltipper', 'mouseleave');

    await settled();

    assert.dom('.tooltip').doesNotExist();
  });

  test('mouse leave tooltip whilst still over tooltipper', async function (assert) {
    assert.expect(1);

    await triggerEvent('.tooltipper', 'mouseenter');
    await triggerEvent('.tooltip', 'mouseleave', { bubbles: false });

    assert.dom('.tooltip').exists();
  });

  test('mouse leave tooltipper whilst still over tooltip', async function (assert) {
    assert.expect(1);

    await triggerEvent('.tooltipper', 'mouseenter');
    await triggerEvent('.tooltip', 'mouseenter');
    await triggerEvent('.tooltipper', 'mouseleave', { bubbles: false });

    assert.dom('.tooltip').exists();
  });
});
