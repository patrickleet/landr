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

  @route 'dashboard',

  @route 'leads'