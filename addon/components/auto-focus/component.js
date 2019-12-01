import Component from '@glimmer/component';
import { setComponentTemplate } from '@ember/component';
import focus from '../../utils/focus';
import { action } from '@ember/object';
import template from './template';

class AutoFocusComponent extends Component {
  @action
  autoFocus(element) {
    if (this.args.disabled) {
      return;
    }

    const selector = this.args.selector || ':first-child';
    const childElement = element.querySelector(selector);

    if (childElement) {
      focus(childElement);
    }
  }
}

export default setComponentTemplate(template, AutoFocusComponent);
