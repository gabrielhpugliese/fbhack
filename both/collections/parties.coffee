@Parties = new Meteor.Collection 'parties'

Parties.current = ->
  #@find({ownerId: aqui})
  @find().sort({_id: 1}).last()
