<%inherit file="default.mako" />
<%block name="title">Nový test</%block>
<%block name="page_content">
<div class="page-header">
	<h1>Nový test</h1>
</div>

<div class="container">
	<form action="${request.route_path('newtest')}" method="POST">
		<div class="form-group">
			<label for="name">Názov</label>
			<input type="text" id="name" name="name" class="form-control" placeholder="Názov testu" required>
		</div>
		<div class="form-group">
			<label for="description">Opis testu</label>
			<textarea class="form-control" name="description" id="description" rows="3" placeholder="Pár slov na úvod" required></textarea>
		</div>
		<div class="form-group">
			<button type="submit" class="btn btn-primary">Vytvoriť test</button>
		</div>
	</form>
</div>
</%block>
