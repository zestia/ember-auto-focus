import Ember from 'ember';
import Resolver from './resolver';
import loadInitializers from 'ember-load-initializers';
import config from './config/environment';
const { Application } = Ember;

Ember.MODEL_FACTORY_INJECTIONS = true;

const app = Application.extend({
  modulePrefix: config.modulePrefix,
  podModulePrefix: config.podModulePrefix,
  Resolver
});

loadInitializers(app, config.modulePrefix);

export default app;
