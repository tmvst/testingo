input_template= (points)	->
	"""
		<a href="#" class="pull-right"> Uložiť </a>
		<input class="pull-right" value="#{points}"> 
	"""
hide_process = (event) ->
	points= $('.badge').html()
	console.log event.target
	event.target.siblings('.badge').hide()
	$('.panel-title').append(input_template(points))
	$('.zbody').hide()

$(document).ready () ->
	ebody = $('.zbody')
	$('.zbody').click((event) -> hide_process(event))