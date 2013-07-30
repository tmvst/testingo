<%inherit file="default.mako" />
<%block name="title">${request.test.name}</%block>
<%block name="page_content">
<div class="page-header">
	<h1>${test.name}</h1>
</div>

<div class="container">
		<div class="control-group">
			<div class="controls">
				<textarea name="description" id="description" >${test.description}</textarea>
			</div>
            <h3>
				Otazky
			</h3>
			<div class="list-group">
				    % for question in questions:
					    ${question.text}
				    % endfor
			</div>
		</div>
</div>
</%block>
