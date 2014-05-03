Template.Partiuform1.events {
  'click #partyStart': (e,t) ->
    friends = _.map($('#users .selected'), (check) -> return $(check).find('input[name=user_id]').val())

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
    Parties.update({_id: Parties.current()._id}, {$set: {status: 'finished'}})

  'keyup .typeahead': (e, t) ->
    keyword = t.$(e.target).val()
    regex = new RegExp(keyword, 'i')

    allFriends = Session.get 'allFriends'
    friends = Session.get 'friends'
    initials = Session.get 'initials'
    firsts = []
    lasts = []

    if keyword.length == 0
      _.each allFriends, (friend) ->
        if friend.selected
          friend.visible = ''
          firsts.push friend
        else
          lasts.push friend
    else
      _.each allFriends, (friend) ->
        if friend.selected
          friend.visible = ''
          firsts.push friend
        else
          if keyword.length > 2
            if regex.test(friend.name)
              friend.visible = ''
            else
              friend.visible = 'hide'
          lasts.push friend

    Session.set 'friends', _.union(firsts,lasts)

  'click #users .user': (e, t) ->
    e.preventDefault()
    $target = t.$(e.target)
    if not $target.hasClass 'user'
      $target = $target.closest '.user'

    $target.toggleClass 'selected'

    allFriends = Session.get 'allFriends'

    friends = _.map allFriends, (f) =>
      if this.id == f.id
        console.log(this)
        console.log(this.id)
        f.selected = $target.hasClass 'selected'
      return f

    Session.set('allFriends',friends)

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
  selectedClass: (selected) ->
    if selected
      'selected'
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

    initials = _.sample(data,21)
    _.each initials, (d) ->
      d.visible = ''

    Session.set('initials', initials)
    Session.set('friends', initials)
    Session.set('allFriends', data)

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
