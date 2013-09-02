<%inherit file="default.mako" />
<%block name="title">Dashboard</%block>
<%block name="page_content">
    <script src="${request.static_path('project:static/js/dashboard_view_tests.js')}"></script>
	<script src="${request.static_path('project:static/js/dashboard_help.js')}"></script>
    <ol class="breadcrumb">

        <li class="active"><span class="glyphicon glyphicon-home"></span> </li>
    </ol>

    <div class="page-header">
        <h1>Ovládací panel</h1>
	    <a href="#" class="pull-right" id="help-panel-toggle"><img src="https://cdn1.iconfinder.com/data/icons/google_jfk_icons_by_carlosjj/32/help.png"></a>
    </div>

    <div>
        <p class="lead">
        </p>

        <div class="panel panel-default" id="help-panel">
            <div class="panel-heading">
                <h3 class="panel-title">Help title
                    <button type="button" id="help-panel-close" class="close text-right">&times;</button>
                </h3>
            </div>
            <div class="panel-body">
                Help content
            </div>
        </div>

	    <p><a href="${request.route_path('newtest')}" class="btn btn-primary">Vytvoriť nový test</a></p>
        <div class="row">
            <div class="col-lg-6" id="left-panel">

                <ul id="dtab" class="nav nav-tabs">
                    <li class="active"><a href="#created_tests" class="showTest" data-toggle="tab" title="Testy, ktoré ste vytvorili" id="card1">Vaše testy</a></li>
                    <li><a href="#solved_tests" class="showTest" data-toggle="tab" title="Testy, ktoré ste vyplnili" id="card2">Vyplnené testy</a></li>
                    <li><a href="#view_all_tests" data-toggle="tab" id="preh_test" name="Activita" title="Podrobný prehľad testov, ktoré ste vytvorili">Prehľad testov</a></li>
                </ul>
                <p></p>
                <div class="tab-content">

                    <div class="tab-pane fade active in" id="created_tests">
                        <div class="list-group">
                             %if len(tests) is 0:
                                <p>Zatiaľ ste nevytvorili žiaden test</p>
                            %endif
                                % for test in tests:
                                <a href="${request.route_path('showtest', test_id=test.id)}" class="list-group-item">
                                ${test.name}
                                %if test.share_token:
                                        <span class="glyphicon glyphicon-lock pull-right"></span>
                                %else:
                                        <span class="glyphicon glyphicon-edit pull-right"></span>
                                %endif

                                </a>
                                % endfor
                        </div>
                    </div>

                    <div class="tab-pane" id="solved_tests">
                        <div class="list-group">
                            %if len(user.incomplete_tests) is 0:
                                <p>Zatiaľ ste nevyplnili žiaden test</p>
                            %endif
                            % for test in user.incomplete_tests:
                            % if test.test.user.id == userid:
                                <a href="${request.route_path('solved_test', incomplete_test_id=test.id)}" class="list-group-item">
                            %else:
                                <a href="${request.route_path('filled_test', incomplete_test_id=test.id)}" class="list-group-item">
                            %endif
                                    ${test.test.name}
                                    <span class="glyphicon glyphicon-check pull-right"></span>
                                </a>

                                % endfor
                        </div>
                    </div>

                    <div class="tab-pane" id="view_all_tests">
                        <div class="list-group">
                        <div class="table-responsive">
                            %if len(tests) > 0:

                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Test</th>
                                        <th>Respondent</th>
                                        <th>Dátum vzniku</th>
                                        <th>Dátum zmeny</th>
                                        <th>Počet bodov</th>
                                        <th>Pozor</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <% cnt=0 %>
                                %for test in tests:
                                    %for in_test in test.incomplete_tests:
                                        <% cnt=cnt+1 %>
                                        <tr>
                                            <td>${cnt}</td>
                                            <td>
                                                <a href="${request.route_path('showtest',test_id=test.id)}">
                                                    ${in_test.test.name}
                                                </a>
                                            </td>
                                            <td>${in_test.user.email}</td>
                                            <td>${in_test.date_crt.strftime('%H:%M dňa %d.%m.%Y')}</td>
                                            <td>${in_test.date_mdf.strftime('%H:%M dňa %d.%m.%Y')}</td>
                                            <td>
                                            <%  
                                                sum_points=0
                                                for respondent_test in in_test.complete_questions:
                                                    sum_points =sum_points +  sum(float(ans.points)for  ans in respondent_test.complete_q_complete_answers)
                                            %>
                                            ${h.pretty_points(sum_points)} b
                                            </td>
                                            <td>
                                                <a href="${request.route_path('solved_test', incomplete_test_id=in_test.id)}">
                                                    <span class="glyphicon glyphicon-warning-sign"></span>
                                                </a>
                                            </td>
                                        </tr>

                                    %endfor
                                %endfor
                                </tbody>

                            </table>
                                %else:
                                <p>Respondenti zatiaľ nevyplnili žiaden z vašich testov</p>
                                    %endif
                            </div>
                        </div>
                    </div>
                </div>
            </div>

           <div class="col-lg-6" id="Activita">
                <div class="well">
                    <h3 class="well-head">
                        Aktivita
                    </h3>

                    % for incomplete_test in tests_in_activity:
                        <%
                            acq_points=0
                            for c_q in incomplete_test.complete_questions:
                                acq_points =acq_points +  sum(float(a.points) for  a in c_q.complete_q_complete_answers)
                        %>
                                <p>
                                    Užívateľ <a href="#">${incomplete_test.user}</a> vyplnil test <a href="${request.route_path('solved_test', incomplete_test_id=incomplete_test.id)}" >
                                ${incomplete_test.test.name}</a> a ziskal

                                    ${h.pretty_points(acq_points)}
                                 bodov
                                    <span>
                                        <br><i class="text-left">${h.pretty_date(incomplete_test.date_crt)}</i>
                                    </span>


                                </p>

                    % endfor
                </div>
            </div>
        </div>
    </div>

</%block>
