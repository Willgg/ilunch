$(document).ready(function(){

  $('.select, .date').change(function(){
    $(this).addClass('selected');
  });

  $('#user_dob, #product_date').datepicker({
    format: "dd/mm/yyyy",
    orientation: "bottom auto",
    language: "fr"
  });

});
