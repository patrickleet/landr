leads = new Meteor.Collection('leads')
loads = new Meteor.Collection('loads')

if (Meteor.isClient) {
  loads.insert({
    loadTime: new Date()
  });

  Template.signup.helpers({
    done: function() {
      return Session.get('done')
    }
  });

  Template.signup.events({
    'submit form' : function (evt, tmpl) {
      evt.preventDefault();

      var email = tmpl.find('input#email').value
//        , event = tmpl.find('input#event').value
//        , from = tmpl.find('select#from').value
        , doc = {
          email: email,
          referrer: document.referrer,
          timestamp: new Date(),
          event: '',
          from: ''
        }

      leads.insert(doc);
      Session.set('done', true);

    }
  });

  Template.leads.helpers({
    leads: function() {
      return leads.find();
    },
    loads: function() {
      return loads.find().count();
    },
    leadsCount: function() {
      return leads.find().count();
    }
  });
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}
