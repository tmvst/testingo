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

                        % if question[1][0].correct == 1:

                            <h3 class="panel-title" id="o${question[0].id}">Otázka č.${question[0].number}
                            <span class="badge pull-right" id="b${question[0].id}">
                            %if int(question[2] - question[2])==0:
                                ${int(question[2])}
                            %else:
                                ${"%.1f" % question[2]}
                            %endif
                                /${int(question[0].points)}b
                            </span>
                            </h3>
                        %else:

                                <h3 class="panel-title" id="o${question[0].id}">Otázka č.${question[0].number}
                                    <span class="badge pull-right" id="b${question[0].id}">
                                        ${0}b
                                  </span>
                                </h3>
                        %endif
                            </a>
                        </div>
                        <div class="panel-body">
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
                        % for ans in question[1]:
                            % if ans.correct == 1:
                                    <p class="text-success">
                                        <strong>Správna odpoveď :</strong>
                                    ${ans.text} <br>
                                    </p>

                            %else:
                                    <p class="text-danger">
                                        <strong>Nesprávna odpoveď:</strong>
                                    ${ans.text} <br>
                                    </p>

                            % endif
                        %endfor
                        </div>
                        </div>
                    % elif question[0].qtype == 'C':

                        <div class="panel">
                        <div class="panel-heading">

                        <h3 class="panel-title">Otázka č.${question[0].number}

                        <span class="badge pull-right" id="b${question[0].id}">
                        %if int(question[2] - question[2])==0:
                            ${int(question[2])}
                        %else:
                            ${"%.1f" % question[2]}
                        %endif
                            /${int(question[0].points)}b
                        </span></h3>
                        </div>
                        <div class="panel-body">
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
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
                        </div>

                        </div>


                    % elif question[0].qtype == 'O':

                        <div class="panel">
                        <div class="panel-heading">

                        <h3 class="panel-title" id="o${question[0].id}">Otázka č.${question[0].number}
                        <span class="badge pull-right" id="b${question[0].id}">
                        %if int(question[2] - question[2])==0:
                            ${int(question[2])}
                        %else:
                            ${"%.1f" % question[2]}
                        %endif
                            /${int(question[0].points)}b
                        </span>
                        </h3>


                        </div>
                        <div class="panel-body">
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
                        % for ans in question[1]:
                                <p>
                                    <strong>Odpoveď užívateľa:</strong>
                                ${ans.text} <br>
                                </p>

                        %endfor
                        </div>

                        </div>


                    % elif question[0].qtype == 'R':

                        <div class="panel">
                        <div class="panel-heading">

                        <h3 class="panel-title">Otázka č.${question[0].number}

                        <span class="badge pull-right" id="b${question[0].id}">
                        %if int(question[2] - question[2])==0:
                            ${int(question[2])}
                        %else:
                            ${"%.1f" % question[2]}
                        %endif
                            /${int(question[0].points)}b
                        </span> </h3>
                        </div>
                        <div class="panel-body">
                            <p><strong>Znenie otázky <br></strong>${question[0].text}</p>
                        % for ans in question[0].answers:

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
                        </div>
                        </div>
                    % endif
                % endfor
            % endif


        </div>
    </div>
</%block>
