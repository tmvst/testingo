success_template = () ->
  """
  <div class="alert alert-success alert-dismissable">
  <button type="button" id ="success_alert_closer" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <p>Zmena hesla prebehla úspešne</p>
  </div>
  """
fail_template = () ->
  """
  <div id="wrong_password" class="alert alert-danger alert-dismissable">
  <button type="button" id ="alert_closer"class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
  <p>Zadal si nesprávne heslo, skús znovu</p>
  </div>
  """

remove_alert = () ->
  $("#alert_closer").click()
  return false

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
      success: (response) ->
        if response['errors']
          $('#error_alert').append(fail_template())
        else
          window.location.href = post_url
          $('#submit').prepend(success_template())
        return false
    .done (response) ->
      console.log "Done"
    .fail (response) ->
      console.log response
    return false

$(document).ready () ->

  $('#submit').click () ->
    remove_alert()
    form_submit (post_url)