if @landers.find().count() is 0
  @landers.insert
    _id: 'main'
    title: 'Splashdown'
    lead: 'A landing page for the real world.'
    hasSignedUpLead: 'Thanks for signing up.'