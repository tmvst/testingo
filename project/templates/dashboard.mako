<%inherit file="default.mako" />
<%block name="title">Dashboard</%block>
<%block name="page_content">
     <script src="${request.static_path('project:static/js/dashboard_view_tests.js')}"></script>

    <div class="page-header">
        <h1>Dashboard</h1>
        <a href="${request.route_path('newtest')}" class="btn btn-primary pull-right">Nový test</a>
    </div>

    <div>
        <p class="lead">
            Use this document as a way to quick start any new project.
            All you get is this message and a barebones HTML document.
        </p>
        <div class="row">
            <div class="col-lg">  <!--col-lg-6-->

                <ul id="dtab" class="nav nav-tabs">
                    <li class="active"><a href="#created_tests" data-toggle="tab">Vaše testy</a></li>
                    <li><a href="#solved_tests" data-toggle="tab">Vyplnené testy</a></li>
                    <li><a href="#view_all_tests" data-toggle="tab" id="preh_test" name="Activita">Prehľad testov</a></li>
                </ul>
                <p></p>
                <div class="tab-content">

                    <div class="tab-pane fade active in" id="created_tests">
                        <div class="list-group">
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
                            % for test in user.incomplete_tests:
                            % if user.id == userid:
                                <a href="${request.route_path('solved_test', incomplete_test_id=test.id)}" class="list-group-item">
                                %else:
                                    <a href="${request.route_path('filled_test', incomplete_test_id=test.id)}" class="list-group-item">
                            %endif:
                                    ${test.test.name}
                                        <span class="glyphicon glyphicon-check pull-right"></span>
                                    </a>
                                % endfor
                        </div>
                    </div>

                    <div class="tab-pane" id="view_all_tests">
                        <div class="list-group">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr class="success">
                                        <td>Test</td>
                                        <td>Respondent</td>
                                        <td>Dátum vzniku</td>
                                        <td>Dátum zmeny</td>
                                        <td>Počet bodov</td>
                                        <td>Pozor</td>
                                    </tr>
                                </thead>
                                <tbody>
                                %for test in tests:
                                    %for in_test in test.incomplete_tests:
                                        <tr>
                                            <td>${in_test.test.name}</td>
                                            <td>${in_test.user.email}</td>
                                            <td>${in_test.date_crt}</td>
                                            <td>${in_test.date_mdf}</td>
                                            <td>body</td>
                                            <td>${in_test.test.name}</td>
                                        </tr>

                                    %endfor
                                %endfor
                                </tbody>                            

                            </table>                          
                        </div>
                    </div>
                </div>
            </div>

           <!--<div class="col-lg-6" id="Activita">
                <div class="well text-left>
                    <h3>
                        Aktivita
                    </h3>

                    % for test in user.tests:
                        <%
                            counter=0
                        %>
                            <h4><a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a></h4>
                        %for incomplete_test in test.incomplete_tests:
                            <%
                                counter+=1
                            %>
                                <div><p>
                                    Užívtateľ s emailom  <a href="#">${incomplete_test.user}</a> vyplnil test názvom <a href="${request.route_path('solved_test', incomplete_test_id=incomplete_test.id)}" >
                                ${incomplete_test.test.name}</a>
                                    <div>
                                        <i class="text-left">${h.pretty_date(incomplete_test.date_crt)}</i>
                                    </div></p>
                                </div>
                            %if counter == 3:
                                <% break %>
                            %endif

                        % endfor
                            <br>
                    % endfor

                </div>
            </div>-->
        </div>
    </div>

</%block>
