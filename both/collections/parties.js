@Parties = new Meteor.Collection 'parties'

@Parties.current = ->
  #@find({ownerId: aqui})
  @findOne()
