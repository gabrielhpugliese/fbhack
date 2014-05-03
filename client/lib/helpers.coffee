UI.registerHelper "currentParty", ->
  Parties.current()

UI.registerHelper "smallImage", (id) ->
  "http://graph.facebook.com/"+id+"/picture"  
