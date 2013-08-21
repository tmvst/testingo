<%inherit file="default.mako" />
<%block name="title">${incomplete_test.test.name}</%block>
<%block name="page_content">
<script src="${request.static_path('project:static/js/edit_points.js')}"></script>
<script src="${request.static_path('project:static/js/create_comment.js')}"></script>
<script type="text/javascript">
	post_url="${request.route_path('solved_test', incomplete_test_id=incomplete_test.id)}"
</script>
<div class="page-header">
	<h1>${incomplete_test.test.name}</h1>
</div>
<div>
	<div class="control-group">
		<div class="controls">
			<p>${incomplete_test.test.description}</p>
		</div>

		<h2>Otázky</h2>

		% if len(incomplete_test.test.questions) is 0:
		<span> Test neobsahuje žiadne otázky a ani odpovede </span>
		% else:
		% for question in questions_and_answers:

		<div class="panel panel-default">
			<div class="panel-heading">
				<a href="${request.route_path('showquestion',test_id=incomplete_test.test.id, question_id=question[0].question.id)}" method="GET"></a>
				<h3 class="panel-title" id="o${question[0].id}">Otázka č.${question[0].question.number}</h3>
					<a class="btn glyphicon glyphicon-envelope pull-right zkomment" id="k${question[0].question.id}" name="${question[2]}"> </a>
					<a class="btn glyphicon glyphicon-pencil pull-right zbody" id="c${question[0].id}" name="${question[2]}"> </a>

					<span class="badge pull-right" id="b${question[0].id}">
						%if int(question[2] - question[2])==0:
						${int(question[2])}
						%else:
						${"%.1f" % question[2]}
						%endif
						/${int(question[0].question.points)}b
					</span>
			</div>
			<div class="panel-body">
				<p><strong>Znenie otázky <br></strong>${question[0].question.text}</p>

				% if question[0].question.qtype == 'S':

				% for ans in question[1]:
				% if ans.correct == 1:
				<p class="text-success">
					<strong>Správna odpoveď užívateľa:</strong>
					${ans.text} <br>
				</p>

				%else:
				<p class="text-danger">
					<strong>Nesprávna odpoveď užívateľa:</strong>
					${ans.text} <br>
				</p>
				% endif
				%endfor
				% elif question[0].question.qtype == 'C':

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

								% elif question[0].question.qtype == 'R':

								% for ans in question[0].question.answers:

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



													% elif question[0].question.qtype == 'O':



													<p><strong>Užívateľová odpoveď <br></strong></p>

													${question[1][0].text}</p>
													<div id="koment${question[0].question.id}"></div>



													% endif

												</div>
											</div>
											% endfor
											% endif
										</div>
									</div>
									</%block>
