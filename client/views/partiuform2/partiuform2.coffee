Template.Partiuform2.events {
  'click #step2Submit': (e,t)->
    friends = _.map($('#friends-selector > input[name=friend]:checked'), (check) -> return $(check).val())
    party = Parties.current()
    Parties.update({_id: party._id},{$set: {friends: friends, status: 'active'}}, (err, res) ->
      if err
        console.error 'deu erro', err
        return

      Meteor.call('post', (err, res) ->
        console.log err, res
      )
    )
}

Template.Partiuform2.groupButtons = ->
  Session.get 'groupList'

Template.Partiuform2.helpers {
  largeImage: (id) ->
    "http://graph.facebook.com/"+id+"/picture?type=large"
}

Template.Partiuform2.created = ->

Template.Partiuform2.rendered = =>
  @fbAsyncInit()
  FB.Event.subscribe 'auth.statusChange', (res) ->
    console.log('oi')
    if res.status == 'connected'
        Session.set('fbinit',true)

Template.Partiuform2.destroyed = ->

Deps.autorun ->
  unless Session.get('fbinit')
    return

  FB.api "/me/friends", 'get', null, (response) ->
    Session.set('friends',_.sample(response.data,20))
    
  title = Parties.current().title
  FB.api {
    method: 'fql.query',
    query: "select name, start_time, eid FROM event where contains('" + name + "')
    AND eid IN (SELECT eid FROM event_member WHERE eid in
    (SELECT eid FROM event WHERE contains('" + name + "')) AND uid = me() AND rsvp_status = 'attending')"
  }, (data) ->
    console.log(data)
    x = _.map data, (item) ->
      console.log(item.eid)
      { eid: item.eid }
    Session.set 'groupList', x
