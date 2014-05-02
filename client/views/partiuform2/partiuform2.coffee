Template.Partiuform2.events {
  #'click'
}

Template.Partiuform2.helpers {
  largeImage: (id) ->
    "http://graph.facebook.com/"+id+"/picture?type=large"
}

Template.Partiuform2.created = ->

Template.Partiuform2.rendered = ->
  interval = Meteor.setInterval ->
    console.log('oi')
    FB.api "/me/friends", 'get', null, (response) ->
      Session.set('friends',_.sample(response.data,20))
      if response.error
        return
      Meteor.clearInterval interval
  , 1000


Template.Partiuform2.destroyed = ->
