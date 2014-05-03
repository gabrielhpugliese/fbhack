Fiber = Npm.require 'fibers'

Parties.before.insert (userId,doc) ->
  doc.createdAt = Date.now()
  doc.ownerId = userId
  doc.status = 'editing'

Parties.after.insert (userId, doc) ->
  user = Meteor.users.findOne(userId)
  if user
    url = 'https://graph.facebook.com/v1.0/me/albums?access_token=' + user.services.facebook.accessToken
    party = doc
    Fiber(->
      HTTP.post url, {params: {
          name: '#partiu' + party.title
        }}, (err, res) ->
    ).run()
