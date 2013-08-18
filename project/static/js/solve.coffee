form_submit = () ->
  user_answers_S = $("input.user_answers_S").serializeArray()
  user_answers_C = $("input.user_answers_C").serialize()
  user_answers_R = $("input.user_answers_R").serialize()
  user_answers_O = $("textarea.user_answers_O").serializeArray()
  $.ajax
    url: post_url
    type: "POST"
    contentType: "application/json; charset=utf-8"
    data: JSON.stringify
      user_answers_S: user_answers_S
      user_answers_C: user_answers_C
      user_answers_R: user_answers_R
      user_answers_O: user_answers_O
      console.log(user_answers_O)
  .done (response) ->
      top.location.href = "/dashboard"
  .fail (response) ->
      alert('nepodarilo sa. bohuzial :( prepac')
      console.log response
  return false

$(document).ready () ->
  $('#form_solve').submit(() -> false)
  $("#solve_test").click(form_submit)
