Meteor.startup ->
  Accounts.ui.config
    requestPermissions:
      facebook: ['user_photos']
