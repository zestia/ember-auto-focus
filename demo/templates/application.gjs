import Route from 'ember-route-template';
import { LinkTo } from '@ember/routing';
import '../styles/app.css';

export default Route(
  <template>
    <h1>
      @zestia/ember-async-tooltips
    </h1>

    <LinkTo @route="native">Native</LinkTo>
    |
    <LinkTo @route="modifier">Modifier</LinkTo>

    <br />
    <br />

    {{outlet}}

    {{! template-lint-disable no-inline-styles }}
    <a href="https://github.com/zestia/ember-async-tooltips">
      <img
        style="position: absolute; top: 0; right: 0; border: 0;"
        width="149"
        height="149"
        src="https://github.blog/wp-content/uploads/2008/12/forkme_right_darkblue_121621.png?resize=149%2C149"
        class="attachment-full size-full"
        alt="Fork me on GitHub"
        data-recalc-dims="1"
      />
    </a>
  </template>
);
