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
			</div>

			<div class="controls">
				<textarea name="text" id="text" placeholder="Znenie otázky"></textarea>
				<textarea name="text" id="text" placeholder="body"></textarea>
				<label class="radio">
					<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
					<input type="text" name="a1" id="a1" placeholder="Odpoveď 1" required/>
				</label>
				<label class="radio">
					<input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
					<input type="text" name="a2" id="a2" placeholder="Odpoveď 2" required/>
				</label>
				<a class="btn">Pridať odpoveď</a>
				<button type="submit" class="btn btn-primary">Vytvoriť test</button>
				<button type="submit" class="btn">Pridať otázku k DB</button>

			</div>
		</div>
	</form>
</div>
</%block>
