$(document).ready(function(){

  $('.select, .date').change(function(){
    $(this).addClass('selected');
  });

  $('#user_dob').datepicker({
    format: "dd/mm/yyyy",
    orientation: "bottom auto",
    language: "fr"
  });

});
