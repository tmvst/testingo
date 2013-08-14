<%inherit file="default.mako" />
<%block name="title">Nová otázka - checkbox</%block>
<%block name="page_content">

<script type="text/javascript">
	post_url="${request.route_path('newquestion_c', test_id=test.id)}"
</script>

<div class="page-header">
	<h1>Nová otázka (checkbox) do testu <a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a></h1>
</div>

<%include file="showquestions.mako"/>

<div class="container">
	<form action="#" id="input_form_checkbox">
		<div class="form-group">
			<label for="text">Znenie otázky</label>
			<textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
		</div>

		<div class="form-group">
			<label for="points2">Body</label>
			<input type="number" id="points" name="points" class="form-control" placeholder="Body">
		</div>

		<div id="answer"></div>

		<div class="form-group pull-left">
			<button type="submit" formaction="${request.route_path('newquestion_c', test_id=test.id)}" class="btn btn-primary">Uložiť a pridať ďalšiu</button>
			<button type="submit" formaction="#" class="btn btn-default">Uložiť a skončiť</button>
		</div>

		<div class="pull-right"><a href="${request.route_path('showtest', test_id=test.id)}" class="btn btn-danger">Zrušiť</a></div>
	</form>
</div>

</%block>