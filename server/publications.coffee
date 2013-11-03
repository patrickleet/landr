Meteor.publish 'main-lander', ->
  return landers.find('main')

Meteor.publish 'landers', ->
  return landers.find({owner: this.userId})

Meteor.publish 'lander', (id) ->
  check(id, String)
  return landers.find({_id: id})

Meteor.publish 'lander-by-url', (url) ->
  check(url, String)
  return landers.find({url: url})

Meteor.publish 'leads', (landerId) ->
  check(landerId, String)
  return leads.find({landerId: landerId})