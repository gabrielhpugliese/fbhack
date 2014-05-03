Fiber = Npm.require 'fibers'

Parties.before.insert (userId,doc) ->
  doc.createdAt = Date.now()
  doc.ownerId = userId
  doc.status = 'editing'

Parties.after.insert (userId, doc) ->
  user = Meteor.users.findOne(userId)
  party = doc
  if user
    url = 'https://graph.facebook.com/v1.0/me/albums?access_token=' + user.services.facebook.accessToken
    Fiber(->
      HTTP.post url, {params: {
          name: '#partiu' + party.title
        }}, (err, res) ->
          Parties.update {_id: doc._id},{$set: {albumId: res.data.id}}
    ).run()

Parties.after.update (userId, doc) ->
  user = Meteor.users.findOne(userId)
  party = doc
  if user and doc.status == 'finished'
    url = 'https://graph.facebook.com/v1.0/'+party.albumId+'/photos?access_token=' + Meteor.user().services.facebook.accessToken
    posts = Posts.find partyId: party._id
    posts.forEach (post) ->
      if post.post.type == 'photo'
        Fiber(->
          HTTP.post url, {params: {
            url: post.post.picture,
            message: post.post.message or post.post.story
          }}, (err, res) ->
            if err
              console.log err
            else
              console.log 'photo inserted on album'
        ).run()
