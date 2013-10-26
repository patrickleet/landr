Template.signup.helpers(
  hasSignedUp: () ->
    return Session.get('hasSignedUp')
)

Template.signup.events(
  'submit form' : (evt, tmpl) ->
    evt.preventDefault()
    options = {
      landerId: tmpl.data._id
    }

    if tmpl.data.collectEmail
      options.email = tmpl.find('input#email').value

    if tmpl.data.collectPhone
      options.phone = tmpl.find('input#phone').value

    if tmpl.data.collectName
      options.name = tmpl.find('input#name').value

    Meteor.call('addLead', options)
    Session.set('hasSignedUp', true)
)