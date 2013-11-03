Template.createLander.events({
  'keyup input[name=brand]': (evt, tmpl) ->
    brand = $(evt.target).val()
    if (brand)
      brand = brand.toLowerCase().dasherize()
    $(evt.target).closest('form').find('[name=url]').val(brand)

  'submit form': (evt, tmpl) ->
    evt.preventDefault()

    createLanderOptions =
      brand: $(evt.target).find('[name=brand]').val()
      url: $(evt.target).find('[name=url]').val()

    Meteor.call 'createLander', createLanderOptions, (error, url) ->
      if (error)
        return alert(error.reason)

      Router.go('lander', {url: url})
})