<%inherit file="default.mako" />
<%block name="title">Nový test</%block>
<%block name="page_content">

	<!-- Datapicker for Date_input -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  	<script src="${request.static_path('project:static/js/date_time_picker.js')}"></script>
  	<script src="${request.static_path('project:static/js/Date_input.js')}"></script>
  	<script type='text/javascript'>
  		time_input_value = function() {
    		return $('.timeinput').val("");
  		};

  		$(document).ready(function() {
    		return $('#input_value').click(function() {
      			return time_input_value();
    	});
  });
  	</script>

    <ol class="breadcrumb">
        <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> </a></li>
        <li><a href="${request.route_path('dashboard')}">Vaše testy</a></li>
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

		<label for="name">Čas platnosti:</label>
		<div class="form-group">
			<input class="timeinput" type="text" id="start_time" name="start_time" placeholder="Čas otvorenia">
			<input class="timeinput" type="text" id="end_time" name="end_time" placeholder="Čas uzatvorenia">
			<a class="btn btn-default" id="input_value">Neobmedzene</a>
		</div>

		<div class="form-group pull-left">
			<button type="submit" class="btn btn-primary">Vytvoriť test</button>
		</div>
		<div class="pull-right"><a href="${request.route_path('dashboard')}" class="btn btn-danger">Zrušiť</a></div>
	</form>
</div>
</%block>
