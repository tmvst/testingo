#{{{
from pyramid.view import (
    view_config,
    )

from pyramid.httpexceptions import (
    HTTPException,
    HTTPFound,
    HTTPForbidden,
    HTTPUnauthorized
    )

from ..models.answer import (
    Answer,
    )
from ..models.test import (
    Test,
    )
from ..models.question import (
    Question,
    )

from ..models.complete_answer import (
    Complete_answer,
    )
from ..models.incomplete_test import (
    Incomplete_test,
    )

#}}}

@view_config(route_name='showquestion', request_method='GET', renderer='project:templates/showquestion.mako')
def view_question(request):
    """
    Shows requested question.
    """
    testid = request.matchdict['test_id']
    questionid = request.matchdict["question_id"]
    test = request.db_session.query(Test).filter_by(id=testid).one()
    question = request.db_session.query(Question).filter_by(id=questionid).one()
    answers = request.db_session.query(Answer).filter_by(question=question).all()
    if request.userid is None:
        raise  HTTPForbidden
        return  HTTPForbidden('Pre prístup je nutné sa prihlásiť')
    if request.userid is not test.user_id:
        raise  HTTPUnauthorized
        return  HTTPUnauthorized('Nie je to tvoja otázka')
    if test is None:
        raise HTTPException
        return HTTPException('Neexistujuca otazka')
    list_of_answers = view_respondents_answer(request)
    return {'test':test,'question':question, 'answers':answers, 'list_of_answers':list_of_answers}

def view_respondents_answer(request):
    """
    odpovede a emaily respondentov
    """

    questionid = request.matchdict["question_id"]
    question = request.db_session.query(Question).filter_by(id=questionid).one()
    list=[]
    for cq in question.complete_question:
        user_and_answers =[cq.incomplete_test.user,request.db_session.query(Complete_answer).filter_by(question=question,incomp_test=cq.incomplete_test).all()]
        acq_points =  sum(float(a.points) for a in user_and_answers[1])
        item=[cq,user_and_answers,acq_points]
        list.append(item)
    print(list)
    # answers_text=answers_text.append([ a for a in c_q.answers])
    #
    # tests=[a.incomp_test for a in respondanswers]
    # res_users=[a.user for a in tests]
    # res_email=[a.email for a in res_users]


    return list

@view_config(route_name='showquestion', request_method='POST')
def question_delete(request):
    """
    Deletes selected question from test and db.
    """

    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()
    if test.share_token:
        return HTTPFound(request.route_path('showtest', test_id=testid))
    questionid = request.matchdict['question_id']
    question= request.db_session.query(Question).filter_by(id=questionid).one()
    question_number=question.number
    questions_with_number_to_be_changed = request.db_session.query(Question).filter(Question.number > question_number).all()
    for q in questions_with_number_to_be_changed:
        q.number=q.number-1

    test.sum_points-=question.points
    request.db_session.delete(question)
    request.db_session.flush()
    return HTTPFound(request.route_path('showtest', test_id=testid))

def create_question(request, db_session, text, points, q_type):         # pridať password !!!
    """Creates a new question and returns its id.
    """

    test_id = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=test_id).one()
    if points is '':
        points = 0
    test.sum_points=test.sum_points + int(points)
    lastnum = len(request.db_session.query(Question).filter_by(test_id=test_id).all())
    qnum = lastnum + 1

    question = Question(qnum, text, points, q_type, test)

    db_session.add(question)
    db_session.flush()

    return question.id

def create_answer(request, db_session, text, correct, question_id):         # pridať password !!!
    """Creates a new answer for the question.
    """
    question = request.db_session.query(Question).filter_by(id=question_id).one()

    answer = Answer( text, correct, question)

    db_session.add(answer)
    db_session.flush()

    return answer.id



# ---------------------------------- new stuff ------- (babotkina volba) ----------------


