@PartyController = RouteController.extend
  waitOn: ->

  data: ->
    Parties.findOne this.params._id

  action: ->
    this.render()
