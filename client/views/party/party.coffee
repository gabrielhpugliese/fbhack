###
 Party: Event Handlers and Helpers
###
Template.Party.events
  'click #partyStop': (e,t) ->
    Parties.update({_id: Parties.current()._id}, {$set: {status: 'finished'}})
    Router.go('index')
###
Example:
 'click .selector': (e, tmpl) ->
###


Template.Party.helpers
  posts: ->
    Posts.find
      partyId: Router.current().params._id
      $or: [
        { 'post.message': $exists: 1},
        { 'post.picture': $exists: 1}
      ]
  friendsJson: ->
    Parties.friendsJson()
###
Example:
 items: ->
   Items.find()
###

###
 Party: Lifecycle Hooks
###
Template.Party.created = ->

Template.Party.rendered = ->

Template.Party.destroyed = ->
