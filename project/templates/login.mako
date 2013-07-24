<%inherit file="default.mako" />
<%block name="title">Prihlasenie</%block>
<%block name="page_content">
<h2>Prihlásenie</h2>
<div id="log in">
	<form action="${request.route_path('login')}" method="POST">
		% if errors != []:
		    <font color="red">${errors[0]}</font><br>
		% endif
		<div class="input-group">
			<label for="email">E-mail</label>
			<input type="email" name="email" required/>
		</div>
		<div class="input-group">
			<label>Heslo</label>
			<input type="password" name="password" required/>
		</div>
		<button type="submit" class="submit-form">Prihlasit sa</button>
	</form>
</div>
</%block>
