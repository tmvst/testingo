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

        % if len(emails_and_answers_and_text) is 0:
                <span> Test nevyplnili žiadni respondenti </span>
        % else:
            <script text=javascript>
                var quest
            </script>
            % for respondent, answer, text in emails_and_answers_and_text:
                    % if quest != answer.complete_question:
                        <div class="panel">
                        <div class="panel-heading">
                        <h3 class="panel-title">${respondent}
                    % endif

                    <% guest = answer.complete_question %>

                    % if (answer.correct == 1) or (answer.question.qtype == 'O'):
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

                    % if answer.correct == 1:

                        %if answer.question.qtype=="O":
                            <p><i>${text}</i></p>

                        % elif (answer.question.qtype == "C"):
                            <input class="checkInputC pull-left" type="checkbox" alue="" checked disabled>
                            <p class="text-success">
                                ${text}
                            </p>

                        % elif (answer.question.qtype == "R"):
                            <input class="radioR pull-left" type="radio" value="" checked disabled >
                            <p class="text-success">
                                ${text}
                            </p>
                        % endif

                    % else:

                        % if (answer.question.qtype == "C"):
                            <input class="checkInputC pull-left" type="checkbox" value=""disabled>
                            <p class="text-danger">
                                ${text}
                            </p>

                        % elif (answer.question.qtype == "R"):
                            <input class="radioR pull-left" type="radio" value="" disabled>
                            <p>
                                ${text}
                            </p>
                        % endif
                    % endif
                </div>
            % endfor
        % endif
    </div>
</%block>
