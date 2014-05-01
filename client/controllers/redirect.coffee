@RedirectController = RouteController.extend
  waitOn: ->

  data: ->

  action: ->
    Session.set('step',1)
    Router.go('/partiu/1')
