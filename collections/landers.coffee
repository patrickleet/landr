class @Lander
  constructor: (title, lead, hasSignedUpLead, views, services) ->
    check(title, String)
    check(lead, String)
    check(hasSignedUpLead, String)
    check(views, Number)
    check(services, [Object])

    @title = title
    @lead = lead
    @hasSignedUpLead = hasSignedUpLead
    @views = views
    @services = services

@Lander.compare = (a, b) ->
  if (a.order < b.order)
    return -1;
  if (a.order > b.order)
    return 1;
  return 0;

@landers = new Meteor.Collection('landers', {
  transform: (doc) ->
    title = doc.title
    lead = doc.lead
    hasSignedUpLead = doc.hasSignedUpLead
    views = doc.views
    services = doc.services ? []
    services = services.sort(Lander.compare)
    return new Lander(title, lead, hasSignedUpLead, views, services);
})