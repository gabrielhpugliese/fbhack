###
 Index: Event Handlers and Helpers
###
Template.Index.events {
  'click #facebookLogin': () ->
    $(".single-login-button").click()
}
###
Example:
 'click .selector': (e, tmpl) ->
###


Template.Index.helpers
  stepGreater: (step) ->
    currentStep = Router.current().params.step
    if not currentStep
      currentStep = 1
    currentStep >= step

Template.Index.created = ->

Template.Index.rendered = ->
  @redir = Deps.autorun ->
    party = Parties.current()
    if party and Meteor.user()
      console.log 'indo pra party'
      Router.go('party', _id: party._id)

Template.Index.destroyed = ->
  @redir.stop()
