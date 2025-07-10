import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, settled, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | nesting', function (hooks) {
  setupRenderingTest(hooks);

  let parentDelay;

  const _render = () => {
    return render(
      <template>
        <div class="parent">
          <Tooltip @showDelay={{parentDelay}}>
            Parent
          </Tooltip>

          <div class="child">
            <Tooltip>
              Child
            </Tooltip>
          </div>
        </div>
      </template>
    );
  };

  test('entering a child with a delayed parent aborts the parent', async function (assert) {
    assert.expect(2);

    parentDelay = 1000;

    await _render();

    triggerEvent('.parent', 'mouseenter', { bubbles: false });
    triggerEvent('.child', 'mouseenter', { bubbles: false });

    await settled();

    assert.dom('.tooltip').exists({ count: 1 }).hasText('Child');
  });

  test('entering a child with an already rendered parent hides the parent', async function (assert) {
    assert.expect(4);

    parentDelay = null;

    await _render();

    await triggerEvent('.parent', 'mouseenter', { bubbles: false });

    assert.dom('.tooltip').exists({ count: 1 }).hasText('Parent');

    await triggerEvent('.child', 'mouseenter', { bubbles: false });

    assert.dom('.tooltip').exists({ count: 1 }).hasText('Child');
  });
});
