<%inherit file="default.mako" />
<%block name="title">Prihlasenie</%block>
<%block name="page_content">
    <h2>Prihlásenie</h2>
    <div id="log in">
        <form action="${request.route_path('login')}" method="POST">
            % if errors != []:
                    <font color="red">${errors[0]}</font><br>
            % endif
            <table>
                <div class="input-group">
                    <tr>
                        <div class="input-group">
                            <td><label for="email">E-mail</label></td>
                            <td><input type="email" name="email" id="email" class="form-control" style="width: 220px;" required/></td>
                        </div>
                    </tr>
                    <tr>
                        <div class="input-group">
                            <td><label>Heslo</label></td>
                            <td><input type="password" name="password" id="password" class="form-control" style="width: 220px;" required/></td>
                        </div>
                    </tr>
                </div>
                <tr><td><button type="submit-form" class="btn btn-primary">Prihlásiť sa</button></td></tr>

            </table>
        </form>
    </div>
</%block>
