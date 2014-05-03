###
 PastParties: Event Handlers and Helpers
###
Template.PastParties.events {}
###
Example:
 'click .selector': (e, tmpl) ->
###

Template.PastParties.helpers
  pastParties: ->
    console.log 'aki'
    user = Meteor.user()
    if not user
      return []
    Parties.find {$or: [{ownerId: user._id}, {friends: user.services.facebook.id}]}
  friendsFor: (id) ->
    _.first(Parties.friendsJson(id), 5)
  hasMoreThan5: (id) ->
    Parties.friendsJson(id).length > 5

###
Example:
 items: ->
   Items.find()
###

###
 PastParties: Lifecycle Hooks
###
Template.PastParties.created = ->

Template.PastParties.rendered = ->

Template.PastParties.destroyed = ->
