Meteor.setInterval ->
  Meteor.users.find({}, {fields: {_id: 1, services: 1}}).forEach (doc) ->
    party = Parties.findOne ownerId: doc._id, status: 'active'
    if not party
      return
    party.friends.push doc.services.facebook.id
    console.log party.friends
    _.each party.friends, (friendId) ->
      url = 'https://graph.facebook.com/v1.0/'+friendId+'/feed?access_token=' + doc.services.facebook.accessToken
      HTTP.get url, (err, res) ->
        if err
          console.log err
          return
        #console.log res.data.data[0]
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
          message: '#partiu' + party.title + ' ' + partyUrl
          tags: party.friends.join(','),
          place: '298042960354301'
        }}, (err, res) ->
        done null, res or err

  album: ->
    Async.runSync (done) ->
      url = 'https://graph.facebook.com/v1.0/me/albums?access_token=' + Meteor.user().services.facebook.accessToken
      party = Parties.current()
      HTTP.post url, {params: {
          name: '#partiu' + party.title
        }}, (err, res) ->
        done null, res or err

  photo: ->
    Async.runSync (done) ->
      party = Parties.current()
      posts = Posts.find partyId: party._id
      url = 'https://graph.facebook.com/v1.0/10203788394454306/photos?access_token=' + Meteor.user().services.facebook.accessToken
      posts.forEach (post) ->
        if post.post.type == 'photo'
          HTTP.post url, {params: {
            url: post.post.picture,
            message: post.post.message or post.post.story
          }}, (err, res) ->
            console.log err, res
        else
          console.log 'nao eh photo'

      done(null, null)

