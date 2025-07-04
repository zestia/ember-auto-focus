import Route from 'ember-route-template';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import autoFocus from '@zestia/ember-auto-focus/modifiers/auto-focus';

class ModifierRoute extends Component {
  @tracked shouldShowInput;

  showInput = () => (this.shouldShowInput = true);
  hideInput = () => (this.shouldShowInput = false);

  <template>
    {{#if this.shouldShowInput}}
      <p>
        <input aria-label="Example text input" {{autoFocus}} />
      </p>
    {{/if}}

    {{! prettier-ignore }}
    <code>
      &lt;input \{{autoFocus}}&gt;
    </code>

    <p>
      Notice that on the second render, the input
      <em>
        is
      </em>
      focused.
    </p>

    <p>
      <button type="button" {{on "click" this.showInput}}>
        Show input
      </button>
      <button type="button" {{on "click" this.hideInput}}>
        Hide input
      </button>
    </p>
  </template>
}

export default Route(ModifierRoute);
