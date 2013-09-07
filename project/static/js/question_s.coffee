ix_s = 1

answer_template= () ->
	"""
		<div class="form-group">
      <div class='row'>
        <div class='col-sm-4'>
			    <input type="text" id="s#{ix_s}" name="odpoved" class="phrase form-control" placeholder="Správna odpoveď" required>
        </div>
        <div class='col-sm-2'>
			    <div class="btn btn-default delete-button"> Zmazať </div><br>
        </div>
       </div>
		</div>
	"""

process_submit = () ->
	$('#answer_s').append(answer_template())
	ix_s++
	update_cnt()

update_cnt = () ->
	cnt = $('.phrase').length

delete_entry = (e) ->
	$(e.target).parent().parent().remove()

form_submit = (redir) ->
	$('#form_s').validate
		rules:
			text:
				required: true
			points:
				number: true
			odpoved:
				required: true
		messages:
			text: "Prosím zadajte text otázky"
			points:
				number: "Body musia byť číslo"
			odpoved:
				required: "Prosím zadajte text odpovede"

	if $('#form_s').valid()

		textQ = $("textarea[name='text']").val()
		bodyQ = $("input[name='points']").val()
		answers = $("input.phrase").serializeArray()
		is_q_mandatory = $('#is_q_mandatory').is(':checked')

		$.ajax
			url: post_url
			type: "POST"
			contentType: "application/json; charset=utf-8"
			data: JSON.stringify
				text: textQ
				points: bodyQ
				answers: answers
				is_q_mandatory: is_q_mandatory
		.done (response) ->
			top.location.href = redir
		.fail (response) ->
			console.log response

	return false


$(document).ready () ->
	answer = $('#answer_s')
	process_submit()
	$('#submit').click(process_submit)
	$('#answer_s').on('click', '.delete-button', delete_entry)

	$('#form_s').submit(() -> false)

	new_s_url = test_url + "/new-phrase-question"
	new_c_url = test_url + "/new-checkbox-question"
	new_r_url = test_url + "/new-radio-question"
	new_o_url = test_url + "/new-open-question"

	$("#save_and_add_s").click(() -> form_submit(new_s_url))
	$("#save_and_add_c").click(() -> form_submit(new_c_url))
	$("#save_and_add_r").click(() -> form_submit(new_r_url))
	$("#save_and_add_o").click(() -> form_submit(new_o_url))

	$("#save_and_end").click(() -> form_submit(test_url))
