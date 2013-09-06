<%inherit file="default.mako" />
<%block name="title">${user.name}</%block>
<%block name="page_content">

<script type="text/javascript">
        post_url="${request.route_path('profile')}"
</script>

<!-- Button trigger modal -->
<script src="${request.static_path('project:static/js/change_password_modal.js')}"></script>
<script src="${request.static_path('project:static/js/edit_personal_data.js')}"></script>
% if errors != []:
                <div class="alert alert-success">
                    ${errors[0]}
                </div>
%endif

    <h1>${user.name}<a data-toggle="modal" href="#change_personal_data" class="btn btn-primary pull-right">Upraviť</a></h1>
    <hr>
    <h3>Osobné údaje</h3>
    <dl>
        <dt>Meno a priezvisko</dt>
        <dd>${user.name}</dd>
        <dt>E-mail</dt>
        <dd>${user.email}</dd>
        <dt>Heslo</dt>
        <dd><a data-toggle="modal" href="#change_password_modal" class="btn btn-primary btn-sm">Zmena hesla</a></dd>
    </dl>
    <hr>

    <h3>Moje štatistiky</h3>
    <p>Zatiaľ som vytvoril ${len(user.tests)} testov a odpovedal na ${len(user.incomplete_tests)} testov.</p>


    <!-- Modal -->
    <div class="modal fade" id="change_password_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Zmena hesla</h4>
                </div>
                <div class="modal-body">
                    <div class="control-group">

                        <form class="form"  name="form-change_password" id="form-change_password">
                            <div id="error_alert"></div>
                            <table>
                                <div class="input-group">
                                    <tr>
                                        <div class="input-group">
                                            <td><label for="current_password">Aktuálne heslo</label></td>
                                            <td><input type="password" name="current_password" id="current_password" class="form-control" /></td>
                                        </div>
                                    </tr>
                                    <tr>
                                        <div class="input-group">
                                            <td><label for="new_password">Nové heslo</label></td>
                                            <td><input type="password" name="new_password" id="new_password" class="form-control" /></td>
                                        </div>
                                    </tr>
                                    <tr>
                                        <div class="input-group">
                                            <td><label for ="password_repeat">Nové heslo</label></td>
                                            <td><input type="password" name="password_repeat" id="password_repeat" class="form-control" /></td>
                                        </div>
                                    </tr>
                                </div>
                            </table>

                            <br>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Zrušiť</button>
                            <button type="button" id="submit" name="submit"class="btn btn-primary">Zmeniť heslo</button>
                        </form>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- Modal -->
    <div class="modal fade" id="change_personal_data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Úprava osobných údajov</h4>
                </div>
                 <form action="#" id="form_editPD">
                    <div class="modal-body">
                        <div id="error_alert"></div>
                        <%include file="edit_personal_data.mako"/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Zrušiť</button>
                        <button type="button" id="submit_data" name="submit_data"class="btn btn-primary">Uložiť</button>
                    </div>
                    </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</%block>