class @Lander
  constructor: (options) ->
    check(options, Object)
    defaults =
      views: 0
      collectEmail: true
      collectName: false
      collectPhone: false
      hasSignedUpLead: 'Thanks for signing up.'

    options = _.defaults(options, defaults)
    options = _.pick(options,
      'title'
      'lead'
      'hasSignedUpLead'
      'views'
      'collectEmail'
      'collectPhone'
      'collectName'
      'services'
    )
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