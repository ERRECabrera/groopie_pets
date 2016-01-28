function form_events(){
  
  $('#btn-image').on('click',function(){
    $('#input-img-file').click();
  });

  $('#input-img-file').on('change',function(){
    $('#image_input_text').html($(this).val().split(/[\\\\|/]/).pop());
    refresh_sample_img();
  });

  manage_buttons();

  empty_form_save();
  empty_form_update_or_delete()

};

function load_form(){
  
  update_a_pet();
  add_a_new_pet();

};

function log_out(){
  $("#log-out").on('click', function(){
    window.location("http://localhost:3000/users/sign_in");
  });
};

