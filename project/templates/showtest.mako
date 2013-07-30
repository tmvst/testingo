<%inherit file="default.mako" />
<%block name="title">${request.test.name}</%block>
<%block name="page_content">
<div class="page-header">
	<h1>${test.name}</h1>
</div>

<div class="container">
<form action="${request.route_path('showtest', test_id=test.id)}" method="POST">
	<button type="submit" class="btn btn-danger pull-right">Zmazať test</button>
</form>
	<div class="control-group">
		<div class="controls">
			<p>${test.description}</p>
		</div>
		
		<h3>
			Otázky
		</h3>

		<a href="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary">Pridať otázku</a>

		<div class="list-group">
			% if len(questions) is 0:
				<span> Test neobsahuje žiadne otázky </span>
			% else:
				% for question in questions:
					${question.text}
				% endfor
			% endif
		</div>
	</div>
</div>
</%block>
