@IndexController = RouteController.extend
  waitOn: ->

  data: ->

  action: ->
    Session.set('step',this.params.step)
    this.render()
