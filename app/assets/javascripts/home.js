// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('#myForm').toggle();

$(document).ready(function(){

  get_info_from_api('pets/all');

  log_out();  
  
});