function create_photowall(list_of_pets){
  var html = "";
  //button add pet
  html += "<figure class='picture plus-pet'";
  html += " data-title='add a pet' ";
  html += "data-url='images/add_photo.jpg'></figure>";
  list_of_pets.forEach(function(pet){
    if($('#myForm').attr('data-name') == pet.user_name){
      html += "<figure class='picture link_to_form' ";
      html += "data-id='"+ pet['id'] +"' ";
      html += "data-birth='"+  pet['birth']+"' ";
      html += "data-title='I am "+ pet['name'] +" - "+ pet.age +" old' ";
      html += "data-url='"+ pet.images_urls.zoom +"'></figure>";
    }else{
      html += "<figure class='picture' ";
      html += "data-title='I am "+ pet['name'] +" - "+ pet.age +" old' ";
      html += "data-url='"+ pet.images_urls.zoom +"'></figure>";
    }
  });
  $('.gallery').html(html);
};

