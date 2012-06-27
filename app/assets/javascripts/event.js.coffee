$(document).ready ->
  percentage = $("#progressbar").data('percent-done')
  $("#datepicker").datepicker()
  $("#timepicker").timepicker()
  $("#progressbar").progressbar({ value: percentage })
  
  $("#go_to_step_2").bind 'click', (event) =>
    $('#start_date_field').val($("#datepicker").datepicker("getDate"))
    $('#start_time_field').val($('#timepicker').timepicker('getTime'))
    $('#start_time_form').submit()
  
  $("#go_to_step_3").bind 'click', (event) =>
    $('#event_place_form').submit()

  $("#go_to_step_4").bind 'click', (event) =>
    $('#event_restaurant_form').submit()