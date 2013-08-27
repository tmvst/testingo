check_template = () ->
	"""
		<div class="answerblock">
			<input class="indikator" type="checkbox" value="">
			<input class="text form-control">
			<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""
radio_template = () ->
	"""
		<div class="answerblock">
			<input class="indikator" type="radio" value="">
			<input class="text form-control">
			<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""
phrase_template = () ->
	"""
		<div class="form-group">
			<label for="odpoved"></label>
			<input class="text form-control" placeholder="Správna odpoveď">
			<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""

input_template = (Qtyp) ->
	alert(Qtyp)
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
		messages:
			text: "Prosím zadajte text otázky"
			points:
				number: "Body musia byť číslo"

	if $('#form_showQ').valid()

		textQ = $("textarea[name='text']").val()
		bodyQ = $("input[name='points']").val()

		if not not $("textarea.text")
			answers = $("input.text").serializeArray()
			correctness = $("input.indikator").serializeArray()
		else 
			answers = $("textarea.text").val()
			correctness = true

		is_q_mandatory = $('#is_q_mandatory').is(':checked')

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
		form_submit(post_url, @name))
	$('#create_answer_showQ').click(() ->
		input_template @name)
	$('#odpovede_showQ').on('click', '.delete-button', delete_entry)
