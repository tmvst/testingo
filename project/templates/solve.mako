<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <div class="page-header">
        <h1>${test.name}</h1>
    </div>

    <div class="container">
        <form action="${request.route_path('solvetests', token=token)}" method="POST">
            <button type="submit" class="btn btn-danger pull-right">Odoslať test</button>
        <div class="control-group">
            <div class="controls">
                <p>${test.description}</p>
            </div>

            <h2>Otázky</h2>


            % if len(questions) is 0:
                    <span> Test neobsahuje žiadne otázky </span>
            % else:
                % for question in questions:
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
                                 <label for="user_answer">Vaša odpoveď</label>
                                 <textarea class="form-control" name="user_answer" id="user_answer" rows="2" placeholder="Sem vpíšte svoju odpoveď " required></textarea>
                              </div>
                % endfor
            % endif
            </div>
        </form>
    </div>
</%block>
