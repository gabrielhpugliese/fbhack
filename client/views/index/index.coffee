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

Template.Index.created = ->

Template.Index.rendered = ->
  FB.XFBML.parse()

Template.Index.destroyed = ->
