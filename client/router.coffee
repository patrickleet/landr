Router.configure
  notFoundTemplate: '404'

Router.map ->
  @route 'home',
    path: '/'
    template: 'lander'
    data: () ->
      landers.findOne('main')
#    before: () ->
#      this.subscribe('landers', 'main').wait();


  @route 'lander',
    path: 'lander/:_id'
    data: () ->
      landers.findOne(this.params._id)

  @route 'dashboard'

  @route 'leads',
    path: 'leads/:_id'
    data: () ->
      lander = landers.findOne(this.params._id)
      leadsCursor = leads.find({landerId: this.params._id})

      data =
        leads: leadsCursor
        leadsCount: leadsCursor.count()
        viewCount: lander.views

      return data