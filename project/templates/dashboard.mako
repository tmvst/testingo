<%inherit file="default.mako" />
<%block name="title">Dashboard</%block>
<%block name="page_content">

<div class="page-header">
	<h1>Dashboard</h1>
	<a href="${request.route_path('getlist')}" class="btn btn-primary pull-right">Zoznamy respondentov</a>
</div>

<div class="container">
	<p class="lead">
		Use this document as a way to quick start any new project.
		All you get is this message and a barebones HTML document.
	</p>
	<div class="row">
		<div class="col-lg-5">
			<div class="btn-group">
				<a href="#" class="btn btn-primary">Admin</a>
				<a href="#" class="btn btn-default">Respondent<br></a>
			</div>

			<h3>
				Vaše testy
			</h3>
			<div class="list-group">
				% for test in tests:
				<a href="${request.route_path('showtest', test_id=test.id)}" class="list-group-item">
					${test.name}
					<span class="glyphicon glyphicon-lock pull-right"></span>
				</a>
				% endfor
			</div>
		</div>
		<div class="col-lg-6 col-offset-1">
			<div class="well text-left">
				<h3>
					Aktivita
				</h3>
				<p class="text-left">
					<a href="#">Jano</a> vyplnil <a href="#">Test osobnosti</a>
				</p>
				<div>
					<i class="text-left">pred 2 minútami (12:45)<br><br></i>
				</div>
				<p>
				</p>
				<p class="text-left">
					StihacieLeteckeKridlo vyplnil
					<a href="#">Polročná písomná previerka z <br>biológie</a>
				</p>
				<div>
					<i class="text-left">pred 1 hodinou (17:45)<br><br></i>
				</div>
			</div>
		</div>
	</div>
</div>

</%block>
