<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <script src="${request.static_path('project:static/js/solve.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('solve', token=token)}"
    </script>
    <div class="page-header">
        <h1>${test.name}</h1>
    </div>
    <div class="container">
        <div class="control-group">
            <div class="controls">
                <p>${test.description}</p>
            </div>

            <h2>Otázky</h2>
            % if len(test.questions) is 0:
                    <span> Test neobsahuje žiadne otázky </span>
            % else:
                <form action="#" id="form_solve">
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
                         <div class="panel-body">
                        <label for="user_answer">${question.text}</label>

                        <!--id otazky v nazve text area-->
                    % if question.qtype == 'S':
                        %for ans in question.answers:
                                <p><input class="form-control user_answers_S"  name="${question.id}&${ans.id}"   rows="2" placeholder="Sem vpíšte svoju odpoveď " required>
                                </p>
                        %endfor
                    % elif question.qtype == 'C':
                        %for ans in question.answers:
                                <!--id oodpovede v nazve text area-->

                                <p><input class="user_answers_C" name="check${ans.id}" type="checkbox" value="">
                                    <label class="checkbox_labels" name="text${ans.id}">${ans.text}</label></p>
                        %endfor
                    % elif question.qtype == 'R':
                        %for ans in question.answers:
                                <!--id oodpovede v nazve text area-->

                                <p><input class="user_answers_R" name="radio${question.id}" id="radio${ans.id}" type="radio" value="${ans.id}">
                                    <label name="text${ans.id}">${ans.text}</label></p>
                        %endfor
                    % elif question.qtype == 'O':
                            <textarea class="form-control user_answers_O"  name="user_answer${question.id}" id="user_answer" rows="2" placeholder="Sem vpíšte svoju odpoveď " required> </textarea>
                    % endif
                    </div>
                    </div>
                % endfor
                    <div class="form-group">
                        <button type="submit" formaction="#" class="btn btn-primary" id="solve_test">Odoslať test</button>
                    </div>
                </form>
            % endif
        </div>
    </div>
</%block>
