ix = 0
update_cnt = (ix) ->
  ix = $('input.indikator').length
  return ix

check_template = () ->
	"""
		<div class="answerblock">
			<input class="indikator" type="checkbox" name="ind#{ix}" value="">
			<input class="text form-control" name="text#{ix}">
			<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""
radio_template = () ->
	"""
		<div class="answerblock">
			<input class="indikator" type="radio" name="radio" value="ind#{ix}">
			<input class="text form-control" name="text#{ix}">
			<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""
phrase_template = () ->
	"""
		<div class="form-group">
			<label for="odpoved"></label>
			<input class="text form-control indikator" id="text#{ix}" placeholder="Správna odpoveď">
			<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""

input_template = (Qtyp) ->
	ix = update_cnt ix
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
		messages:
			text: "Prosím zadajte text otázky"
			points:
				number: "Body musia byť číslo"

	if $('#form_showQ').valid()

		textQ = $("textarea[name='text']").val()
		bodyQ = $("input[name='points']").val()
		console.log bodyQ

		if $("textarea.text").val()
			answers = $("textarea.text").val()
			correctness = true
			console.log("textarea")
		else
			answers = $("input.text").serializeArray()
			correctness = $("input.indikator").serializeArray()
			console.log("input")

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
