@Posts = new Meteor.Collection 'posts'

###
  Add query methods like this:
   Posts.findPublic ->
     Posts.find is_public: true
###
