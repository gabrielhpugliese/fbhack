###
 Index: Event Handlers and Helpers
###
Template.Index.events {}
###
Example: 
 'click .selector': (e, tmpl) ->
### 


Template.Index.helpers
  stepGreater: (step) ->
    Session.get("step") >= step
###
Example: 
 items: ->
   Items.find()
###

###
 Index: Lifecycle Hooks
###
Template.Index.created = ->

Template.Index.rendered = ->

Template.Index.destroyed = ->
