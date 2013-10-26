Template.signup.helpers({
  hasSignedUp: function() {
    return Session.get('hasSignedUp')
  }
});

Template.signup.events({
  'submit form' : function (evt, tmpl) {
    evt.preventDefault();

    var phone = tmpl.find('input#phone').value
//        , event = tmpl.find('input#event').value
//        , from = tmpl.find('select#from').value
      , doc = {
        landerId: tmpl.data._id,
        phone: phone,
        created: new Date()
      }

    leads.insert(doc);
    Session.set('hasSignedUp', true);

  }
});