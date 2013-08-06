answer_template= () ->
	"""
	<div class="answerblock">
	<input name="checkOdpoved" type="checkbox" value="">
	<input name="odpoved" class="checkInput"> 
	<div class="btn btn-default btn-small delete-button"> Zmazať odpoveď </div> <br> 
	</div>
	"""

button_template= () ->
	"""
	<a class="btn btn-default btn-small" id='submit'> Pridať odpoveď </a> <br> 
	"""

process_submit = () ->
	$('#answer').append(answer_template())
	update_cnt()

update_cnt = () ->
    cnt=$('.checkInput').length

delete_entry = (e) ->
	#alert("Tu som hallo")
	$(e.target).parent().remove()

$(document).ready () ->
	answer=$('#answer')
	answer.html(button_template())
	$('#submit').click(process_submit)
	$('#answer').on('click', '.delete-button', delete_entry)