Meteor.publish 'main-lander', ->
  return landers.find('main')

Meteor.publish 'landers', ->
  return landers.find({owner: this.userId})

Meteor.publish 'lander', (id) ->
  check(id, String)
  return landers.find({_id: id})

Meteor.publish 'leads', (landerId) ->
  check(landerId, String)
  return leads.find({landerId: landerId})