import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | custom position', function (hooks) {
  setupRenderingTest(hooks);

  test('can position the tooltip using a function', async function (assert) {
    assert.expect(2);

    let referencePosition;

    const position = (_position) => {
      referencePosition = _position;

      return 'left top';
    };

    await render(
      <template>
        <div>
          <Tooltip @position={{position}} />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.strictEqual(referencePosition, 'middle center');

    assert.dom('.tooltip').hasAttribute('data-position', 'left top');
  });

  test('no position', async function (assert) {
    assert.expect(1);

    await render(
      <template>
        <div>
          <Tooltip />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').hasAttribute('data-position', 'bottom center');
  });

  test('invalid position', async function (assert) {
    assert.expect(2);

    await render(
      <template>
        <div>
          <Tooltip @position="foo" />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert
      .dom('.tooltip')
      .hasAttribute('data-position', 'foo')
      .hasAttribute('style', 'top: NaNpx; left: NaNpx');
  });
});
