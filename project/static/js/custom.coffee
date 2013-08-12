
ix = 1

answer_template= () ->
	"""
		<div class="answerblock">
		<input class="checkInputC" name="check#{ix}" type="checkbox" value="">
		<input name="text#{ix}" class="checkInput form-control">
		<div class="btn btn-default btn-small delete-button"> Zmazať odpoveď </div> <br>
		</div>
	"""

button_template= () ->
	"""
	<a class="btn btn-default btn-small" id='submit'> Pridať odpoveď </a> <br>
	"""

process_submit = () ->
	$('#answer').append(answer_template())
	ix++
	update_cnt()

update_cnt = () ->
	cnt = $('.checkInput').length

delete_entry = (e) ->
	$(e.target).parent().remove()

form_submit = () ->
	q_type = $("input[name='q_typeC']").val()
	textQ = $("textarea[name='textC']").val()
	bodyQ = $("input[name='points2']").val()
	answers = $("input.checkInput").serializeArray()
	correctness = $("input.checkInputC").serializeArray()


	$.ajax
		url: post_url
		type: "POST"
		contentType: "application/json; charset=utf-8"
		data: JSON.stringify
			q_type: q_type
			text: textQ
			points: bodyQ
			answers: answers
			correctness: correctness
	.done (response) ->
		top.location.href="/"
	.fail () -> 
		alert "Fail!"	
	return false


$(document).ready () ->
	answer = $('#answer')
	answer.html(button_template())
	$('#submit').click(process_submit)
	$('#answer').on('click', '.delete-button', delete_entry)
	$("#input_form_checkbox").submit(form_submit)
