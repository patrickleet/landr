@checkAuthorized = () ->
  user = Meteor.user();
  if (! user)
    @render (if Meteor.loggingIn() then @loadingTemplate else "entrySignIn")
    return this.stop();

Router.configure
  notFoundTemplate: '404'
  layoutTemplate: 'landerLayout' # TODO: Override entry controllers

Router.map ->

  @route 'termsOfUse',
    path: '/terms-of-use'

  @route 'privacyPolicy',
    path: '/privacy-policy'

  @route 'home',
    path: '/'
    template: 'landerMain'
    layoutTemplate: 'landerLayout'
    data: () ->
      return landers.findOne('main')
    load: () ->
      Meteor.call('increaseLanderViews', 'main')

#    before: () ->
#      this.subscribe('landers', 'main').wait()

  @route 'dashboard',
    path: '/dashboard'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    before: [checkAuthorized]
    data: () ->
      return {
        landers: landers.find()
      }

  @route 'landerCreate',
    path: '/create'
    template: 'landerForm'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    data: () ->
      return {
        create: true
      }

  @route 'landerEdit',
    path: ':_id/edit'
    template: 'landerForm'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    data: () ->
      return landers.find(this.params._id)


  @route 'leads',
    path: ':_id/leads'
    before: [checkAuthorized]
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    data: () ->
      lander = landers.findOne(this.params._id)
      leadsCursor = leads.find({landerId: this.params._id})

      return {
        leads: leadsCursor
        leadsCount: leadsCursor.count()
        viewCount: lander.views
      }

  @route 'lander',
    path: ':_id'
    template: 'landerMain'
    layoutTemplate: 'landerLayout'
    data: () ->
      return landers.findOne(this.params._id)
    load: () ->
      Meteor.call('increaseLanderViews', this.params._id)
    after: () ->
      document.title = this.data().title