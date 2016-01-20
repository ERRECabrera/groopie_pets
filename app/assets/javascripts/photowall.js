function create_photowall(){
  var html = "";
  pets_list.forEach(function(pet){
    if($('#myForm').attr('data-name') == pet.name_user){
      html += "<figure class='picture link_to_form' data-id='"+ pet['id'] +"' data-title='I am "+ pet['name'] +" - "+ pet.age +" years old' data-url='"+ pet.images_urls.zoom +"'></figure>";
    }else{
      html += "<figure class='picture' data-title='I am "+ pet['name'] +" - "+ pet.age +" years old' data-url='"+ pet.images_urls.zoom +"'></figure>";
    }
  });
  $('.gallery').html(html);
};

