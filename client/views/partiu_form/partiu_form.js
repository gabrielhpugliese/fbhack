/*****************************************************************************/
/* PartiuForm: Event Handlers and Helpers */
/*****************************************************************************/
Template.PartiuForm.events({
  'submit form': function(e,tumbl){
    e.preventDefault();

    var party = {
      title: $(e.target).find('[name=title]').val()
    }

    party._id = Parties.insert(party);

    Router.go('/partiu/2');
  }
});

Template.PartiuForm.helpers({
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
Template.PartiuForm.created = function () {
};

Template.PartiuForm.rendered = function () {
};

Template.PartiuForm.destroyed = function () {
};
