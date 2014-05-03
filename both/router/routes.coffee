###
Client and Server Routes
###
Router.configure
  layoutTemplate: 'MasterLayout'
  loadingTemplate: 'Loading'
  notFoundTemplate: 'NotFound'
  templateNameConverter: 'upperCamelCase'
  routeControllerNameConverter: 'upperCamelCase'

Router.map ->
  this.route 'redirect', path: '/', template: "Index", controller: "RedirectController"
  this.route 'index', path: '/partiu'
  this.route 'step', path: '/partiu/:title/:step', template: "Index"

  this.route 'party', path: '/partida/:_id'
  this.route 'past.parties', path: '/partidas'
# end map
#
Router.onBeforeAction ->
  unless Meteor.user()
    Router.go('index')
, except: ['redirect', 'index']
