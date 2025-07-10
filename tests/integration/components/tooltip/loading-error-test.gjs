import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { render, settled, triggerEvent } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | loading error', function (hooks) {
  setupRenderingTest(hooks);

  test('loading error', async function (assert) {
    assert.expect(3);

    const deferred1 = Promise.withResolvers();
    const deferred2 = Promise.withResolvers();

    const state = new (class {
      @tracked load = () => deferred1.promise;
    })();

    await render(
      <template>
        <div>
          <Tooltip @onLoad={{state.load}} as |tooltip|>
            {{#if tooltip.data}}
              {{tooltip.data.greeting}}
            {{else}}
              {{tooltip.error.message}}
            {{/if}}
          </Tooltip>
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    assert.dom('.tooltip').doesNotExist();

    deferred1.reject({ message: 'Failed to load' });

    await settled();

    assert.dom('.tooltip').hasText('Failed to load');

    await triggerEvent('.tooltipper', 'mouseleave');

    state.load = () => deferred2.promise;

    await triggerEvent('.tooltipper', 'mouseenter');

    deferred2.resolve({ greeting: 'Loaded OK' });

    await settled();

    assert.dom('.tooltip').hasText('Loaded OK');
  });
});
