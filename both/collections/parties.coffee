@Parties = new Meteor.Collection 'parties'

Parties.current = ->
  @findOne({},{sort: {createdAt: -1}})
