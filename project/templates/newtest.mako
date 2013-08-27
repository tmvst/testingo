<%inherit file="default.mako" />
<%block name="title">Nový test</%block>
<%block name="page_content">

    <ol class="breadcrumb">
        <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> Dashboard</a></li>
        <li><a href="${request.route_path('dashboard')}">Vami vytvorené testy</a></li>
        <li class="active">Nový test</li>
    </ol>

<div class="page-header">
	<h1>Nový test</h1>
</div>

<div>
	<form action="${request.route_path('newtest')}" method="POST">
		<div class="form-group">
			<label for="name">Názov</label>
			<input type="text" id="name" name="name" class="form-control" placeholder="Názov testu" required>
		</div>
		<div class="form-group">
			<label for="description">Opis testu</label>
			<textarea class="form-control" name="description" id="description" rows="3" placeholder="Pár slov na úvod" required></textarea>
		</div>
		<div class="form-group pull-left">
			<button type="submit" class="btn btn-primary">Vytvoriť test</button>
		</div>
		<div class="pull-right"><a href="${request.route_path('dashboard')}" class="btn btn-danger">Zrušiť</a></div>
	</form>
</div>
</%block>
