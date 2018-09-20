//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('TeamChannel', {
  received: function(data) {
    console.log("data received: ", data);
  },

  renderMessage: function(data) {
    console.log("renderMessage: ", data);
  }
});
