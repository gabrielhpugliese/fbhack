/*****************************************************************************/
/* PartiuForm: Event Handlers and Helpers */
/*****************************************************************************/
Template.Partiuform1.events({
  'submit form': function(e,tumbl){
    e.preventDefault();

    var party = {
      title: $(e.target).find('[name=title]').val()
    }

    party._id = Parties.insert(party);

    Router.go('/partiu/2');
  }
});

Template.Partiuform1.helpers({
  /*
   * Example: 
   *  items: function () {
   *    return Items.find();
   *  }
   */
});

/*****************************************************************************/
/* PartiuForm: Lifecycle Hooks */
/*****************************************************************************/
Template.Partiuform1.created = function () {
};

Template.Partiuform1.rendered = function () {
};

Template.Partiuform1.destroyed = function () {
};
