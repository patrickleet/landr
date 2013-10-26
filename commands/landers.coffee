Meteor.methods
  increaseLanderViews: (landerId) ->
    check(landerId, String)
    landers.update(landerId, {$inc: {views: 1}})
  addPhone: (phone) ->
    check(phone, String)

