function modal_form_events(){
  
  $('#btn-image').on('click',function(){
    $('#input-img-file').click();
  });

  $('#input-img-file').on('change',function(){
    $('#image_input_text').html($(this).val().split(/[\\\\|/]/).pop());
    refresh_sample_img();
  });

  manage_buttons();

};

function load_modal_form(){

  $('figure.link_to_form').on('click',function(event){
    var id = $(event.currentTarget).attr('data-id');
    $('figure.link_to_form').off('click');
    get_html_form_from_api(id);
  });

  $('#plus-pet').on('click', function(){
    get_html_form_from_api(null);
  });

};

function log_out(){
  $("#log-out").on('click', function(){
    window.location("http://localhost:3000/users/sign_in");
  });
};

function add_a_new_pet(){
  
}