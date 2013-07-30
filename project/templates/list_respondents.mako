<%inherit file="default.mako" />
<%block name="title">zoznamy</%block>
<%block name="page_content">
<div class="page-header">
	<h1>Zoznamy respondentov</h1>
</div>

<div class="container">
<form action="${request.route_path('createlist')}" method="POST">
<button type="submit" class="btn btn-primary pull-right">Pridať zoznam</button>
</form>
	<div class="control-group">
		<div class="controls">
			Testovaci vstup
		</div>
	</div>
</div>
</%block>