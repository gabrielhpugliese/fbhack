UI.registerHelper "currentParty", ->
  if Meteor.user()
    Parties.current()

UI.registerHelper "smallImage", (id) ->
  "http://graph.facebook.com/"+id+"/picture"  
