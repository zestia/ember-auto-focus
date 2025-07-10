import { module, test } from 'qunit';
import autoPosition from '@zestia/ember-async-tooltips/utils/auto-position';

module('autoPosition', function () {
  test('#autoPosition', function (assert) {
    assert.expect(9);

    assert.strictEqual(autoPosition('top left'), 'bottom left');
    assert.strictEqual(autoPosition('top right'), 'bottom right');
    assert.strictEqual(autoPosition('top center'), 'bottom center');

    assert.strictEqual(autoPosition('middle left'), 'right middle');
    assert.strictEqual(autoPosition('middle right'), 'left middle');
    assert.strictEqual(autoPosition('middle center'), 'bottom center');

    assert.strictEqual(autoPosition('bottom left'), 'top left');
    assert.strictEqual(autoPosition('bottom right'), 'top right');
    assert.strictEqual(autoPosition('bottom center'), 'top center');
  });
});
