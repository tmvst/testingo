question_template= () ->
	"""
		
	"""

process_submit = () ->
	alert("tu_vykresli")
	$('.edit_question').html(question_template())

$(document).ready () ->
	question = $('#edit_question')
	$('#edit_question').click(process_submit)