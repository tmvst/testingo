ix = 1

answer_template= () ->
	"""
		<div class="answerblock">
		<input class="checkInputC" name="check#{ix}" type="checkbox" value="">
		<input name="text#{ix}" class="checkInput form-control">
		<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""

process_submit = () ->
	$('#answer').append(answer_template())
	ix++
	update_cnt()

update_cnt = () ->
	cnt = $('.checkInput').length

delete_entry = (e) ->
	$(e.target).parent().remove()

form_submit = (redir) ->
	$('#form_c').validate
		rules:
			text:
				required: true
			points:
				number: true
		messages:
			text: "Prosím zadajte text otázky"
			points:
				number: "Body musia byť číslo"

	if $('#form_c').valid()

		textQ = $("textarea[name='text']").val()
		bodyQ = $("input[name='points']").val()
		answers = $("input.checkInput").serializeArray()
		correctness = $("input.checkInputC").serializeArray()
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
	answer = $('#answer')
	process_submit()
	$('#submit').click(process_submit)
	$('#answer').on('click', '.delete-button', delete_entry)

	$('#form_c').submit(() -> false)

	new_s_url = test_url + "/new-phrase-question"
	new_c_url = test_url + "/new-checkbox-question"
	new_r_url = test_url + "/new-radio-question"
	new_o_url = test_url + "/new-open-question"

	$("#save_and_add_s").click(() -> form_submit(new_s_url))
	$("#save_and_add_c").click(() -> form_submit(new_c_url))
	$("#save_and_add_r").click(() -> form_submit(new_r_url))
	$("#save_and_add_o").click(() -> form_submit(new_o_url))

	$("#save_and_end").click(() -> form_submit(test_url))
