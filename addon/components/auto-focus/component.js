import Component from '@ember/component';
import focus from '../../utils/focus';
import layout from './template';
import { action } from '@ember/object';

export default class AutoFocusComponent extends Component {
  layout = layout;
  tagName = '';

  @action
  autoFocus(element) {
    if (this.disabled) {
      return;
    }

    const selector = this.selector || ':first-child';
    const childElement = element.querySelector(selector);

    if (childElement) {
      focus(childElement);
    }
  }
}
