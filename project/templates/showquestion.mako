<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <div class="page-header">
        <h1>Otázka č.${question.number} z testu <a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a></h1>
    </div>

    <div class="container">
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
                                    <input class="checkInputC pull-left" type="checkbox" alue="" checked disabled>
                            % elif (question.qtype == "R"):
                                    <input class="radioR pull-left" type="radio" value="" checked disabled >
                            % endif
                                <p class="text-success">
                                ${answer.text}
                                </p>
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
                <div class="panel">
                    <div class="panel-heading">

                        <h3 class="panel-title"> ${answered_q[1][0]}
                         <span class="badge pull-right" id="b${answered_q[0].id}">

                        %if int(answered_q[2] - answered_q[2])==0:
                            ${int(answered_q[2])}
                        %else:
                            ${"%.1f" %answered_q[2]}
                        %endif
                            /${int(answered_q[0].question.points)}b
                        </span>

                        </h3></div>
                %if answered_q[0].question.qtype =='R':
                    %for answer in answered_q[0].question.answers:
                        %if answered_q[1][1][0].answer_id == answer.id and answered_q[1][1][0].correct ==1 :

                                <span><p class="text-success"><input type="radio" disabled="disabled" checked="checked">
                                ${answer.text}</p></span>
                        %elif answered_q[1][1][0].answer_id != answer.id and answered_q[1][1][0].correct ==1 :
                                <span><p><input type="radio" disabled="disabled" >
                                ${answer.text}</p></span>
                        %elif answered_q[1][1][0].answer_id == answer.id and answered_q[1][1][0].correct ==0 :
                                <span> <p class="text-danger"><input type="radio" disabled="disabled" checked="checked">
                                ${answer.text}</p></span>
                        %elif answered_q[1][1][0].answer_id != answer.id and answered_q[1][1][0].correct ==0 :
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
                </div>


            % endfor
        % endif
    </div>
</%block>
