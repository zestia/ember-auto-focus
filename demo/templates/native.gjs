import Route from 'ember-route-template';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

class NativeRoute extends Component {
  @tracked shouldShowInput;

  showInput = () => (this.shouldShowInput = true);
  hideInput = () => (this.shouldShowInput = false);

  <template>
    {{#if this.shouldShowInput}}
      <p>
        {{! template-lint-disable no-autofocus-attribute }}
        <input aria-label="Example text input" autofocus />
      </p>
    {{/if}}

    <code>
      &lt;input autofocus&gt;
    </code>

    <p>
      Notice that on the second render, the input
      <em>is not</em>
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

export default Route(NativeRoute);
