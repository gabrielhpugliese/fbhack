Meteor.setInterval ->
  Meteor.users.find({}, {fields: {_id: 1, services: 1}}).forEach (doc) ->
    party = Parties.findOne ownerId: doc._id, status: 'active'
    if not party
      return
    url = 'https://graph.facebook.com/v2.0/me/feed?access_token=' + doc.services.facebook.accessToken
    HTTP.get url, (err, res) ->
      if err
        return
      _.each res.data.data, (post) ->
        havePost = Posts.findOne partyId: party._id, 'post.id': post.id
        if havePost
          return
        Posts.insert partyId: party._id, post: post
, 5*1000

Meteor.methods
  post: ->
    Async.runSync (done) ->
      url = 'https://graph.facebook.com/v2.0/me/feed?access_token=' + Meteor.user().services.facebook.accessToken
      HTTP.post url, {params: {
          message: 'PQP FABS http://google.com',
          tags: 'fabsn',
          place: '471431836321883'
        }}, (err, res) ->
        done null, res or err
