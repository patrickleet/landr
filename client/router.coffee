Router.configure
  notFoundTemplate: '404'

Router.map ->
  @route 'home',
    path: '/'

  @route 'dashboard',

  @route 'leads'