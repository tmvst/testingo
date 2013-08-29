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

        <label for="name">Čas platnosti:</label>
        <div class="form-group">
            <input type="text" id="start_time" name="edit_start_time" value="${test.start_time}">
            <input type="text" id="end_time" name="edit_end_time" value="${test.end_time}">
        </div>
    </form>
</div>