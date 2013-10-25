Router.configure
  notFoundTemplate: '404'

Router.map ->
  @route 'home',
    path: '/'
    template: 'lander'
    data:
      _id: 'main'
      title: 'Splashdown'
      lead: 'A landing page for the real world.'
      hasSignedUpLead: 'Thanks for signing up.'

  @route 'lander',
    path: 'lander/:_id'

  @route 'dashboard',

  @route 'leads'