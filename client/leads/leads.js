Template.leads.helpers({
  leads: function() {
    return leads.find();
  },
  loads: function() {
    return loads.find().count();
  },
  leadsCount: function() {
    return leads.find().count();
  }
});