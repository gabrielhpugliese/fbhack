Meteor.startup ->
  console.log('fb: init step 1')
  @fbAsyncInit = ->
    console.log('fb: init step 2')
    FB.init
      appId      : '664131753652082',
      status     : true,
      xfbml      : true,
      version    : 'v2.0'
