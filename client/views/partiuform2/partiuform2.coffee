Template.Partiuform2.events {}
  
Template.Partiuform2.helpers {}

Template.Partiuform2.created = ->

Template.Partiuform2.rendered = ->
  console.log('comecei')
  FB.api "/me/friends", 'get', null, (response) ->
    console.log('terminei')
    Session.set('friends',response.data)
    console.log(response)


Template.Partiuform2.destroyed = ->
