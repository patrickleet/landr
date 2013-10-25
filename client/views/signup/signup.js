Template.signup.helpers({
  hasSignedUp: function() {
    return Session.get('hasSignedUp')
  }
});

Template.signup.events({
  'submit form' : function (evt, tmpl) {
    evt.preventDefault();

    var email = tmpl.find('input#email').value
//        , event = tmpl.find('input#event').value
//        , from = tmpl.find('select#from').value
      , doc = {
        landerId: tmpl.data._id,
        email: email,
        referrer: document.referrer,
        timestamp: new Date(),
        event: '',
        from: ''
      }

    leads.insert(doc);
    Session.set('hasSignedUp', true);

  }
});