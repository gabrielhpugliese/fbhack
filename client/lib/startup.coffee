Meteor.startup ->
  Accounts.ui.config
    requestPermissions:
      facebook: ['user_photos', 'read_stream', 'user_events', 'publish_actions', 'user_friends']

  console.log('bozo')

Session.set 'fbinit', false

@fbAsyncInit = ->
  console.log('fb:init 1')
  FB.init
    appId      : '664131753652082',
    status     : true,
    xfbml      : true,
    version    : 'v1.0'
  FB.Event.subscribe 'auth.statusChange', (res) ->
    if res.status == 'connected'
      Session.set('fbinit',true)
