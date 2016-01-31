// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  
  var site = $('body');
  if (site.hasClass('true')){
    get_info_from_api('pets/all');
  };

  log_out();  
  
});