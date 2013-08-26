form_submit = (redir) ->
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
				answers: answers
				correctness: correctness
				is_q_mandatory: is_q_mandatory
		.done (response) ->
			top.location.href = redir
		.fail (response) ->
			console.log response

	return false

$(document).ready () ->
	$('#save_changes').click(() -> form_submit(post_url))
	$('#create_answer_showQ').click(() ->
		input_template @id, @name)