@view_config(route_name='newquestion_s', request_method='GET', renderer='project:templates/newquestion_s.mako')
def s_question_view(request):
    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()

    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_c', request_method='GET', renderer='project:templates/newquestion_c.mako')
def c_question_view(request):
    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()

    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_r', request_method='GET', renderer='project:templates/newquestion_r.mako')
def r_question_view(request):
    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()

    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_o', request_method='GET', renderer='project:templates/newquestion_o.mako')
def o_question_view(request):
    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()

    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_s', request_method='POST')
def s_question_post(request):
    testid = request.matchdict['test_id']

    json = request.json_body
    points = json['points']
    text = json['text']

    test = request.db_session.query(Test).filter_by(id=testid).one()

    if test.share_token:
        return HTTPFound(request.route_path('showtest', test_id=testid))

    question_id = create_question(request, request.db_session,
                                  text,
                                  int(points),
                                  'S'
    )

    # q_type reprezentuje typ otazky S,C,R,O



    answers = json['answers']
    for a in answers :
        ans = a['value']
        create_answer(request,request.db_session,
                      ans,
                      1,
                      question_id)

    return HTTPFound(request.route_path('newquestion_s', test_id=testid))

@view_config(route_name='newquestion_c', request_method='POST')
def c_question_post(request):
    testid = request.matchdict['test_id']
    test=request.db_session.query(Test).filter_by(id=testid).one()

    json = request.json_body
    points = json['points']
    text = json['text']

    if test.share_token:
        return HTTPFound(request.route_path('showtest', test_id=testid))

    question_id = create_question(request, request.db_session,
                                  text,
                                  int(points),
                                  'C'
    )

    # q_type reprezentuje typ otazky S,C,R,O

    counter = 1
    counterc = 0
    answers = json['answers']
    correctness = json['correctness']
    for a in answers :
        ans = a['value']
        if counterc < len(correctness) and 'check'+str(counter) == correctness[counterc]['name']:
            create_answer(request,request.db_session,
                          ans,
                          1,
                          question_id)
            counterc += 1
        else:
            create_answer(request,request.db_session,
                          ans,
                          0,
                          question_id)
        counter += 1

    return HTTPFound(request.route_path('newquestion_c', test_id=testid))

@view_config(route_name='newquestion_r', request_method='POST')
def r_question_post(request):
    testid = request.matchdict['test_id']

    json = request.json_body
    points = json['points']
    text = json['text']

    test = request.db_session.query(Test).filter_by(id=testid).one()

    if test.share_token:
        return HTTPFound(request.route_path('showtest', test_id=testid))

    question_id = create_question(request, request.db_session,
                                  text,
                                  int(points),
                                  'R'
    )

    # q_type reprezentuje typ otazky S,C,R,O

    counter = 1
    counterc = 0
    answers = json['answers']
    correctness = json['correctness']
    for a in answers :
        ans = a['value']
        if counterc < len(correctness) and 'radio'+str(counter) == correctness[counterc]['name']:
            create_answer(request,request.db_session,
                          ans,
                          1,
                          question_id)
            counterc += 1
        else:
            create_answer(request,request.db_session,
                          ans,
                          0,
                          question_id)
        counter += 1

    return HTTPFound(request.route_path('newquestion_r', test_id=testid))

@view_config(route_name='newquestion_o', request_method='POST')
def o_question_post(request):
    testid = request.matchdict['test_id']

    json = request.json_body
    points = json['points']
    text = json['text']
    answer = json['answer']
    print(answer)

    test = request.db_session.query(Test).filter_by(id=testid).one()

    if test.share_token:
        return HTTPFound(request.route_path('showtest', test_id=testid))

    question_id = create_question(request, request.db_session,
                                  text,
                                  int(points),
                                  'O'
    )
    create_answer(request,request.db_session,
                  answer,
                  1,
                  question_id)

    return HTTPFound(request.route_path('newquestion_o', test_id=testid))
