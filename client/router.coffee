Router.configure
  layoutTemplate: 'dashboardLayout' # TODO: Override entry controllers
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  yieldTemplates:
    'dashboardNavbar': {to: 'navbar'}


@filters = {

  nProgressHook: () ->
    console.log('this ran')
    if @ready()
      NProgress.done()
    else
      NProgress.start()
      @stop()

  resetScroll: () ->
    scrollTo = window.currentScroll || 0;
    $('body').scrollTop(scrollTo);
    $('body').css("min-height", 0);

  isLoggedIn: () ->
    if !(Meteor.loggingIn() || Meteor.user())
#      throwError('Please Sign In First.')
      this.render('entrySignIn')
      this.stop()

  isLoggedOut: () ->
    if Meteor.user()
      Router.go('dashboard')

  isAdmin: () ->
    if !Meteor.loggingIn() && Session.get('settingsLoaded') && !isAdmin()
  #  throwError("Sorry, you  have to be an admin to view this page.")
      this.render('no_rights');
      this.stop();

  checkAuthorized: () ->
    user = Meteor.user();
    if (! user)
      @render (if Meteor.loggingIn() then @loadingTemplate else "entrySignIn")
      return this.stop();

}

# Load Hooks
Router.load () ->
#  clearSeenErrors(); # set all errors who have already been seen to not show anymore
  @


# Show loading bar for any route that loads a subscription
Router.before(filters.nProgressHook, {only: [
  'home'
  'dashboard'
  'editLander'
  'leads'
  'lander'
]})

# Check logged in for these routes
Router.before(filters.isLoggedIn, {only: [
  'dashboard'
  'createLander'
  'editLander'
]})

# if already logged in, don't show login stuff, just redirect to dashboard
Router.before(filters.isLoggedOut, {only: [
  'entrySignIn'
  'entrySignUp'
  'home'
]})

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
        return
      Meteor.call('increaseLanderViews', 'main')

#    before: () ->
#      this.subscribe('landers', 'main').wait()

  @route 'dashboard',
    path: '/dashboard'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}
    before: () ->
      @subscribe('landers').wait()
    data: () ->
      return {
        landers: landers.find()
      }

  @route 'createLander',
    path: '/create'
    layoutTemplate: 'dashboardLayout'
    yieldTemplates:
      'dashboardNavbar': {to: 'navbar'}


  @route 'editLander',
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