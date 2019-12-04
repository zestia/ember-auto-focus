import Controller from '@ember/controller';
import { set, action } from '@ember/object';

export default class ApplicationController extends Controller {
  shouldShowInput = false;
  shouldShowComponent = false;

  @action
  showInput() {
    set(this, 'shouldShowInput', true);
  }

  @action
  hideInput() {
    set(this, 'shouldShowInput', false);
  }

  @action
  showComponent() {
    set(this, 'shouldShowComponent', true);
  }

  @action
  hideComponent() {
    set(this, 'shouldShowComponent', false);
  }
}
