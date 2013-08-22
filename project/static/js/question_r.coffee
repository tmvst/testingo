ix = 1

answer_template= () ->
	"""
		<div class="answerblock">
		<input class="Rradio" name="radio" type="radio" value="radio#{ix}">
		<input name="text1#{ix}" class="radiotext form-control">
		<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""

button_template= () ->
	"""
	<a class="btn btn-default btn-sm" id='submit'> Pridať odpoveď </a> <br>
	"""

process_submit = () ->
	$('#answer_r').append(answer_template())
	ix++
	update_cnt()

update_cnt = () ->
	cnt = $('.radiotext').length

delete_entry = (e) ->
	$(e.target).parent().remove()

form_submit = (redir) ->
	$('#form_r').validate
		rules:
			text:
				required: true
			points:
				number: true
		messages:
			text: "Prosím zadajte text otázky"
			points:
				number: "Body musia byť číslo"

	if $('#form_r').valid()

		textQ = $("textarea[name='text']").val()
		bodyQ = $("input[name='points']").val()
		answers = $("input.radiotext").serializeArray()
		correctness = $("input.Rradio").serializeArray()
		is_q_mandatory = $('#is_q_mandatory').is(':checked')

		$.ajax
			url: post_url
			type: "POST"
			contentType: "application/json; charset=utf-8"
			data: JSON.stringify
				text: textQ
				is_q_mandatory: is_q_mandatory
				points: bodyQ
				answers: answers
				correctness: correctness
		.done (response) ->
			top.location.href = redir
		.fail (response) ->
			console.log response

	return false


$(document).ready () ->
	answer = $('#answer_r')
	answer.html(button_template())
	$('#submit').click(process_submit)
	$('#answer_r').on('click', '.delete-button', delete_entry)

	$('#form_r').submit(() -> false)

	new_s_url = test_url + "/new-phrase-question"
	new_c_url = test_url + "/new-checkbox-question"
	new_r_url = test_url + "/new-radio-question"
	new_o_url = test_url + "/new-open-question"

	$("#save_and_add_s").click(() -> form_submit(new_s_url))
	$("#save_and_add_c").click(() -> form_submit(new_c_url))
	$("#save_and_add_r").click(() -> form_submit(new_r_url))
	$("#save_and_add_o").click(() -> form_submit(new_o_url))

	$("#save_and_end").click(() -> form_submit(test_url))
