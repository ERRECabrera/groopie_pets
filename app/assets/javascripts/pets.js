// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function get_info_from_api(url){
  $.get(url).done(function(response){
      pets_list = response;
      create_photowall();
      jQuery(function($){
        $('.gallery').latae({
          displayTitle: true,
          loader: 'images/loading.gif'
        });
      });
      load_modal_form();
    });
};

function get_html_form_from_api(pet_id){
  if(pet_id == null){
    $.post('pets/modal_form').done(function(response){
      modal_form = response;
      $('#myForm').html(modal_form);
      modal_form_events();
    });
  }else{
    var datas = {pet: { id: pet_id}};
    $.post('pets/modal_form',datas).done(function(response){
      modal_form = response;
      $('#myForm').html(modal_form);
      modal_form_events();
    });
  };  
};