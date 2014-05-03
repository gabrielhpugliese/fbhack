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
    Parties.find {$or: [{ownerId: Meteor.userId()}, {friends: Meteor.userId()}]}

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
