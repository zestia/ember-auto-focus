import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent, settled } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | api', function (hooks) {
  setupRenderingTest(hooks);

  test('api rendering test', async function (assert) {
    assert.expect(5);

    let api;

    const capture = (_api) => (api = _api);
    const load = () => 'foo';

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{load}} as |tooltip|>
            {{capture tooltip}}
          </Tooltip>
        </div>
      </template>
    );

    assert.dom('.tooltip').doesNotExist();

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.strictEqual(api.data, 'foo');
    assert.strictEqual(api.error, null);

    assert.dom('.tooltip').exists();

    await api.hide();
    await settled();

    assert.dom('.tooltip').doesNotExist();
  });
});
