import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { focus, render, blur } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | focus', function (hooks) {
  setupRenderingTest(hooks);

  test('focusing (default)', async function (assert) {
    assert.expect(1);

    await render(
      <template>
        <a href="#">
          <Tooltip />
        </a>
      </template>
    );

    await focus('.tooltipper');

    assert.dom('.tooltip').doesNotExist(
      `
      tooltips are not displayed when focus enters a reference element by default.
      though many browsers will display it on touch
      `
    );
  });

  test('focusing (@useFocus)', async function (assert) {
    assert.expect(2);

    await render(
      <template>
        <a href="#">
          <Tooltip @useFocus={{true}} />
        </a>
      </template>
    );

    await focus('.tooltipper');

    assert.dom('.tooltip').exists(
      `
      tooltips are displayed when focus enters a reference element if @useFocus is true.
      `
    );

    await blur('.tooltipper');

    assert.dom('.tooltip').doesNotExist();
  });

  test('focusing a tooltip with interactive children', async function (assert) {
    assert.expect(3);

    await render(
      <template>
        <div class="tooltipper" tabindex="0">
          <Tooltip @useFocus={{true}}>
            Hello
            <a href="#">World</a>
          </Tooltip>
        </div>
      </template>
    );

    assert.dom('.tooltip').doesNotExist();

    await focus('.tooltipper');

    assert.dom('.tooltip').exists();

    await focus('.tooltip a');

    assert
      .dom('.tooltip')
      .exists('it does not hide the tooltip when focusing within the tooltip');
  });

  test('focusing a tooltip with interactive children (rendered in a different output destination)', async function (assert) {
    assert.expect(3);

    await render(
      <template>
        <div class="tooltipper" tabindex="0">
          <Tooltip @useFocus={{true}} @destination="#portal">
            Hello
            <a href="#">World</a>
          </Tooltip>
        </div>

        <div id="portal">
          {{! tooltip rendered here }}
        </div>
      </template>
    );

    assert.dom('.tooltip').doesNotExist();

    await focus('.tooltipper');

    assert.dom('.tooltip').exists();

    await focus('.tooltip a');

    assert
      .dom('.tooltip')
      .exists('it does not hide the tooltip when focusing within the tooltip');
  });
});
