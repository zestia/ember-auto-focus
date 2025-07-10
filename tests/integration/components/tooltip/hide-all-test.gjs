import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, click } from '@ember/test-helpers';
import { on } from '@ember/modifier';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | hide all', function (hooks) {
  setupRenderingTest(hooks);

  test('can hide all tooltips', async function (assert) {
    assert.expect(2);

    // hideAllTooltips can be called directly
    // without having to use `@action` to bind `this`.

    const tooltipService = this.owner.lookup('service:tooltip');

    await render(
      <template>
        <div>
          <Tooltip @show={{true}} />
        </div>

        <div>
          <Tooltip @show={{true}} />
        </div>

        <button
          type="button"
          {{on "click" tooltipService.hideAllTooltips}}
        ></button>
      </template>
    );

    assert.dom('.tooltip').exists({ count: 2 });

    await click('button');

    assert.dom('.tooltip').exists({ count: 0 });
  });
});
