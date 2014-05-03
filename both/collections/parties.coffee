@Parties = new Meteor.Collection 'parties'

Parties.current = ->
  userId = Meteor.userId()
  if not userId
    return

  @findOne({$or: [ {ownerId: userId}, {friends: userId} ],status: 'active'},{sort: {createdAt: -1}})

Parties.friendsJson = (partyId) ->
  party = @findOne(partyId)
  if not party
    return
  _.map party.friends, (x) ->
    {id: x}
