
ix = 1

answer_template= () ->
	"""
		<div class="answerblock">
		<input class="checkInputC" name="check#{ix}" type="checkbox" value="">
		<input name="text#{ix}" class="checkInput form-control">
		<div class="btn btn-default btn-small delete-button"> Zmazať </div> <br>
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
	q_type = $("input[name='q_type']").val()
	textQ = $("textarea[name='text']").val()
	bodyQ = $("input[name='points']").val()
	answers = $("input.checkInput").serializeArray()
	answer = $("input[name='odpoved']").val()
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
			answer: answer
			correctness: correctness
	.done (response) ->
		top.location.href = "/dashboard"
	.fail () -> 
		alert "Fail!"
	return false


$(document).ready () ->
	answer = $('#answer')
	answer.html(button_template())
	$('#submit').click(process_submit)
	$('#answer').on('click', '.delete-button', delete_entry)
	
	$("#input_form_checkbox").submit(form_submit)
	$("#input_form_s").submit(form_submit)
