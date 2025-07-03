/* eslint-disable array-callback-return */

import EmberRouter from '@ember/routing/router';
import config from './config.js';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('native');
  this.route('modifier');
});
