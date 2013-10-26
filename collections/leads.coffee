@leads = new Meteor.Collection('leads')

Meteor.methods
  addLead: (options) ->
    check(options, Match.ObjectIncluding({
      landerId: String
    }));

    check(options.phone, Match.Optional(String))
    check(options.name, Match.Optional(String))
    check(options.email, Match.Optional(String))

    options = _.pick(options,
      'landerId'
      'phone'
      'email'
      'name'
    )

    defaults =
      created: new Date()
    options = _.defaults(options, defaults)

    leads.insert(options)