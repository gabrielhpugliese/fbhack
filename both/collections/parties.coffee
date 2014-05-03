@Parties = new Meteor.Collection 'parties'

Parties.current = ->
  @findOne({status: 'active'},{sort: {createdAt: -1}})

Parties.friendsJson = (partyId) ->
  party = @findOne(partyId)
  if not party
    return
  _.map party.friends, (x) ->
    {id: x}
