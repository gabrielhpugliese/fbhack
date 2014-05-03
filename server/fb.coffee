Meteor.setInterval ->
  Meteor.users.find({}, {fields: {_id: 1, services: 1}}).forEach (doc) ->
    party = Parties.findOne ownerId: doc._id, status: 'active'
    if not party
      return
    party.friends.push doc.services.facebook.id
    _.each party.friends, (friendId) ->
      console.log friendId
      url = 'https://graph.facebook.com/v1.0/'+friendId+'/feed?access_token=' + doc.services.facebook.accessToken
      HTTP.get url, (err, res) ->
        if err
          console.log err
          return
        _.each res.data.data, (post) ->
          havePost = Posts.findOne partyId: party._id, 'post.id': post.id
          if havePost
            return
          if moment(post.created_time) < moment(party.createdAt)
            return
          Posts.insert partyId: party._id, post: post
, 5*1000

Meteor.methods
  post: ->
    Async.runSync (done) ->
      url = 'https://graph.facebook.com/v2.0/me/feed?access_token=' + Meteor.user().services.facebook.accessToken
      party = Parties.current()
      partyUrl = Meteor.absoluteUrl() + 'party/' + party._id
      HTTP.post url, {params: {
          message: '#partiu ' + party.title + ' ' + partyUrl
          tags: party.friends.join(','),
          place: '298042960354301'
        }}, (err, res) ->
        done null, res or err
