import Application from '@ember/application';
import Resolver from 'ember-resolver';
import config from './config.js';
import * as Router from './router.js';
import * as ApplicationTemplate from './templates/application.gjs';
import * as NativeTemplate from './templates/native.gjs';
import * as ModifierTemplate from './templates/modifier.gjs';
import * as IndexRoute from './routes/index.js';

export default class App extends Application {
  modulePrefix = config.modulePrefix;
  Resolver = Resolver.withModules({
    'demo/router': Router,
    'demo/templates/application': ApplicationTemplate,
    'demo/templates/native': NativeTemplate,
    'demo/templates/modifier': ModifierTemplate,
    'demo/routes/index': IndexRoute
  });
}
