<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <div class="page-header">
        <a href="${request.route_path('showtest',test_id=test.id)}"><h1>${test.name}</h1></a>
    </div>

    <div class="container">
        <form action="${request.route_path('showquestion', test_id=test.id,question_id=question.id)}" method="POST">
            <button type="submit" class="btn btn-danger pull-right">Zmazať otázku</button>
        </form>
        <div class="control-group">
            <div class="controls">
                <h3>Otázka č.${question.number}</h3>
            </div>
            <h4>${question.text}</h4>
            <div class="list-group">
                    % if len(answers) is 0:
                        <span> Otázka neobsahuje žiadne možnosti</span>
                    % else:
                    % for answer in answers:
                    <p class="text-success">
                        ${answer.text} <br>
                        </p>
                    % endfor
                    % endif
            </div>
        </div>
    </div>
</%block>
