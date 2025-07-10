import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

export default class TooltipService extends Service {
  tooltips = [];
  @tracked _sticky = {};

  hideAllTooltips = () => {
    return Promise.all(this.tooltips.map((tooltip) => tooltip.hide()));
  };

  _add = (tooltip) => {
    this.tooltips.push(tooltip);
  };

  _remove = (tooltip) => {
    this.tooltips.splice(this.tooltips.indexOf(tooltip), 1);
  };

  _setSticky = (tooltip, value) => {
    this._sticky[tooltip.args.stickyID] = value;
    this._sticky = { ...this._sticky };
  };
}
