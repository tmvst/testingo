ix = 0
get_cnt = (ix) ->
  ix = $('input.indikator').length
  return ix

check_template = () ->
  """
  <div class="answerblock">
  <input class="indikator checkInputC" type="checkbox" name="ind#{ix}" value="">
  <input class="text form-control radiotext" name="text#{ix}">
  <div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
  </div>
  """
radio_template = () ->
  """
  <div class="answerblock">
  <input class="indikator checkInputC" type="radio" name="radio" value="ind#{ix}">
  <input class="text form-control radiotext" name="text#{ix}">
  <div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
  </div>
  """
phrase_template = () ->
  """
  <div class="answerblock">
  <label for="odpoved"></label>
  <input class="text form-control radiotext indikator" name="odpoved" id="text#{ix}" placeholder="Správna odpoveď">
  <div class="btn btn-default btn-sm delete-button"> Zmazať </div>
  </div>
  """

input_template = (Qtyp) ->
  ix = get_cnt ix
  ix++
  if Qtyp is "S"
    $('#input_answer_showQ').append(phrase_template())
  if Qtyp is "R"
    $('#input_answer_showQ').append(radio_template())
  if Qtyp is "C"
    $('#input_answer_showQ').append(check_template())

delete_entry = (e) ->
  $(e.target).parent().remove()

form_submit = (redir,type) ->
  $('#form_showQ').validate
    rules:
      text:
        required: true
      points:
        number: true
      radio:
        required: true
    messages:
      text: "Prosím zadajte text otázky"
      points:
        number: "Body musia byť číslo"
      radio: "Prosím zvoľte aspoň jednu možnosť"

  if $('#form_showQ').valid()

    textQ = $("textarea[name='text']").val()
    bodyQ = $("input[name='points']").val()
    console.log bodyQ

    if $("textarea.text").val()
      answers = $("textarea.text").val()
      correctness = true
    else
      answers = [];
      $("input.text").each(() ->
        answers.push([parseInt($(this).attr('name').substr(4)), $(this).val()])
      )
      correctness =$("input.indikator").serializeArray()
    is_q_mandatory = $('#is_q_mandatory').is(':checked')
    console.log answers
    console.log correctness
    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        text: textQ
        points: bodyQ
        type: type
        answers: answers
        correctness: correctness
        is_q_mandatory: is_q_mandatory
    .done (response) ->
        top.location.href = redir
    .fail (response) ->
        console.log response

  return false

$(document).ready () ->
  $('#save_changes').click(() ->
    if $('.radiotext').length is 0
      $('#input_answer_showQ').append(radio_template())
      form_submit(post_url, @name)
    else
      form_submit(post_url, @name)
  $('#create_answer_showQ').click(() ->
    input_template @name)
  $('#odpovede_showQ').on('click', '.delete-button', delete_entry)
