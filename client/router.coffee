Router.configure
  notFoundTemplate: '404'

Router.map ->
  @route 'home',
    path: '/'
    template: 'lander'
    data: () ->
      return landers.findOne('main')
    load: () ->
      Meteor.call('increaseLanderViews', 'main')

#    before: () ->
#      this.subscribe('landers', 'main').wait()

  @route 'lander',
    path: ':_id'
    data: () ->
      return landers.findOne(this.params._id)
    load: () ->
      Meteor.call('increaseLanderViews', this.params._id)
    after: () ->
      document.title = this.data().title

  @route 'dashboard'

  @route 'leads',
    path: ':_id/leads'
    data: () ->
      lander = landers.findOne(this.params._id)
      leadsCursor = leads.find({landerId: this.params._id})

      data =
        leads: leadsCursor
        leadsCount: leadsCursor.count()
        viewCount: lander.views

      return data