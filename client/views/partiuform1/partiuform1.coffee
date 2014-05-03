Template.Partiuform1.events {
  'click #partyStart': (e,t) ->
    friends = _.map($('#users .selected'), (check) -> return $(check).find('input[name=user_id]').val())
    console.log "friends"
    console.log friends    

    party =
      title: $('#party-title').val()

    party._id = Parties.insert(party)
    Parties.update({_id: party._id},{$set: {friends: friends, status: 'active'}}, (err, res) ->
      if err
        console.error 'deu erro', err
        return

      Meteor.call('post', (err, res) ->
        console.log err, res
      )
    )

    Router.go('party',{_id: party._id})

  'click #partyStop': (e,t) ->
    Parties.remove({_id: Parties.current()._id})

  'keyup .typeahead': (e, t) ->
    keyword = t.$(e.target).val()
    friends = Session.get 'friends'
    regex = new RegExp(keyword, 'i')

    friends = _.map friends, (friend) ->
      if keyword.length > 2 and regex.test(friend.name)
        friend.visible = ''
      else
        friend.visible = 'hide'
      return friend
    Session.set 'friends', friends

  'click #users .user': (e, t) ->
    console.log 'aki'
    e.preventDefault()
    $target = t.$(e.target)
    if not $target.hasClass 'user'
      $target = $target.closest '.user'
    $target.toggleClass 'selected'

###
  $("#users").on "click", ".user_group", (e) ->
    e.preventDefault()
    $(this).toggleClass "selected"
    return
###
}

Template.Partiuform1.helpers {
  largeImage: (id) ->
    "http://graph.facebook.com/"+id+"/picture?type=large"
}

Template.Partiuform1.groupButtons = ->
  Session.get 'groupList'

Template.Partiuform1.created = ->

Template.Partiuform1.rendered = ->
  this.$("#party-title").focus()
  window.fbAsyncInit()
  FB.Event.subscribe 'auth.statusChange', (res) ->
    console.log('oi')
    if res.status == 'connected'
        Session.set('fbinit',true)

Template.Partiuform1.destroyed = ->

Deps.autorun ->
  unless Session.get('fbinit')
    return

  FB.api "/me/friends", 'get', null, (response) ->
    #Session.set('friends',_.sample(response.data,20))
    data = _.map response.data, (d) ->
      d.visible = 'hide'
      return d
    Session.set('friends', data)

  party = Parties.current()
  if not party
    return
  title = party.title
  FB.api {
    method: 'fql.query',
    query: "select name, start_time, eid FROM event where contains('" + title + "')
    AND eid IN (SELECT eid FROM event_member WHERE eid in
    (SELECT eid FROM event WHERE contains('" + title + "')) AND uid = me() AND rsvp_status = 'attending')"
  }, (data) ->
    console.log(data)
    x = _.map data, (item) ->
      console.log(item.eid)
      { eid: item.eid }
    Session.set 'groupList', x
