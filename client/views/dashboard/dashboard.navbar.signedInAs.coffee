Template.signedInAs.helpers
  displayName: () ->
    user = Meteor.user()
    displayName = user.username ? user.profile?.name ? user.emails[0]?.address
    return displayName