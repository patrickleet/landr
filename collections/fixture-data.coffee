if @landers.find().count() is 0
  @landers.insert
    _id: 'main'
    title: 'Splashdown'
    lead: 'A landing page for the real world.'
    hasSignedUpLead: 'Thanks for signing up.'
    views: 0

  @landers.insert
    _id: 'cabpool'
    title: 'CabPool'
    lead: 'Share a Cab. Make Connections. Save Money.'
    hasSignedUpLead: 'Thanks for signing up.'
    views: 0