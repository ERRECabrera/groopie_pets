function refresh_sample_img(){
  var img_file = document.getElementById('input-img-file').files[0];
  var file = img_file;
  var url_img = URL.createObjectURL(img_file);
  $('#form-img-sample').attr('src', url_img).load();
};

function manage_buttons(){
  
  $('.update-form').on('click',function(event){
    event.preventDefault();

    // Problems with image upload with paperclip, now is not possible single page

    /*var id = $("input[name='pet[id]']").val();
    var name = $("input[name='pet[name]']").val();
    var age = $("input[name='pet[age]']").val();
    var animal = $("select[name='pet[animal]']").val();
    //var image = URL.createObjectURL(document.getElementById('input-img-file').files[0]).replace('blob:','');
    var token = $("input[name='authenticity_token']").val();
    var pet = {
          id: id,
          name: name,
          age: age,
          animal: animal//,
          //image: image
        }
    var data = {utf8: "✓", authenticity_token: token, pet: pet, commit: "Sign up"};
    $.post('pets/update',data,function(response){
      $('#myForm').empty();
      $('.notice').empty().html('Pet updates');
      get_info_from_api('pets/all');
    })*/

    $('form').attr('action','pets/update');
    $('form').submit();
  });

  $('.delete-form').on('click',function(event){
    event.preventDefault();
    $('form').attr('action','pets/destroy');
    $('form').submit();
  });

};

function add_a_new_pet(){
  $('#plus-pet').on('click', function(){
    $('#plus-pet').off('click');
    get_html_form_from_api(null);
  });  
};

function update_a_pet(){
  $('figure.link_to_form').on('click',function(event){
    $('figure.link_to_form').off('click');
    var id = $(event.currentTarget).attr('data-id');
    get_html_form_from_api(id);
  });
};

function empty_form_save(){
  $('#plus-pet').on('click',function(){
    $('#myForm').empty();
    $('#plus-pet').off('click');
    add_a_new_pet();
  });
};

function empty_form_update_or_delete(){
  $('figure.link_to_form').on('click',function(){
    $('#myForm').empty();
    $('figure.link_to_form').off('click');
    update_a_pet();
  });
};