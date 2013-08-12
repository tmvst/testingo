<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
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
                <form action="${request.route_path('solve',token=test.share_token)}" method="POST">
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
                        <label for="user_answer">${question.text}</label>


                        % if question.qtype == 'S':
                             <textarea class="form-control" name="user_answer" id="user_answer" rows="2" placeholder="Sem vpíšte svoju odpoveď " required></textarea>

                        % elif question.qtype == 'C':
                            %for ans in question.answers:
                                  <p><input class="checkInputC" name="check${ans.id}" type="checkbox" value="">
                              <label name="text${ans.id}">${ans.text}</label></p>
                                </p>
                            %endfor

                        % endif
                    </div>
                % endfor
            % endif


            <div class="form-group">
                <button type="submit" class="btn btn-primary">Odoslať test</button>
            </div>
        </form>

        </div>

    </div>
</%block>
