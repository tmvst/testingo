form_submit = (post_url) ->
  $('#form-change_password').validate
    rules:
      password:
        required: true
      password_repeat:
        required: true
        equalTo: "#new_password"
      new_password:
        required: true
        minlength: 6
    messages:
      password:
        required: "Prosím zadajte vaše aktuálne heslo"
      password_repeat:
        required: "Prosím zadajte opätovne nové heslo "
        equalTo: "Heslá sa nezhodujú"
      new_password:
        required: "Prosím zadajte nové heslo"
        minlength: "Heslo musí mať aspoň 6 znakov"

  if $('#form-change_password').valid()
    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        current_password: $("#current_password").val()
        new_password: $("#new_password").val()
        new_password2: $("#password_repeat").val()
    .done (response) ->
        top.location.href = post_url
    .fail (response) ->
        console.log response
    return false


$(document).ready () ->
  $('#submit').click () ->
    form_submit (post_url)