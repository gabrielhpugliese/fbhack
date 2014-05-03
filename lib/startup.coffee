Meteor.startup ->
  console.log('bozo')
  @fbAsyncInit = ->
    console.log('fb:init 1')
    FB.init
      appId      : '664131753652082',
      status     : true,
      xfbml      : true,
      version    : 'v2.0'
