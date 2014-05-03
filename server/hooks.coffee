Parties.before.insert (userId,doc) ->
  doc.createdAt = Date.now()
  doc.ownerId = userId
  doc.status = 'editing'
