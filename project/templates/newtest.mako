<%inherit file="default.mako" />
<%block name="title">Nový test</%block>
<%block name="page_content">
<div class="page-header">
	<h1>Nový test</h1>
</div>

<div class="container">
	<p>Pokyny</p>
	<form action="${request.route_path('newtest')}" method="POST">
		<div class="control-group">
			<div class="controls">
				<input type="text" name="name" id="name" placeholder="Názov" required/>
			</div>
		</div>
		<div class="control-group">
			<div class="controls">
				<textarea name="description" id="description" placeholder="Opis" ></textarea>
				<button type="submit" class="btn">Vytvoriť</button>
				<a class="btn pull-right">Pridať otázku</a>
			</div>
		</div>
	</form>
</div>
</%block>
