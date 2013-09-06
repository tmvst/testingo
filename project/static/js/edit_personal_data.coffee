form_submit = (post_url) ->
  $('#form_editPD').validate
    rules:
      user_name:
        required: true
      email:
        required: true
    messages:
      user_name:
        required: "Prosím zadajte Vaše meno a priezvisko"
      email:
        required: "Prosím zadajte Váš platný e-mail"

  if $('#form_editPD').valid()
    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        user_name: $("#user_name").val()
        email: $("#email").val()
        con: 1
    .done (response) ->
      top.location.href = post_url
    .fail (response) ->
      console.log response
    return false

$(document).ready () ->
  $('#submit_data').click () ->
    form_submit (post_url)