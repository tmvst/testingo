<%inherit file="default.mako" />
<%block name="title">${user.name}</%block>
<%block name="page_content">
<script type="text/javascript">
        post_url="${request.route_path('profile')}"
</script>
    <h1>${user.name}</h1>
    <br>
    <p>Zatiaľ ste vytvorili ${len(user.tests)} testov, odpovedali na ${len(user.incomplete_tests)} testov.</p>

    <!-- Button trigger modal -->
<script src="${request.static_path('project:static/js/change_password_modal.js')}"></script>
 % if errors != []:
				<div class="alert alert-success">
					${errors[0]}
				</div>
%endif
<a data-toggle="modal" href="#change_password_modal" class="btn btn-primary btn-sm">Zmena hesla</a>


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
                                        <td><label for="new_password">Nové Heslo</label></td>
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
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</%block>