Template.Partiuform2.events {
  'click #step2Submit': (e,t)->
    friends = _.map($('#friends-selector > input[name=friend]:checked'), (check) -> return $(check).val())
    party = Parties.current()
    Parties.update({_id: party._id},{$set: {friends: friends}})
}

Template.Partiuform2.helpers {
  largeImage: (id) ->
    "http://graph.facebook.com/"+id+"/picture?type=large"
}

Template.Partiuform2.created = ->

Template.Partiuform2.rendered = ->
  interval = Meteor.setInterval ->
    console.log('oi')
    console.log(@fbAsyncInit())
    if not @fbAsyncInit
      console.log("cant")
    FB.api "/me/friends", 'get', null, (response) ->
      Session.set('friends',_.sample(response.data,20))
      if response.error
        return
      Meteor.clearInterval interval
  , 1000


Template.Partiuform2.destroyed = ->
