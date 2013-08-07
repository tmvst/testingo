ix = 1

answer_template= () ->
	"""
		<div class="answerblock">
		<input class="checkInput" name="check#{ix}" type="checkbox" value="">
		<input name="text#{ix}" class="checkInput"> 
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
	textQ = $('input[name=text]').val()
	bodyQ = $('input[name=points]').val()
	fields = $(":input.checkInput").serializeArray()

	$.ajax
		url: post_url
		type: "post"
		data: (	
			text: textQ
			points: bodyQ
			fields: fields )
	.done (response) -> 
		alert "Done!"
	.fail () -> 
		alert "Fail!"
	return false


$(document).ready () ->
	answer = $('#answer')
	answer.html(button_template())
	$('#submit').click(process_submit)
	$('#answer').on('click', '.delete-button', delete_entry)
	$("#input_form_checkbox").submit(form_submit)
