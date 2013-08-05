answer_template= () ->
	"""
	<label>
	</label> 
	<input name="checkOdpoved" type="checkbox" value="">
	<input name="odpoved" id="checkboxName"> <br> 
	"""

button_template= () ->
	"""
	<a class="btn btn-default btn-small" id='submit'> Pridať odpoveď </a> <br> 
	"""

process_submit = () ->
	$('#answer').append(answer_template())

$ ()->
	answer=$('#answer')
	answer.html(answer_template()) 
	answer.html(button_template())
	$('#submit').click(process_submit)