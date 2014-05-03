@Parties = new Meteor.Collection 'parties'

Parties.current = ->
  @findOne({status: 'active'},{sort: {createdAt: -1}})
