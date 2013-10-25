

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
