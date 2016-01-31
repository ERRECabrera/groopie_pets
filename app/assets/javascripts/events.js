function form_events(){

  if ($('.close-form').is(':hidden')) $('.close-form').toggle();
  
  $('#btn-image').on('click',function(){
    $('#input-img-file').click();
  });

  $('#input-img-file').on('change',function(){
    $('#image_input_text').html($(this).val().split(/[\\\\|/]/).pop());
    refresh_sample_img();
  });

  manage_buttons();

  close_form();
  update_a_pet();

};

function event_images(){
  
  update_a_pet();
  add_a_new_pet();

};

function log_out(){
  $("#log-out").on('click', function(){
    window.location("http://localhost:3000/users/sign_in");
  });
};

function unbind_events_form(){
  //$('figure.link_to_form').off('click');
  $('.plus-pet').off('click');
  $('.close-form').on('click');
  $('.update-form').off('click');
  $('.delete-form').off('click');
  $('#btn-image').off('click');
  $('#input-img-file').off('change');
};