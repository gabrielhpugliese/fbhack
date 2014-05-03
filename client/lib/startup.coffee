Meteor.startup ->
  Accounts.ui.config
    requestPermissions:
      facebook: ['user_photos', 'read_stream', 'user_events', 'publish_actions', 'user_friends']
