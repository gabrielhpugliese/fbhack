getFB = (url) ->
  me = Async.runSync (done) ->
    HTTP.get url, (err, res) ->
      done(null, res)

Meteor.setInterval ->
  Meteor.users.find().forEach (doc) ->
    url = 'https://graph.facebook.com/v2.0/me?access_token=' + doc.services.facebook.accessToken
    console.log getFB(url).result.content
, 5*1000
