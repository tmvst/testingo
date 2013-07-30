
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

            <h3>
                Otázky
            </h3>

            <a href="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary">Pridať otázku</a>

            % if len(questions) is 0:
                    <span> Test neobsahuje žiadne otázky </span>
            % else:
                % for question in questions:
                        <div class="panel">
                            <div class="panel-heading"><a href="${request.route_path('showquestion',test_id=test.id, question_id=question.id)}" method="GET">
                                <h4>Otazka c.${question.number}</h4></a></div>
                            <h5>${question.text}</h5></div>
                % endfor
            % endif
        </div>
    </div>
</%block>
