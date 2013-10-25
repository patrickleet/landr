Router.configure
  notFoundTemplate: '404'

Router.map ->
  @route 'home',
    path: '/'
    template: 'lander'

  @route 'lander',
    path: 'lander/:_id'

  @route 'dashboard',

  @route 'leads'