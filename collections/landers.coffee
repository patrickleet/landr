@Lander = {}
@Lander.compare = (a, b) ->
  if (a.order < b.order)
    return -1;
  if (a.order > b.order)
    return 1;
  return 0;

@landers = new Meteor.Collection('landers')

Meteor.methods
  createLander: (options) ->
    check(options, {
      brand: String
      url: String
    })

    lander =
      owner: this.userId
      brand: options.brand
      url: options.url
      views: 0
      emailsCollected: 0
      phonesCollected: 0
      numberOfLeads: 0
      collectName: true
      collectEmail: true
      collectPhone: false
      intro:
        title: 'High level view of problem.'
        lead: 'Enter a description about why this is a problem and how your idea will solve this problem. Maybe end with something witty.'
      services: [
        {
          order: 1
          name: 'Example service'
          description: 'A description about this service and why it\'s super awesome.'
          iconClass: 'fa fa-briefcase'
        }
      ]

    landerId = landers.insert lander
    return lander.url

  increaseLanderViews: (url) ->
    check(url, String)
    landers.update({url: url}, {$inc: {views: 1}})