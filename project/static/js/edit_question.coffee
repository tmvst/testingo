question_template= () ->
	"""
		<div class="modal fade">
		  <div class="modal-dialog">
		    <div class="modal-content">
			    <div class="modal-header">
			    	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			        <h4 class="modal-title">Modal title</h4>
			    </div>
			    <div class="modal-body">
			        <p>One fine body&hellip;</p>
			    </div>
			    <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
			    </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	"""

process_submit = () ->
	alert("tu_vykresli")
	$('.edit_question').html(question_template())

$(document).ready () ->
	question = $('#edit_question')
	$('#edit_question').click(process_submit)