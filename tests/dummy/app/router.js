import Router from '@ember/routing/router';
import config from './config/environment';

const DummyRouter = Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

DummyRouter.map(function() {});

export default DummyRouter;
