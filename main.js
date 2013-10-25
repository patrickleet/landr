leads = new Meteor.Collection('leads')
loads = new Meteor.Collection('loads')

if (Meteor.isClient) {
  Meteor.startup(function() {
    loads.insert({
      loadTime: new Date()
    });
  });
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}
