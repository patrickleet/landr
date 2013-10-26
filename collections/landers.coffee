class @Lander
  constructor: (options) ->
    check(options, Object)

    options = _.pick(options,
      '_id'
      'title'
      'lead'
      'hasSignedUpLead'
      'views'
      'collectEmail'
      'collectPhone'
      'collectName'
      'createAccount'
      'services'
    )

    defaults =
      views: 0
      createAccount: false
      collectEmail: true
      collectName: false
      collectPhone: false
      hasSignedUpLead: 'Thanks for signing up.'

    options = _.defaults(options, defaults)

    _.extend(@, options)

@Lander.compare = (a, b) ->
  if (a.order < b.order)
    return -1;
  if (a.order > b.order)
    return 1;
  return 0;

@landers = new Meteor.Collection('landers', {
  transform: (doc) ->
    return new Lander(doc);
})

Meteor.methods
  increaseLanderViews: (landerId) ->
    check(landerId, String)
    landers.update(landerId, {$inc: {views: 1}})