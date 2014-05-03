@Parties = new Meteor.Collection 'parties'

Parties.current = ->
  @findOne({status: 'active'},{sort: {createdAt: -1}})

Parties.friendsJson = ->
  _.map Parties.current().friends, (x) ->
    {id: x}
