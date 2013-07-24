<%inherit file="default.mako" />
<%block name="title">obnova hesla</%block>
<%block name="page_content">
<form method="POST">
    % if error == ['nonequal-passwords']:
        <font color="red">heslá nie sú rovnaké.</font><br>
    % endif
    <div class="input-group">
    	<label for="password">Heslo</label>
    	<input type="password" name="password" id="password" required/>
  	</div>
  	<div class="input-group">
    	<label for="password_repeat">Heslo znovu</label>
    	<input type="password" name="password_repeat" id="password_repeat" required/>
  	</div>
    <button type="submit" class="submit-form">Zmeniť heslo</button>
</form>
</%block>
