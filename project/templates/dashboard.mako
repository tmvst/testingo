<%inherit file="default.mako" />
<%block name="title">Dashboard</%block>
<%block name="page_content">

    <div class="page-header">
        <h1>Dashboard</h1>
        <a href="${request.route_path('newtest')}" class="btn btn-primary pull-right">Nový test</a>
    </div>

    <div class="container">
        <p class="lead">
            Use this document as a way to quick start any new project.
            All you get is this message and a barebones HTML document.
        </p>
        <div class="row">
            <div class="col-lg-6">

                <ul id="dtab" class="nav nav-tabs">
                    <li class="active"><a href="#created_tests" data-toggle="tab">Vaše testy</a></li>
                    <li><a href="#solved_tests" data-toggle="tab">Vyplnené testy</a></li>
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
                            %if user.id == userid:
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
                </div>
            </div>

            <div class="col-lg-6">
                <div class="well text-left">
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
                                        <i class="text-left">dňa ${incomplete_test.date_crt.strftime('%d.%m.%Y')} v čase ${incomplete_test.date_crt.strftime('%H:%M')}</i>
                                    </div></p>
                                </div>
                            %if counter == 3:
                                <% break %>
                            %endif

                        % endfor
                            <br>
                    % endfor

                </div>
            </div>
        </div>
    </div>

</%block>
