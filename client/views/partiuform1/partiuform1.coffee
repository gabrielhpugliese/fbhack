Template.Partiuform1.events
  'submit form': (e,tumbl) ->
    e.preventDefault()

    party = {
      title: $(e.target).find('[name=title]').val()
    }

    party._id = Parties.insert(party)

    Router.go('step',{title: party.title, step: 2})

Template.Partiuform1.helpers {}

Template.Partiuform1.created = ->

Template.Partiuform1.rendered = ->

Template.Partiuform1.destroyed = ->
