<%inherit file="default.mako" />
<%block name="title">${incomplete_test.test.name}</%block>
<%block name="page_content">
<div class="page-header">
    <h1>${incomplete_test.test.name}</h1>
</div>
    <div class="container">
        <div class="control-group">
            <div class="controls">
                <p>${incomplete_test.test.description}</p>
            </div>

            <h2>Otázky</h2>

            % if len(incomplete_test.test.questions) is 0:
                    <span> Test neobsahuje žiadne otázky a ani odpovede </span>
            % else:
                % for question in questions_and_answers:
                % if question[0].qtype == 'S':

                        <div class="panel">
                            <div class="panel-heading">
                            	<a href="${request.route_path('showquestion',test_id=incomplete_test.test.id, question_id=question[0].id)}" method="GET">

                                	% if question[1].correct == 1:
                                	<h3 class="panel-title">Otázka č.${question[0].number}
                                	<span class="badge pull-right">
                                     ${question[0].points}b

                                  </span>
                                  </h3>
                                  %else:
                                  <h3 class="panel-title">Otázka č.${question[0].number}
                                  <span class="badge pull-right">
                                     ${0}b
                                  </span>
                                  </h3>
                                	%endif
                                </a>
                        	</div>
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
                            	% if question[1].correct == 1:
                                    <p class="text-success">
                                    <strong>Správna odpoveď uźívateľa:</strong>
                                        ${question[1].text} <br>
                                    </p>

                                %else:
                                    <p class="text-danger">
                                    <strong>Nesprávna odpoveď uźívateľa:</strong>
                                        ${question[1].text} <br>
                                    </p>

                            	% endif

                        </div>
                       % endif
                 % elfif question[0].qtype == 'C':

                        <div class="panel">
                            <div class="panel-heading">
                            	<a href="${request.route_path('showquestion',test_id=incomplete_test.test.id, question_id=question[0].id)}" method="GET">

                                	% if question[1].correct == 1:
                                	<h3 class="panel-title">Otázka č.${question[0].number}

                                  </h3>
                                  %else:
                                  <h3 class="panel-title">Otázka č.${question[0].number}

                                  </h3>
                                	%endif
                                </a>
                        	</div>
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
                            	% if question[1].correct == 1:
                                    <p class="text-success">
                                    <strong>Správna odpoveď uźívateľa:</strong>
                                        ${question[1].text} <br>
                                    </p>

                                %else:
                                    <p class="text-danger">
                                    <strong>Nesprávna odpoveď uźívateľa:</strong>
                                        ${question[1].text} <br>
                                    </p>

                            	% endif

                        </div>
                       % endif
                % endfor
            % endif
        </div>
    </div>
</%block>
