Meteor.startup ->
  Accounts.ui.config
    passwordSignupFields: 'EMAIL_ONLY'

  AccountsEntry.config
    homeRoute: Router.routes['home'].path()
    dashboardRoute: Router.routes['dashboard'].path()
    privacyUrl: Router.routes['privacyPolicy'].path()
    termsUrl: Router.routes['termsOfUse'].path()