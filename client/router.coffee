@checkAuthorized = () ->
  user = Meteor.user();
  if (! user)
    @render (if Meteor.loggingIn() then @loadingTemplate else "entrySignIn")
    return this.stop();

Router.configure
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'
  layoutTemplate: 'dashboardLayout' # TODO: Override entry controllers
  yieldTemplates:
    'dashboardNavbar': {to: 'navbar'}

Router.map ->

  @route 'termsOfUse',
    path: '/terms-of-use'

  @route 'privacyPolicy',
    path: '/privacy-policy'

  @route 'home',
    path: '/'
    template: 'landerMain'
    layoutTemplate: 'landerLayout'
    before: () ->
      @subscribe('main-lander').wait()
    data: () ->
      return landers.findOne('main')
    load: () ->
      if (Meteor.userId())
        Router.go('dashboard')
        return
      Meteor.call('increaseLanderViews', 'main')

#    before: () ->
#      this.subscribe('landers', 'main').wait()

  @route 'dashboard',
    path: '/dashboard'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    before: [
      checkAuthorized

      () ->
        @subscribe('landers').wait()

    ]
    data: () ->
      return {
        landers: landers.find()
      }

  @route 'createLander',
    path: '/create'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}


  @route 'landerEdit',
    path: ':_id/edit'
    template: 'landerForm'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    before: () ->
      @subscribe('lander', this.params._id).wait()
    data: () ->
      return landers.find(this.params._id)


  @route 'leads',
    path: ':_id/leads'
    before: [checkAuthorized]
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    before: () ->
      @subscribe('leads', this.params._id).wait()
    data: () ->
      lander = landers.findOne(this.params._id)
      leadsCursor = leads.find({landerId: this.params._id})

      return {
        leads: leadsCursor
        leadsCount: leadsCursor.count()
        viewCount: lander.views
      }

  @route 'lander',
    path: ':url'
    template: 'landerMain'
    layoutTemplate: 'landerLayout'
    before: () ->
      url = this.params.url.toLowerCase().dasherize()
      @subscribe('lander-by-url', url).wait()
    data: () ->
      url = this.params.url.toLowerCase().dasherize()
      return landers.findOne({url: url})
    load: () ->
      Meteor.call('increaseLanderViews', this.params._id)
    after: () ->
      document.title = this.data().brand