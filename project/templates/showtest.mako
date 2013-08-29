<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <script type="text/javascript">
        post_url="${request.route_path('showtest', test_id=test.id)}"
    </script>
    <script src="${request.static_path('project:static/js/edit_test.js')}"></script>
    
    <!-- Datapicker for Date_input -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="${request.static_path('project:static/js/date_time_picker.js')}"></script>
    <script src="${request.static_path('project:static/js/Date_input.js')}"></script>

    <%! import markupsafe %>
    <script src="${request.static_path('project:static/js/showtest.js')}"></script>
    <ol class="breadcrumb">
        <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> </a></li>
        <li><a href="${request.route_path('dashboard')}">Vaše testy</a></li>
        <li class="active">Test ${test.name}</li>
    </ol>


    <div class="page-header">
    <div>
        <h1>${test.name}</h1>
        <form class="pull-right" action="${request.route_path('showtest', test_id=test.id)}" method="POST">
            <button type="submit" class="btn btn-danger">
                <span class="glyphicon glyphicon-trash"></span> Zmazať test
            </button>
            <input type="hidden" name="_delete" value="DELETE">
        </form>
        <a data-toggle="modal" href="#myTest" class="btn btn-primary pull-right btns">Zmeniť test</a>
    </div>
                <!-- Modal -->
                <div class="modal fade" id="myTest" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">Úprava testu ${test.name}</h4>
                            </div>
                            <div class="modal-body">
                                <%include file="edit_test.mako"/>
                            </div>
                            <div class="modal-footer">
                                
                                <button type="button" class="btn btn-primary pull-right" id="save_edit_test" name="${test.id}">Uložiť</button>
                    
                                <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Zavrieť</button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
    </div>


    <% questions = test.questions %>

    <div>
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
							<button class="btn btn-default" type="button" id="focusBtn"><span class="glyphicon glyphicon-paperclip"></span></button>
						</span>
                    </div>
                % endif
        </div>

            <button type="button" class="btn btn-primary" data-toggle="collapse" data-target="#test_stats">Zobraz štatistiky</button>


            <div id="test_stats" class="collapse out">

                    %if len(solved_tests) is 0:
                        <div class="panel-body">
                            <span> Test ešte nikto neriešil</span>
                        </div>
                    %else:
                    <%include file="test_stats.mako"/>
                    %endif
            </div>




            <div name="questions_tag"><h2>Otázky
                <small>
                    s celkovým počtom bodov ${h.pretty_points(test.sum_points)}
                </small></h2></div>
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
                            <div class="panel panel-default">
                            <div class="panel-heading">

                            <a href="${request.route_path('showquestion',test_id=test.id, question_id=question.id)}" method="GET">

                            <h3 class="panel-title">Otázka č.${question.number}
                            
                            % if question.points:
                                    <span class="badge pull-right">
										${h.pretty_points(question.points)}b
									</span>
                            % endif
                            </h3>

                            </a>
                            </div>
                            <div class="panel-body">
                                <strong>${question.text.replace('\n', markupsafe.Markup('<br> '))|n}</strong>
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
                                            <p class="text-success">
                                                <input class="checkInputC" type="checkbox" alue="" checked disabled>
                                            ${answer.text}
                                            </p>
                                    % elif (question.qtype == "R"):
                                            <span><p class="text-success">
                                                <input class="radioR" type="radio" value="" checked disabled >
                                            ${answer.text}
                                            </p></span>
                                    % endif

                                % else:
                                    % if (question.qtype == "C"):
                                            <span><p class="text-danger">
                                                <input class="checkInputC" type="checkbox" value=""disabled>
                                            ${answer.text}
                                            </p></span>
                                    % elif (question.qtype == "R"):
                                            <span><p>
                                                <input class="radioR" type="radio" value="" disabled>
                                            ${answer.text}
                                            </p></span>
                                    % endif

                                % endif
                            % endfor

                            %if question.mandatory:
                                   <em> * otázku je povinné vyplniť</em>
                                %endif
                            </div>                            
                            </div>
                        % endfor
                        % endif
                </div>

                <div class="col-lg-3">

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Riešitelia</h3>
                        </div>
                        % if len(solved_tests) is 0:
                                <div class="panel-body">
                                    <span> Test ešte nikto neriešil :(</span>
                                </div>
                        % else:
                            <div class="panel-body">
                                % for solved_test in solved_tests:
                                    <a href="${request.route_path('solved_test',incomplete_test_id=solved_test.id)}" method="GET">
                                    ${solved_test.user.email}</a> <br>
                                ${h.pretty_date(solved_test.date_crt)}
                                    <hr>
                                %endfor
                            </div>
                        %endif
                    </div>
                </div>
            </div>
        </div>
    </div>
</%block>
