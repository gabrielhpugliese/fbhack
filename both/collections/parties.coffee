@Parties = new Meteor.Collection 'parties'

Parties.current = ->
  user = Meteor.user()
  if not user
    return

  @findOne({$or: [ {ownerId: user._id}, {friends: user.services.facebook.id} ],status: 'active'},{sort: {createdAt: -1}})

Parties.friendsJson = (partyId) ->
  party = @findOne(partyId)
  if not party
    return
  _.map party.friends, (x) ->
    {id: x}
