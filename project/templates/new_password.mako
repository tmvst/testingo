<%inherit file="default.mako" />
<%block name="title">obnova hesla</%block>
<%block name="page_content">
<form method="POST">
    % if error == ['nonequal-passwords']:
        <font color="red">heslá nie sú rovnaké.</font><br>
    % endif
    <table>
     <tr>
    <div class="input-group">
    	<td><label for="password">Heslo</label></td>
    	<td><input type="password" name="password" id="password" class="form-control" style="width: 220px;" required/></td>
  	</div>
     </tr>
        <tr>
  	<div class="input-group">
    	<td><label for="password_repeat">Heslo znovu</label></td>
    	<td><input type="password" name="password_repeat" id="password_repeat" class="form-control" style="width: 220px;" required/></td>
  	</div>
        </tr>
    </table>
     <button type="submit" class="btn btn-primary">Zmeniť heslo</button>
</form>
</%block>
