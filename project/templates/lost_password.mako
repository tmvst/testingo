<%inherit file="default.mako" />
<%block name="title">Renovacia hesla</%block>
<%block name="page_content">
    <h2>Zmena hesla</h2>
    <div id="lost_pasword">
        <table>
            <form method="POST">
                % if error == ['no-email']:
                        <font color="red"> Zly email </font><br>
                % endif
                <tr>
                <div class="input-group">
                    <td><label for="email">E-mail</label></td>
                    <td><input type="email" id="email" name="email" class="form-control" style="width: 220px;" required/></td>
                </div>
                    </tr>
                <tr><td><button type="submit" class="btn btn-primary">Zmeniť heslo</button></td></tr>
            </form>
        </table>
    </div>
</%block>
