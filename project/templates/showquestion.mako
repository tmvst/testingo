<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <script src="${request.static_path('project:static/js/edit_points.js')}"></script>
    <script src="${request.static_path('project:static/js/create_comment.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('showquestion', test_id=test.id,question_id=question.id)}"
    </script>
    <div class="page-header">

        <h1>Otázka č.${question.number} z testu <a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a></h1>

    </div>

    <div>
        %if question.test.share_token is None:
                <form action="${request.route_path('showquestion', test_id=test.id,question_id=question.id)}" method="POST">
                    <button type="submit" class="btn btn-danger pull-right">Zmazať otázku</button>
                </form>
        %endif
        <div class="control-group">
            <h4>${question.text}
                <span class="badge float-left">
                max. ${question.points}b
            </span>
            </h4>

            <div class="list-group">
                    % if len(answers) is 0:
                        <span> Otázka neobsahuje žiadne možnosti</span>
                    % else:
                    % for answer in question.answers:
                        % if answer.correct == 1:
                            % if (question.qtype == "C"):
                                    <span><p class="text-success"><input class="checkInputC" type="checkbox" value="" checked disabled="disabled">
                            % elif (question.qtype == "R"):
                                    <span><p class="text-success"><input class="radioR" type="radio" value="" checked disabled="disabled" >
                            % endif
                                ${answer.text}
                                </p></span>
                        % else:
                            % if (question.qtype == "C"):
                                    <span><p class="text-danger"><input class="checkInputC" type="checkbox" value="" disabled="disabled">
                                    ${answer.text}
                                    </p></span>
                            % elif (question.qtype == "R"):
                                    <span><p><input class="radioR" type="radio" value="" disabled="disabled">
                                    ${answer.text}
                                    </p></span>
                            % endif

                        % endif
                    % endfor

                    %if question.mandatory:
                            Odpovedanie na otázku je povinné
                            %else:
                            Odpovedanie na otázku je nepovinné
                            %endif
                    % endif
            </div>
        </div>
    </div>

    <div class="answer_s">

        <h2>Vyplnené odpovede</h2>

        % if len(list_of_answers) is 0:
                <span> Test nevyplnili žiadni respondenti </span>
        % else:
            % for answered_q in list_of_answers:
                <div class="panel panel-default">
                <div class="panel-heading">

                <h3 class="panel-title" id="o${answered_q[0].id}"> ${answered_q[1][0]}
                    <a class="glyphicon glyphicon-pencil pull-right zbody" id="c${answered_q[0].id}" name="${answered_q[2]}" data-points="${int(answered_q[0].question.points)}b"> </a>
                <span class="badge pull-right" id="b${answered_q[0].id}">

                %if int(answered_q[2] - answered_q[2])==0:
                    ${int(answered_q[2])}
                %else:
                    ${"%.1f" %answered_q[2]}
                %endif
                    /${int(answered_q[0].question.points)}b
                </span>

                </h3></div>
                <div class="panel-body">
                    %if answered_q[0].question.qtype =='R':
                    %for answer in answered_q[0].question.answers:
                        %if int(answered_q[1][1][0].text) == answer.id and answered_q[1][1][0].correct ==1 :

                                <span><p class="text-success"><input type="radio" disabled="disabled" checked="checked">
                                ${answer.text}</p></span>
                        %elif int(answered_q[1][1][0].text) != answer.id and answered_q[1][1][0].correct ==1 :
                                <span><p><input type="radio" disabled="disabled" >
                                ${answer.text}</p></span>
                        %elif int(answered_q[1][1][0].text) == answer.id and answered_q[1][1][0].correct ==0 :
                                <span> <p class="text-danger"><input type="radio" disabled="disabled" checked="checked">
                                ${answer.text}</p></span>
                        %elif int(answered_q[1][1][0].text) != answer.id and answered_q[1][1][0].correct ==0 :
                                <span> <p><input type="radio" disabled="disabled">
                                ${answer.text}</p></span>
                        %endif

                    %endfor
                    %elif answered_q[0].question.qtype =='C':
                    %for answer in answered_q[1][1]:

                        %if answer.text== str(1) and  answer.correct == int(1) :
                                <span><p class="text-success"><input type="checkbox" disabled="disabled" checked="checked">
                                ${answer.answer.text}</p></span>
                        %elif answer.text==str(0) and  answer.correct == int(1) :
                                <span><p class="text-success"><input type="checkbox" disabled="disabled" >
                                ${answer.answer.text}</p></span>
                        %elif answer.text==str(1) and  answer.correct ==int(0) :
                                <span> <p class="text-danger"><input type="checkbox" disabled="disabled" checked="checked">
                                ${answer.answer.text}</p></span>
                        %elif answer.text==str(0) and  answer.correct ==int(0) :
                                <span> <p class="text-danger"><input type="checkbox" disabled="disabled">
                                ${answer.answer.text}</p></span>
                        %endif

                    %endfor

                    %elif answered_q[0].question.qtype =='S':
                    %for answer in answered_q[1][1]:
                        %if answer.correct == int(1):
                                <p class="text-success">
                                    <strong>Správna odpoveď uźívateľa:</strong>
                                ${answer.text} <br>
                                </p>
                        %elif answer.correct == int(0):
                                <p class="text-danger">
                                    <strong>Nesprávna odpoveď uźívateľa:</strong>
                                ${answer.text} <br>
                                </p>

                        %endif

                    %endfor

                    %elif answered_q[0].question.qtype =='O':
                    %for answer in answered_q[1][1]:
                            <p>
                                <strong>Odpoveď uívateľa:</strong>
                            ${answer.text} <br></p>
                    %endfor
                    %endif
                     <div class="accordion" id="a${answered_q[0].id}">
                            <div class="accordion-group">
                                <div class="accordion-heading">

                                        <a class="accordion-toggle pull-right" data-toggle="collapse" data-parent="a${answered_q[0].id}" href="#h${answered_q[0].id}">
                                            Komentár
                                        </a>

                                </div>

                                <div id="h${answered_q[0].id}" class="accordion-body collapse out">
                                    <div class="accordion-inner">

                                        <a class="zkomment bezhref pull-right" id="upravit_btn${answered_q[0].id}" name="${answered_q[0].comment}"><br>Upraviť</a>
                                        <div id="koment_text${answered_q[0].id}">
                                            <br>Komentár:<br>
                                
                                            % if  answered_q[0].comment:
                                            <div class="well well-sm" id="koment_text#{tu}">
                                                ${answered_q[0].comment}
                                            </div>
                                            % endif
                                           
                                        </div>

                                        <div id="koment_area${answered_q[0].id}"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                </div>


            % endfor
        % endif
    </div>
</%block>
