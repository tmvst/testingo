form_submit = (redir) ->
  $('#form-signin').validate
    rules:
      login:
        required: true
      email:
        email: true
        required: true
      password:
        required: true
        minlength: 6
    messages:
      login: "Prosím zadajte meno"
      email:
        required: "Prosím zadajte email"
        email: "Emailová adresa je v zlom tvare"
      password:
        required: "Prosím zadajte heslo"
        minlength: "Heslo musí mať aspoň 6 znakov"
    errorPlacement: (error, element) ->
      element.popover
        trigger: "focus"
        placement: "left"
        content: error.html()

  if not $('#form-signin').valid()
    if $(".sred").length == 0 # aby sme nemali zaplavu vykricnikov
      $(".form-signin-heading").append(""" <small class="sred"><span class="glyphicon glyphicon-exclamation-sign"></span></small>""")

    $(".sred").tooltip
      title: "Formulár obsahuje chyby"
    $(".sred").tooltip("show")

  if $('#form-signin').valid()
    name = $("input[name='login']").val()
    email = $("input[name='email']").val()
    pass = $("input[name='password']").val()

    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        login: name
        email: email
        password: pass
    .done () ->
        top.location.href = redir
    .fail (response) ->
        console.log response
  return false

$(document).ready () ->
  $('#submit').click(() ->
    form_submit(post_url))