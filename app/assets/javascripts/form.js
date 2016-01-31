function expand_form(html_form){
  setTimeout(function(){
    $("body, html").animate({ scrollTop: $('#myForm').offset().top }, 2000);
  }, 2000);
};

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
  $('.plus-pet').on('click', function(){
    unbind_events_form();
    get_html_form_from_api(null);
  });  
};

function update_a_pet(){
  $('figure.link_to_form').on('click',function(event){
    unbind_events_form();
    var id = $(event.currentTarget).attr('data-id');
    get_html_form_from_api(id);
  });
};

function close_form(){
  $('.close-form').on('click',function(){
    if ($('.close-form').is(':visible')) $('.close-form').toggle();
    $('#myForm').empty();
    if ($('#myForm').is(':visible')) $('#myForm').toggle();
    unbind_events_form();
    $("body, html").animate({ scrollTop: $('.blockquote-reverse').offset().top }, 1000)
    add_a_new_pet();
  });
};