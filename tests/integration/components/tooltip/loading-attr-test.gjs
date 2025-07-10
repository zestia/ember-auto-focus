import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, triggerEvent, settled } from '@ember/test-helpers';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | loading attributes', function (hooks) {
  setupRenderingTest(hooks);

  test('tooltip informs tooltipper it is loading', async function (assert) {
    assert.expect(3);

    const deferred = Promise.withResolvers();

    const load = () => deferred.promise;

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{load}} />
        </div>
      </template>
    );

    assert.dom('.tooltipper').doesNotHaveAttribute('data-loading');

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltipper').hasAttribute('data-loading', 'true');

    deferred.resolve();

    await settled();

    assert.dom('.tooltipper').doesNotHaveAttribute('data-loading');
  });
});
