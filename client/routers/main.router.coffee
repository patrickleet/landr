@clearErrors = () ->
  Errors.remove({seen: true})

@checkAuthorized = () ->
  routeName = this.context.route.name;
  # no need to check at these URLs
  if (_.include([
    'passwordReset',
    'notFound',
    'loading'
    'entrySignIn'
    'entrySignUp'
    'entryForgotPassword'
    'entrySignOut'
  ], routeName))
    return;

  user = Meteor.user();
  if (! user)
    @render (if Meteor.loggingIn() then @loadingTemplate else "entrySignIn")
    return this.stop();


Router.configure
  notFoundTemplate: '404'
  before: [@clearErrors, @checkAuthorized]
  layoutTemplate: 'landerLayout' # TODO: Override entry controllers

Router.map ->
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