import Controller from '@ember/controller';

export default Controller.extend({
  show: true,
  actions: {
    toggle() {
      this.toggleProperty('show');
    }
  }
});
