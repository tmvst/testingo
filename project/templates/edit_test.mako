<div id="newq">
    <form action="#" id="form_showT">
        <div class="form-group">
            <label for="name">Názov</label>
            <input type="text" id="edit_name" name="name_test" class="form-control" value="${test.name}" required>
        </div>
        <div class="form-group">
            <label for="description">Opis testu</label>
            <textarea class="form-control" name="description_test" id="edit_description" rows="3" required>${test.description}</textarea>
        </div>

        <div class="form-group">
			<label for="start_time">Čas otvorenia:</label>
            % if test.start_time:
                <input class="form-control timeinput" type="text" id="start_time" name="edit_start_time" value="${test.start_time.strftime('%m/%d/%Y %H:%M')}">
            % else:
                <input class="form-control timeinput" type="text" id="start_time" name="edit_start_time">
            % endif
	    </div>
		<div class="form-group">
	        <label for="end_time">Čas uzatvorenia:</label>
            % if test.end_time:
                <input class="form-control timeinput" type="text" id="end_time" name="edit_end_time" value="${test.end_time.strftime('%m/%d/%Y %H:%M')}">
            % else:
                <input class="form-control timeinput" type="text" id="end_time" name="edit_end_time">
            % endif
        </div>
	    <a class="btn btn-default" id="input_value">Neobmedzene</a>
    </form>
</div>