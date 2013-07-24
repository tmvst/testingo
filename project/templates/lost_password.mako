<%inherit file="default.mako" />
<%block name="title">Renovacia hesla</%block>
<%block name="page_content">
<h2>Zmena hesla</h2>
<div id="lost_pasword">
	<form method="POST">
		% if error == ['no-email']:
			<font color="red"> Zly email </font><br>
		% endif
		<div class="input-group">
		<label for="email">E-mail</label>
		<input type="email" id="email" name="email" required/>
		</div>
		<button type="submit" class="submit-form">Zmeniť heslo</button>
	</form>
</div>
</%block>
