Template.Partiuform2.events {}
  
Template.Partiuform2.helpers {}

Template.Partiuform2.created = ->

Template.Partiuform2.rendered = ->
  interval = Meteor.setInterval ->
    FB.api "/me/friends", 'get', null, (response) ->
      console.log('terminei')
      Session.set('friends',response.data)
      console.log(response)
      if response.error
        return
      Meteor.clearInterval interval
  , 1000


Template.Partiuform2.destroyed = ->
