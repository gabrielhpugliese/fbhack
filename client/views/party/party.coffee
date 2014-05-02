###
 Party: Event Handlers and Helpers
###
Template.Party.events {}
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
