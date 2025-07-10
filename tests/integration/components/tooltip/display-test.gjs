import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';
import { htmlSafe } from '@ember/template';

module('tooltip | display', function (hooks) {
  setupRenderingTest(hooks);

  test('css display none', async function (assert) {
    assert.expect(1);

    const style = htmlSafe('display: none');

    await render(
      <template>
        {{! template-lint-disable no-inline-styles }}
        <div>
          <Tooltip style={{style}} />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.ok(
      true,
      `
      the position cannot be computed if the element is hidden
      because it will not have an offset parent.
      `
    );
  });
});
