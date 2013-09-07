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
    <div>
        <div class="control-group">
                <p class="lead">${test.description}</p>

            <h2>Otázky</h2>
            % if len(test.questions) is 0:
                    <em> Test neobsahuje žiadne otázky </em>
            % else:
                <form action="#" id="form_solve">
                % for question in test.questions:
                    <div class="panel panel-default">
                    <div class="panel-heading">
					% if question.points:
                            <span class="badge pull-right">
								${h.pretty_points(question.points)}b
							</span>
                    % endif
                    <h3 class="panel-title">${question.number}. ${question.text}</h3>

                    </div>
                        <div class="panel-body">

                        <!--id otazky v nazve text area-->
                    % if question.qtype == 'S':
                        %for ans in question.answers:
                                <input class="form-control user_answers_S"  name="${question.id}&${ans.id}"   rows="2" placeholder="Sem vpíšte svoju odpoveď " required> <br>
                        %endfor
                    % elif question.qtype == 'C':
                        %for ans in question.answers:
							<div class="checkbox ptop">
                                <!--id oodpovede v nazve text area-->
                                <label class="checkbox_labels" name="text${ans.id}">
	                                <input class="user_answers_C" name="check${ans.id}" type="checkbox" value="">
                                    ${ans.text}
                                </label>
							</div>
                        %endfor
                    % elif question.qtype == 'R':
                        %for ans in question.answers:
							<div class="radio ptop">
                                <!--id oodpovede v nazve text area-->
                                <label class="radio_labels" name="text${ans.id}">
	                                <input class="user_answers_R" name="radio${question.id}" id="radio${ans.id}" type="radio" value="${ans.id}">
                                    ${ans.text}
                                </label>
							</div>
                        %endfor
                    % elif question.qtype == 'O':
                            <textarea class="form-control user_answers_O"  name="user_answer${question.id}" id="user_answer" rows="4" placeholder="Sem vpíšte svoju odpoveď " required> </textarea>
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
<textarea id="mytextarea"></textarea>

