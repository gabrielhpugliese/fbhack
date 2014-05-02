queryFB = (url, verb) ->
  HTTP[verb] url, (err, res) ->
    console.log err, res.data.data.length

Meteor.setInterval ->
  Meteor.users.find({}, {fields: {_id: 1, services: 1}}).forEach (doc) ->
    url = 'https://graph.facebook.com/v2.0/me/feed?access_token=' + doc.services.facebook.accessToken
    queryFB url, 'get'
, 5*1000
