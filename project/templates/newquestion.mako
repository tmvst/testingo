<%inherit file="default.mako" />
<%block name="title">Nová otázka</%block>
<%block name="page_content">
<div class="page-header">
	<h1>Nová otázka do testu ${test.name}</h1>
</div>

<div class="container">
	<form action="${request.route_path('newquestion', test_id=test.id)}" method="POST">
		<div class="form-group">
			<label for="text">Znenie otázky</label>
			<textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
		</div>
		<div class="form-group">
			<label for="odpoved">Správna odpoveď</label>
			<input type="text" id="odpoved" name="odpoved" class="form-control" placeholder="Správna odpoveď" required>
		</div>
		<div class="form-group">
			<label for="points">Body</label>
			<input type="number" id="points" name="points" class="form-control" placeholder="Body" required>
		</div>
		<button type="submit" formaction="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary">Uložiť a pridať ďalšiu</button>
		<button type="submit" formaction="${request.route_path('showtest', test_id=test.id)}" class="btn btn-default">Uložiť a skončiť</button>
	</form>
</div>
</%block>
