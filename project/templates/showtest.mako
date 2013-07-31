
<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
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

            <h2>Otázky</h2>
            <p>
            <a href="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary btn-small">Pridať otázku</a>
            </p>

            % if len(questions) is 0:
                    <span> Test neobsahuje žiadne otázky </span>
            % else:
                % for question in questions:
                        <div class="panel">
                            <div class="panel-heading">
                            	<a href="${request.route_path('showquestion',test_id=test.id, question_id=question.id)}" method="GET">
                                	<h3 class="panel-title">Otázka č.${question.number}</h3>
                                </a>
                        	</div>
                            <strong>${question.text}</strong>
                            <p class="text-success">
                            	% for ans in question.answers:
                            		${ans.text}
                            	% endfor
                            </p>
                        </div>
                % endfor
            % endif
        </div>
    </div>
</%block>
