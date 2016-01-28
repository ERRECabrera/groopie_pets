// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function get_info_from_api(url){
  var request = $.get(url);
  request.done(function(response){
    var pets_list = response;
    create_photowall(pets_list);
    jQuery(function($){
      $('.gallery').latae({
        displayTitle: true,
        loader: 'images/loading.gif'
      });
    });
    load_form();
  });
  request.fail(function(response){
    $('.notice').attr('class','alert alert-danger text-center');
    $('.alert').html(response.error);
  });
};

function get_html_form_from_api(pet_id){
  if(pet_id == null){
    $.post('pets/form').done(function(response){
      var form = response;
      $('#myForm').html(form);
      form_events();
    });
  }else{
    var datas = {pet: { id: pet_id}};
    $.post('pets/form',datas).done(function(response){
      var form = response;
      $('#myForm').html(form);
      form_events();
    });
  };  
};