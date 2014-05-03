$( document ).ready(function() {
    $('#title').focus();

    $('#user_selector').on('click', '.user_group', function(e){
        e.preventDefault();
        $(this).toggleClass('selected');
    });

    $('#users').on('click', '.user', function(e){
      e.preventDefault();
      $(this).toggleClass('selected');
    });
});