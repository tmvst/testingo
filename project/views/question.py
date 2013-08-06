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
        return  HTTPForbidden('Nie je to tvoja otázka')
    if request.userid is not test.user_id:
        raise  HTTPUnauthorized
        return  HTTPUnauthorized('Pre prístup je nutné sa prihlásiť')
    if test is None:
        raise HTTPException
        return HTTPException('Neexistujuca otazka')
    return {'test':test,'question':question, 'answers':answers}

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

@view_config(route_name='newquestion', request_method='GET', renderer='project:templates/newquestion.mako')
def question_view(request):
    """Shows new question.
    """
    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()
    return {'errors':[], 'test':test}

def answer_view(request):
    """Shows answer.
    """

    return {'errors':[]}



@view_config(route_name='newquestion', request_method='POST')
def question_submission(request):
    """Handles question form submission.
    """
    POST = request.POST
    testid = request.matchdict['test_id']
    test=request.db_session.query(Test).filter_by(id=testid).one()

    if test.share_token:
        return HTTPFound(request.route_path('showtest', test_id=testid))
    question_id = create_question(request, request.db_session,
                                  POST['text'],
                                  POST['points'],
                                  testid
    )

    answer_id = create_answer(request, request.db_session,
                              POST['odpoved'],
                              1,question_id
    )


    return HTTPFound(request.route_path('newquestion',test_id=testid))


def create_question(request, db_session, text, points, qtype):         # pridať password !!!
    """Creates a new question and returns its id.
    """

    test_id = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=test_id).one()
    print('XXXX'*1000)
    print(test.share_token)
    test.sum_points=test.sum_points + int(points)
    lastnum = len(request.db_session.query(Question).filter_by(test_id=test_id).all())
    qnum = lastnum + 1

    question = Question(qnum, text, points, 'S', test)

    db_session.add(question)
    db_session.flush()

    return question.id

def create_answer(request, db_session, text, correct,question_id):         
    """Creates a new answer for the question.

    """
    question = request.db_session.query(Question).filter_by(id=question_id).one()

    answer = Answer( text, correct, question)

    db_session.add(answer)
    db_session.flush()

    return answer.id
