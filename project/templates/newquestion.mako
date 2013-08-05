<%inherit file="default.mako" />
<%block name="title">Nová otázka</%block>
<%block name="page_content">
    <div class="page-header">
        <h1>Nová otázka do testu <a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a></h1>
    </div>

    <div class="container">
        <ul id="dtab" class="nav nav-tabs">
                <li class="active"><a href="#openquestion" data-toggle="tab">Otvorená otázka</a></li>
                <li><a href="#checkquestion" data-toggle="tab">Otázka s možnosťami</a></li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane fade active in" id="openquestion">
                <form action="${request.route_path('newquestion', test_id=test.id)}" method="POST">
                    <div class="form-group">
                        <label for="text">Znenie otázky</label>
                        <textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="odpoved">Správna odpoveď</label>
                        <input type="text" id="odpoved" name="odpoved" class="form-control" placeholder="Správna odpoveď">
                    </div>

                    <div class="form-group">
                        <label for="points">Body</label>
                        <input type="number" id="points" name="points" class="form-control" placeholder="Body">
                    </div>

                    <div class="form-group pull-left">
                    <button type="submit" formaction="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary">Uložiť a pridať ďalšiu</button>
                    <button type="submit" formaction="${request.route_path('showtest', test_id=test.id)}" class="btn btn-default">Uložiť a skončiť</button>
                    </div>

                    <div class="pull-right"><a href="${request.route_path('dashboard')}" class="btn btn-danger">Zrušiť</a></div>
                </form>
            </div>

            <div class="tab-pane" id="checkquestion">
                <form action="${request.route_path('newquestion', test_id=test.id)}" method="POST">
                    <div class="form-group">
                        <label for="text">Znenie otázky</label>
                        <textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
                    </div>

                    <label>
                        <input type="Checkbox" value="">
                        <input type="newCheckbox" id = "checkboxName">
                    </label>                   

                    <input type="button" value="Pridať odpoveď" onClick="addTask()" id = "taskAdder">
                    <div id="toBeDone"></div>

                    <div class="form-group">
                        <label for="points">Body</label>
                        <input type="number" id="points" name="points" class="form-control" placeholder="Body">
                    </div>

                    <div class="form-group pull-left">
                    <button type="submit" formaction="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary">Uložiť a pridať ďalšiu</button>
                    <button type="submit" formaction="${request.route_path('showtest', test_id=test.id)}" class="btn btn-default">Uložiť a skončiť</button>
                    </div>

                    <div class="pull-right"><a href="${request.route_path('dashboard')}" class="btn btn-danger">Zrušiť</a></div>
                </form>
            </div>
        </div>
    </div>

                    <div id="answer"></div>
               

                    <div class="form-group">
                        <label for="points">Body</label>
                        <input type="number" id="points" name="points" class="form-control" placeholder="Body">
                    </div>

                    <button type="submit" formaction="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary">Uložiť a pridať ďalšiu</button>
                    <button type="submit" formaction="${request.route_path('showtest', test_id=test.id)}" class="btn btn-default">Uložiť a skončiť</button>

                </form>
                   <a href="${request.route_path('dashboard')}"> <button type="submit" class="btn btn-danger">Zrušiť</button></a>

            </div>
        </div>
    </div>

</%block>
