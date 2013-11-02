@Lander = {}
@Lander.compare = (a, b) ->
  if (a.order < b.order)
    return -1;
  if (a.order > b.order)
    return 1;
  return 0;

@landers = new Meteor.Collection('landers')

Meteor.methods
  createLander: (brand, url) ->
    check(brand, String)
    check(url, String)
    lander =
      brand: brand
      url: url

    lander


  increaseLanderViews: (landerId) ->
    check(landerId, String)
    landers.update(landerId, {$inc: {views: 1}})