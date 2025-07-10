import { module, test } from 'qunit';
import { setupRenderingTest } from 'dummy/tests/helpers';
import { settled, render, triggerEvent } from '@ember/test-helpers';
import { tracked } from '@glimmer/tracking';
import Tooltip from '@zestia/ember-async-tooltips/components/tooltip';

module('tooltip | rendering', function (hooks) {
  setupRenderingTest(hooks);

  let tooltipService;

  hooks.beforeEach(function () {
    tooltipService = this.owner.lookup('service:tooltip');
  });

  test('rendering test', async function (assert) {
    assert.expect(1);

    await render(
      <template>
        <div>
          <Tooltip @show={{true}} />
        </div>
      </template>
    );

    assert.strictEqual(tooltipService.tooltips.length, 1);
  });

  test('multiple tooltips', async function (assert) {
    assert.expect(1);

    await render(
      <template>
        <div>
          <Tooltip @show={{true}} />
        </div>

        <div>
          <Tooltip />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper:nth-child(2)', 'mouseenter');

    assert.dom('.tooltip').exists({ count: 2 });
  });

  test('cancel destroying tooltip when animating out', async function (assert) {
    assert.expect(1);

    // This test simulates hovering over a tooltipper whilst a tooltip is
    // animating out. The tooltip should finish hiding and then show again,
    // and not be destroyed and rerendered.

    await render(
      <template>
        <div>
          <Tooltip />
        </div>
      </template>
    );

    await triggerEvent('.tooltipper', 'mouseenter');

    const [tooltip] = tooltipService.tooltips;
    const willHideTooltip = tooltip.hide();

    triggerEvent('.tooltipper', 'mouseenter');

    await willHideTooltip;

    await settled();

    assert.dom('.tooltip').hasAttribute('data-showing', 'true');
  });

  test('tearing down', async function (assert) {
    assert.expect(1);

    // This regression test checks that when a tooltip is destroyed,
    // that the tooltip service does not hold on to a reference
    // to its tooltip, which should also be destroyed.

    const state = new (class {
      @tracked show = true;
    })();

    await render(
      <template>
        {{#if state.show}}
          <div class="one">
            <Tooltip />
          </div>
        {{/if}}

        <div class="two">
          <Tooltip />
        </div>
      </template>
    );

    await triggerEvent('.one', 'mouseenter');

    state.show = false;

    await triggerEvent('.two', 'mouseenter');

    assert.strictEqual(tooltipService.tooltips.length, 1);
  });

  test('tearing down whilst showing another tooltip', async function (assert) {
    assert.expect(0);

    // This tests loads a slow tooltip, which is destroyed whilst
    // it is loading. During that time, another tooltipper is hovered over
    // This causes the code that checks if a tooltipper has-a-child,
    // or is-a-parent to run. The recently destroyed tooltipper's element
    // will be null so any parent/child checks need to account for this.

    const state = new (class {
      @tracked show = true;
    })();

    const deferred = Promise.withResolvers();

    const load = () => deferred.promise;

    await render(
      <template>
        {{#if state.show}}
          <div class="one">
            <Tooltip @onLoad={{load}} />
          </div>
        {{/if}}

        <div class="two">
          <Tooltip />
        </div>
      </template>
    );

    await triggerEvent('.one', 'mouseenter');

    state.show = false;

    await triggerEvent('.two', 'mouseenter');

    deferred.resolve();
  });
});
