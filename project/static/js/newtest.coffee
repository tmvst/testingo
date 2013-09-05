time_input_value = () ->
  $('.timeinput').val("")

form_submit = () ->
  $('#new_test').validate
    rules:
      name:
        required: true
        maxlength: 100
      description:
        required: true
        maxlength: 500
    messages:
      name:
        required: "Prosím zadajte nadpis testu"
        maxlength: "Názov je príliš dlhý"
      description:
        required: "Prosím zadajte popis testu"
        maxlength: "Popis je príliš dlhý"

$(document).ready () ->
  $('#create_test').click(() ->
    form_submit())
  $('#input_value').click(() ->
    time_input_value())