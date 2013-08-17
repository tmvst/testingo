<h3>Otázky v teste ${test.name}</h3>
% if len(test.questions) is 0:
    <span> Test neobsahuje žiadne otázky </span>
% else:
    % for question in test.questions:
        <div class="panel">
        <div class="panel-heading">

        <a href="${request.route_path('showquestion',test_id=test.id, question_id=question.id)}" method="GET">

        <h3 class="panel-title">Otázka č.${question.number}
        % if question.points:
                <span class="badge pull-right">
								${question.points}b
							</span>
        % endif
        </h3>

        </a>
        </div>
            <strong>${question.text}</strong>
            <br>
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
                % elif (question.qtype == "R"):
                        <input class="radioR pull-left" type="radio" value="" disabled>
                % endif
                    <p class="text-danger">
                    ${answer.text}
                    </p>
            % endif
        % endfor
            </p>
        </div>
    % endfor
% endif
</div>