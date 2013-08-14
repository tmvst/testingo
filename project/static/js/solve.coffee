form_submit = () ->
  user_answers_S = $("input.user_answers_S").serializeArray()
  user_answers_C = $("input.user_answers_C").serialize()
  $.ajax
    url: post_url
    type: "POST"
    contentType: "application/json; charset=utf-8"
    data: JSON.stringify
      user_answers_S: user_answers_S
      user_answers_C: user_answers_C
  .done (response) ->
      top.location.href = "/dashboard"
  .fail (response) ->
      alert('kkt')
      console.log response
  return false

$(document).ready () ->
  $('#form_solve').submit(() -> false)
  $("#solve_test").click(form_submit)
