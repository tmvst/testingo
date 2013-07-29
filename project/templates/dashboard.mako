<%inherit file="default.mako" />
<%block name="title">Dashboard</%block>
<%block name="page_content">
<div class="page-header">
	<h1>Dashboard</h1>
</div>

<div class="container">
	<p>
		Use this document as a way to quick start any new project.
		<br>
		All you get is this message and a barebones HTML document.
	</p>
	<div class="btn-toolbar">
		<div class="btn-group">
			<a href="#" class="btn btn-primary">Admin</a>
			<a href="#" class="btn">Respondent<br></a>
		</div>
	</div>
	<h3 class="pull-left">
		Vaše testy
	</h3>
	<div class="well pull-right text-left" style="width=300px;">
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
	<table class="table table-striped pull-left" style="width: 500px;">
		<tbody class="pull-left">
			% for test in tests:
			<tr>
				<td>
					<a href="#">
						${test.name}
					</a>
				</td>
				<td>
					<a class="btn btn-mini btn-danger"><i class="icon-trash"></i> Zmazať</a>
				</td>
				<td>
					<i class="icon-exclamation-sign"></i>
				</td>
				<td>
					<i class="icon-lock"></i>
				</td>
			</tr>
			% endfor
		</tbody>
	</table>
</div>

</%block>
