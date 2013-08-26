<%inherit file="default.mako" />
<%! import markupsafe %>
<%block name="title">${incomplete_test.test.name}</%block>
<%block name="page_content">
    <script src="${request.static_path('project:static/js/edit_points.js')}"></script>
    <script src="${request.static_path('project:static/js/create_comment.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('solved_test', incomplete_test_id=incomplete_test.id)}"
    </script>
    <div class="page-header">
        <h1>${incomplete_test.test.name}</h1>
    </div>
    <div>
        <div class="control-group">
            <div class="controls">
                <p>${incomplete_test.test.description}</p>
            </div>

            <h2>Otázky</h2>

            % if len(incomplete_test.test.questions) is 0:
                    <span> Test neobsahuje žiadne otázky a ani odpovede </span>
            % else:
                % for question in questions_and_answers:

                    <div class="panel panel-default">
                    <div class="panel-heading">
                    <div class="row">
                    <div class="col-md-6">
                    <h3 class="panel-title">
                    <a href="${request.route_path('showquestion',test_id=incomplete_test.test.id, question_id=question[0].question.id)}" method="GET">
                        Otázka č.${question[0].question.number}
                    %if question[0].question.mandatory:
                            - povinná
                    %else:
                            - nepovinná
                    %endif </a></h3>
                </div>
                <div class="col-md-6">
                <h3 class="panel-title" id="o${question[0].id}">
                    <a class="glyphicon glyphicon-pencil pull-right zbody" id="c${question[0].id}" name="${question[2]}" data-points="${int(question[0].question.points)}b"> </a>

                <span class="badge pull-right" id="b${question[0].id}">

                  ${h.pretty_points(question[2])}
                        /   ${h.pretty_points(question[0].question.points)}b

                    </span>
                    </h3>
                    </div>
                    </div>
                    </div>
                    <div class="panel-body">
                        <p><strong>Znenie otázky <br></strong>${question[0].question.text.replace('\n', markupsafe.Markup('<br> '))|n}</p>

                    % if question[0].question.qtype == 'S':

                        % for ans in question[1]:
                            % if ans.correct == 1:
                                    <p class="text-success">
                                        <strong>Správna odpoveď užívateľa:</strong>
                                    ${ans.text} <br>
                                    </p>

                            %else:
                                    <p class="text-danger">
                                        <strong>Nesprávna odpoveď užívateľa:</strong>
                                    ${ans.text} <br>
                                    </p>
                            % endif
                        %endfor
                    % elif question[0].question.qtype == 'C':

                        % for ans in question[1]:

                            % if ans.correct == 1:
                                %if int(ans.text) == 0:
                                        <span><p class="text-success"><input type="checkbox" disabled="disabled">
                                        ${ans.answer.text}</p></span>
                                %else:
                                        <span><p class="text-success"><input type="checkbox" disabled="disabled" checked="checked">
                                        ${ans.answer.text}</p></span>
                                %endif

                            %else:
                                %if int(ans.text) == 0:
                                        <span>  <p class="text-danger"><input type="checkbox" disabled="disabled">
                                        ${ans.answer.text}</p></span>

                                %else:

                                        <span><p class="text-danger"><input type="checkbox" disabled="disabled" checked="checked">
                                        ${ans.answer.text}</p></span>
                                %endif

                            % endif
                        % endfor

                    % elif question[0].question.qtype == 'R':

                        % for ans in question[0].question.answers:

                            %if question[1][0].correct == 1:
                                %if ans.correct ==1:
                                        <span><p class="text-success"><input type="radio" disabled="disabled" checked="checked">
                                        ${ans.text}</p></span>
                                %else:
                                        <span><p><input type="radio" disabled="disabled" >
                                        ${ans.text}</p></span>

                                %endif

                            %else:
                                %if ((int(question[1][0].text) == ans.id) and (ans.id != int(question[1][0].answer_id))):
                                        <span> <p class="text-danger"><input type="radio" disabled="disabled" checked="checked">
                                        ${ans.text}</p></span>
                                %elif  int(ans.id) == int(question[1][0].answer_id):
                                        <span> <p class="text-success"><input type="radio" disabled="disabled" >
                                        ${ans.text}</p></span>
                                %else:
                                        <span> <p><input type="radio" disabled="disabled">
                                        ${ans.text}</p></span>


                                %endif
                            %endif

                        % endfor

                    % elif question[0].question.qtype == 'O':
                            <p><strong>Užívateľová odpoveď <br></strong></p>

                        ${question[1][0].text.replace('\n', markupsafe.Markup('<br> '))|n}

                    % endif

                    <div class="accordion" id="a${question[0].id}">
                    <div class="accordion-group">
                        <div class="accordion-heading">

                            <a class="accordion-toggle pull-right" data-toggle="collapse" data-parent="a${question[0].id}" href="#h${question[0].id}">
                                Komentár
                            </a>

                        </div>

                    <div id="h${question[0].id}" class="accordion-body collapse out">
                    <div class="accordion-inner">

                        <a class="zkomment bezhref pull-right" id="upravit_btn${question[0].id}" name="${question[0].comment}"><br>Upraviť</a>
                    <div id="koment_text${question[0].id}">
                        <br>Komentár:<br>

                    % if  question[0].comment:
                            <div class="well well-sm" id="koment_text#{tu}">
                            ${question[0].comment.replace('\n', markupsafe.Markup('<br> '))|n}
                            </div>
                    % endif

                    </div>

                        <div id="koment_area${question[0].id}"></div>
                    </div>
                    </div>
                    </div>
                    </div>
                    </div>
                    </div>
                % endfor
            % endif
        </div>
    </div>
</%block>
