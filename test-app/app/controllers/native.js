import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';

export default class NativeController extends Controller {
  @tracked shouldShowInput = false;

  showInput = () => {
    this.shouldShowInput = true;
  };

  hideInput = () => {
    this.shouldShowInput = false;
  };
}
