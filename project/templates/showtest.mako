
<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
<div class="page-header">
    <h1>${test.name}</h1>
    <form class="pull-right" action="${request.route_path('showtest', test_id=test.id)}" method="POST">
        <button type="submit" class="btn btn-danger">
            <span class="glyphicon glyphicon-trash"></span> Zmazať test
        </button>
        <input type="hidden" name="_method" value="DELETE">
    </form>
</div>

    <div class="container">
        <div class="pull-right">
            % if test.share_token is None:
            <form action="${request.route_path('showtest', test_id=test.id)}" method="POST">
                <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-share-alt"></span> Zdieľať test</button>
                    <input type="hidden" name="_share" value="SHARE">
            </form>
            % else:
            <div class="input-group sharetoken">
            <input class="form-control" id="focusedInput" type="text" value="http://0.0.0.0:6543/solve/${test.share_token}" readonly="readonly">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" data-toggle="tooltip" data-placement="top" data-original-title="Tooltip on top"><span class="glyphicon glyphicon-paperclip"></span></button>
                </span>
            </div>
            % endif
        </div>
        <div class="control-group">
            <div class="controls">
                <p>${test.description}</p>
            </div>

            <h2>Otázky</h2>
            <p>
            <a href="${request.route_path('newquestion', test_id=test.id)}" class="btn btn-primary btn-small">
                <span class="glyphicon glyphicon-plus"></span> Pridať otázku</a>
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
                            		${ans.text} <br>
                            	% endfor
                            </p>
                        </div>
                % endfor
            % endif
        </div>

        <div class="pull-right" style="width: 300px;">
        <div class="panel">
            <div class="panel-heading">
                <h3 class="panel-title">Riešitelia</h3>
            </div>
            Panel content
        </div>
        </div>
    </div>
</%block>
