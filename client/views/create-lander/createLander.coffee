Template.createLander.events({
  'submit form': (evt, tmpl) ->
    evt.preventDefault()

    createLanderOptions =
      brand: $(evt.target).find('[name=brand]').val()
      url: $(evt.target).find('[name=url]').val()

    Meteor.call 'createLander', createLanderOptions, (error, id) ->
      if (error)
        return alert(error.reason)

      Router.go('lander', {_id: id})
})