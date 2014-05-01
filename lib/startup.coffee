Meteor.startup ->
  @fbAsyncInit = ->
    FB.init
      appId      : '664131753652082',
      status     : true,
      xfbml      : true,
      version    : 'v2.0'
