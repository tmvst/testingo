form_submit = (redir) ->
	$('#form_o').validate
		rules:
			text:
				required: true
			points:
				number: true
		messages:
			text: "Prosím zadajte text otázky"
			points:
				number: "Body musia byť číslo"

	if $('#form_o').valid()

		textQ = $("textarea[name='text']").val()
		bodyQ = $("input[name='points']").val()
		answer = $("textarea[name='odpoved']").val()
		console.log(bodyQ)
		console.log(textQ)
		console.log(answer)

		$.ajax
			url: post_url
			type: "POST"
			contentType: "application/json; charset=utf-8"
			data: JSON.stringify
				text: textQ
				points: bodyQ
				answer: answer
		.done (response) ->
			top.location.href = redir
		.fail (response) ->
			console.log response

	return false


$(document).ready () ->
	answer = $('#answer_o')
	$('#form_o').submit(() -> false)

	new_s_url = test_url + "/new-phrase-question"
	new_c_url = test_url + "/new-checkbox-question"
	new_r_url = test_url + "/new-radio-question"
	new_o_url = test_url + "/new-open-question"

	$("#save_and_add_s").click(() -> form_submit(new_s_url))
	$("#save_and_add_c").click(() -> form_submit(new_c_url))
	$("#save_and_add_r").click(() -> form_submit(new_r_url))
	$("#save_and_add_o").click(() -> form_submit(new_o_url))

	$("#save_and_end").click(() -> form_submit(test_url))
