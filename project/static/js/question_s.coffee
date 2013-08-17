ix_s = 1

answer_template= () ->
	"""
		<div class="form-group">
			<label for="odpoved">#{ix_s}.</label>
			<input type="text" id="odpoved" name="odpoved" class="phrase form-control" placeholder="Správna odpoveď">
			<div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
		</div>
	"""

button_template= () ->
	"""
	<a class="btn btn-default btn-sm" id='submit'> Pridať odpoveď </a> <br>
	"""

process_submit = () ->
	$('#answer_s').append(answer_template())
	ix_s++
	update_cnt()

update_cnt = () ->
	cnt = $('.checkInput').length

delete_entry = (e) ->
	$(e.target).parent().remove()

form_submit = (redir) ->
	$('#form_s').validate
		rules:
			text:
				required: true
			points:
				number: true
		messages:
			text: "Prosím zadajte text otázky"
			points:
				number: "Body musia byť číslo"

	if $('#form_s').valid()

		textQ = $("textarea[name='text']").val()
		bodyQ = $("input[name='points']").val()
		answers = $("input.phrase").serializeArray()
		answer = $("input[name='odpoved']").val()

		$.ajax
			url: post_url
			type: "POST"
			contentType: "application/json; charset=utf-8"
			data: JSON.stringify
				text: textQ
				points: bodyQ
				answers: answers
				answer: answer
		.done (response) ->
			top.location.href = redir
		.fail (response) -> 
			console.log response

	return false


$(document).ready () ->
	answer = $('#answer_s')
	answer.html(button_template())
	$('#submit').click(process_submit)
	$('#answer_s').on('click', '.delete-button', delete_entry)
	
	$('#form_s').submit(() -> false)

	new_s_url = test_url + "/new-phrase-question"
	new_c_url = test_url + "/new-checkbox-question"
	new_r_url = test_url + "/new-radio-question"
	new_o_url = test_url + "/new-open-question"

	$("#save_and_add_s").click(() -> form_submit(new_s_url))
	$("#save_and_add_c").click(() -> form_submit(new_c_url))

	$("#save_and_end").click(() -> form_submit(test_url))