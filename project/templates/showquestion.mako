<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
<div class="page-header">
	<a href="${request.route_path('showtest',test_id=test.id)}" method="GET"><h1>${test.name}</h1></a>
</div>

<div class="container">
<form action="${request.route_path('showtest', test_id=test.id)}" method="POST">
	<button type="submit" class="btn btn-danger pull-right">Zmazať otazku</button>
</form>
	<div class="control-group">
		<div class="controls">
			<h3>${question.number}</h3>
		</div>
        <h4>${question.text}</h4>
		<div class="list-group">
			% if len(answers) is 0:
				<span> Otazka neobsahuje ziadne moznosti</span>
			% else:
				% for answer in answers:
					${answer.text}
				% endfor
			% endif
		</div>
	</div>
</div>
</%block>
