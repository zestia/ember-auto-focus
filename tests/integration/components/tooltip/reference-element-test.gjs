import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, find, triggerEvent } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | reference', function (hooks) {
  setupRenderingTest(hooks);

  test('can specify a reference element to attach to', async function (assert) {
    assert.expect(4);

    const state = new (class {
      @tracked referenceElement;
    })();

    await render(
      <template>
        <div class="parent">
          <Tooltip @element={{state.referenceElement}} />
        </div>

        <div class="reference-element-1"></div>
        <div class="reference-element-2"></div>
      </template>
    );

    // HTMLElemnt

    state.referenceElement = find('.reference-element-1');

    await triggerEvent('.reference-element-1', 'mouseenter');

    assert.dom('.parent > .tooltip').exists();

    await triggerEvent('.reference-element-1', 'mouseleave');

    assert.dom('.tooltip').doesNotExist();

    // Selector

    state.referenceElement = '.reference-element-2';

    await triggerEvent('.reference-element-1', 'mouseenter');

    assert.dom('.parent > .tooltip').doesNotExist();

    await triggerEvent('.reference-element-1', 'mouseleave');
    await triggerEvent('.reference-element-2', 'mouseenter');

    assert.dom('.parent > .tooltip').exists();
  });
});
