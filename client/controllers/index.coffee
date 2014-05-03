@IndexController = RouteController.extend
  waitOn: ->

  data: ->

  onBeforeAction: ->
    party = Parties.findOne status: 'active'
    if party
      Router.go('party', _id: party._id)

  action: ->
    this.render()
