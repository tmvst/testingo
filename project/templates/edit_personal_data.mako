<div id="edit_person_data">
    <form action="#" id="form_editPD">
        <div class="form-group">
            <label for="user_name">Meno a priezvisko</label>
            <input type="text" id="user_name" name="user_name" class="form-control" value="${user.name}" required>
        </div>
        <div class="form-group">
            <label for="email">E-mail</label>
            <input type="text" id="email" name="email" class="form-control" value="${user.email}" required>
        </div>
        <hr>
        <div class="form-group">
            <label for="work_position">Zamestnanie</label>
            <input type="text" id="work_position" name="work_position" class="form-control">
        </div>
        <div class="form-group">
            <label for="school">Škola</label>
            <input type="text" id="school" name="school" class="form-control">
        </div>
        <div class="form-group">
            <label for="specialization">Zameranie</label>
            <input type="text" id="specialization" name="specialization" class="form-control">
        </div>
    </form>
</div>