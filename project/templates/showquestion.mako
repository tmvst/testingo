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
            <span class="badge pull-right">
                max. ${question.points}b
            </span>
            </h4>
            <div class="list-group">
                % if len(answers) is 0:
                    <span> Otázka neobsahuje žiadne možnosti</span>
                % else:
                    % for answer in answers:
                        <p class="text-success">
                            ${answer.text} <br>
                        </p>
                    % endfor
                % endif
            </div>
        </div>
    </div>

    <div class="answer_s">

    <h2>Vyplnené odpovede</h2>

        % if len(emails_and_answers) is 0:
            <span> Test nevyplnili žiadni respondenti </span>
        % else:
            % for respondent, answer in emails_and_answers:
                <div class="panel">
                    <div class="panel-heading">

                        <h3 class="panel-title">${respondent}
                        % if answer.correct == 1:        
                            <span class="badge pull-right">
                                ${answer.question.points}b
                            </span>
                        %else:
                            <span class="badge pull-right">
                                ${0}b
                            </span>
                        %endif
                        </h3>
                    </div>

                    <p><strong>Odpoveď <br></strong>${answer.text}</p>
                    % if answer.correct == 1:
                        <p class="text-success">
                            <strong>Správna odpoveď</strong>
                        </p>
                    %else:
                        <p class="text-danger">
                            <strong>Nesprávna odpoveď</strong>
                        </p>
                    % endif

                </div>
            % endfor
        % endif
    </div>
</%block>
