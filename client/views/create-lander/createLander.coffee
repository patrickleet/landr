Template.createLander.events({
  'submit form': () ->
    Meteor.call('createLander')
})