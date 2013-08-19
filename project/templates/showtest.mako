
<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <div class="page-header">
        <h1>${test.name}</h1>
        <form class="pull-right" action="${request.route_path('showtest', test_id=test.id)}" method="POST">
            <button type="submit" class="btn btn-danger">
                <span class="glyphicon glyphicon-trash"></span> Zmazať test
            </button>
            <input type="hidden" name="_delete" value="DELETE">
        </form>
    </div>


    <% questions = test.questions %>

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

            <h2>Otázky
                <small>
                    s celkovým počtom bodov ${test.sum_points}
                </small></h2>
            % if test.share_token is None:
                    <p>
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-plus"></span> Pridať otázku <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="${request.route_path('newquestion_s', test_id=test.id)}">Fráza</a></li>
                            <li><a href="${request.route_path('newquestion_c', test_id=test.id)}">Checkbox</a></li>
                            <li><a href="${request.route_path('newquestion_r', test_id=test.id)}">Rádio</a></li>
                            <li><a href="${request.route_path('newquestion_o', test_id=test.id)}">Otvorená</a></li>
                        </ul>
                    </div>
                    </p>
            %endif

            <div class="row">
                <div class="col-lg-9">

                        % if len(questions) is 0:
                            <span> Test neobsahuje žiadne otázky </span>
                        % else:

                        % for question in questions:
                            <div class="panel">
                            <div class="panel-heading">

                            <a href="${request.route_path('showquestion',test_id=test.id, question_id=question.id)}" method="GET">

                            <h3 class="panel-title">Otázka č.${question.number}
                            % if question.points:
                                    <span class="badge pull-right">
										${int(question.points)}b
									</span>
                            % endif
                            </h3>

                            </a>
                            </div>
                            <div class="panel-body">
                                <strong>${question.text}</strong>
                                <br>
                            % for answer in question.answers:
                                % if answer.correct == 1:
                                    %if question.qtype=="O":
                                            <p><i>
                                            ${answer.text}</i>
                                            </p>
                                    % elif (question.qtype == "S"):

                                            <p class="text-success">
                                            ${answer.text}
                                            </p>

                                    % elif (question.qtype == "C"):
                                            <input class="checkInputC pull-left" type="checkbox" alue="" checked disabled>
                                            <p class="text-success">
                                            ${answer.text}
                                            </p>
                                    % elif (question.qtype == "R"):
                                            <input class="radioR pull-left" type="radio" value="" checked disabled >
                                            <p class="text-success">
                                            ${answer.text}
                                            </p>
                                    % endif

                                % else:
                                    % if (question.qtype == "C"):
                                            <input class="checkInputC pull-left" type="checkbox" value=""disabled>
                                            <p class="text-danger">
                                            ${answer.text}
                                            </p>
                                    % elif (question.qtype == "R"):
                                            <input class="radioR pull-left" type="radio" value="" disabled>
                                            <p>
                                            ${answer.text}
                                            </p>
                                    % endif

                                % endif
                            % endfor
                            </div>
                            </div>
                        % endfor
                        % endif
                </div>

                <div class="col-lg-3">

                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">Riešitelia</h3>
                        </div>
                        % if len(solved_tests) is 0:
                                <div class="panel-body">
                                    <span> Test ešte nikto neriešil :(</span>
                                </div>
                        % else:
                            % for solved_test in solved_tests:
                                    <div class="panel-body">
                                        <a href="${request.route_path('solved_test',incomplete_test_id=solved_test.id)}" method="GET">
                                        ${solved_test.user.email}</a> <br>
                                    	${h.pretty_date(solved_test.date_crt)}
                                        <hr>
                                    </div>
                            %endfor
                        %endif
                    </div>
                </div>
            </div>
        </div>
    </div>
</%block>
