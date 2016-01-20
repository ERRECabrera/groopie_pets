var file = null;

function refresh_sample_img(){
  var img_file = document.getElementById('input-img-file').files[0];
  file = img_file;
  var url_img = URL.createObjectURL(img_file);
  $('#form-img-sample').attr('src', url_img).load();
};

function manage_buttons(){
  
  $('.update-form').on('click',function(event){
    event.preventDefault();
    $('form').attr('action','pets/update');
    $('form').submit();
  });

  $('.delete-form').on('click',function(event){
    event.preventDefault();
    $('form').attr('action','pets/destroy');
    $('form').submit();
    $('.delete-form').off('click');
  });

};