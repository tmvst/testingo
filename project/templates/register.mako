<%inherit file="default.mako" />
<%block name="title">Zaregistrujte sa!</%block>
<%block name="page_content">
    <h2>Zaregistrujte sa!</h2>
    <%def name="error(field)">
        % if field in errors:
            <span class='error'>${error_messages[errors[field]]}</span>
        % endif
    </%def>
    <table>
        <form method="POST">

            <div class="input-group">
                <tr>
                    <div class="input-group">
                        <td><label for="email">E-mail</label></td>
                        <td><input type="email" name="email" id="email" class="form-control" style="width: 220px;" required/></td>
                    ${error('email')}
                    </div>
                </tr>
                <tr>
                    <div class="input-group">
                        <td><label>Heslo</label></td>
                        <td><input type="password" name="password" id="password" class="form-control" style="width: 220px;" required/></td>
                    ${error('password')}
                    </div>
                </tr>
                <tr>
                    <div class="input-group">
                        <td><label>Heslo znovu</label></td>
                        <td><input type="password" name="password_repeat" id="password_repeat" class="form-control" style="width: 220px;" required/></td>
                    </div>
                </tr>
            </div>
            <tr><td><button type="submit" class="btn btn-primary">Zaregistrovať sa</button></td></tr>
        </form>
    </table>
</%block>
