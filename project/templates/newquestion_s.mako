<%inherit file="default.mako" />
<%block name="title">Nová otázka - fráza</%block>
<%block name="page_content">

<script type="text/javascript">
        post_url="${request.route_path('newquestion_c', test_id=test.id)}"
        $(document).ready(function()
                {

                    var windowHeight = $(window).height();
                    $("#newq").css("padding-bottom", (windowHeight/2));
                    $("html,body").scrollTop($(document).height()-1);
                }
        )
    </script>
    <%include file="showquestions.mako"/>

<div class="page-header">
	<h1>Nová otázka (fráza) do testu <a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a></h1>
</div>

<div class="container" id="newq">
	<form action="#" id="input_form_s">
		<div class="form-group">
			<label for="text">Znenie otázky</label>
			<textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
		</div>

		<div class="form-group">
			<label for="points1">Body</label>
			<input type="number" id="points1" name="points" class="form-control" placeholder="Body">
		</div>

		<div class="form-group">
			<label for="odpoved">Správna odpoveď</label>
			<input type="text" id="odpoved" name="odpoved" class="form-control" placeholder="Správna odpoveď">
		</div>

		<div class="form-group pull-left">
			<button type="submit" formaction="${request.route_path('newquestion_s', test_id=test.id)}" class="btn btn-primary">Uložiť a pridať ďalšiu</button>
			<button type="submit" formaction="#" class="btn btn-default">Uložiť a skončiť</button>
		</div>

		<div class="pull-right"><a href="${request.route_path('showtest', test_id=test.id)}" class="btn btn-danger">Zrušiť</a></div>
	</form>
</div>

</%block>