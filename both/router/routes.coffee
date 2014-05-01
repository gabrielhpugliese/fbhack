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
  this.route 'index', path: '/partiu/:step'
# end map
