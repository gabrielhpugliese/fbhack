###
 MasterLayout: Event Handlers and Helpers
###
Template.MasterLayout.events {}
###
Example: 
 'click .selector': (e, tmpl) ->
### 


Template.MasterLayout.helpers {}
###
Example: 
 items: ->
   Items.find()
###

###
 MasterLayout: Lifecycle Hooks
###
Template.MasterLayout.created = ->

Template.MasterLayout.rendered = ->
	@$("img.mobile-menu").click =>
	  $(".section:first").toggleClass "show"
	  return

Template.MasterLayout.destroyed = ->

