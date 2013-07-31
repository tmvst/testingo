#{{{
import random

import datetime

from pyramid.view import (
    view_config,
    )
from pyramid.httpexceptions import (
    HTTPException,
    HTTPFound,
    )

from ..models.user import (
    User,
    )
from ..models.test import (
    Test,
    )
from ..models.answer import (
    Answer,
)
from ..models.question import (
    Question,
    )
from pyramid.response import Response
#}}}

@view_config(route_name='newtest', request_method='POST')
def newtest_submission(request):
    """Handles test form submission.
    """
    POST = request.POST

    test_id = create_test(request, request.db_session,
                          POST['name'],
                          POST['description'])

    return HTTPFound(request.route_path('showtest', test_id=test_id))

def create_test(request, db_session, name, description):
    """ Creates new test and returns its id.
    """
    user_id = request.userid
    user = request.db_session.query(User).filter_by(id=user_id).first()

    date_crt = datetime.datetime.now()
    date_mdf = datetime.datetime.now()

    test = Test(name, description, "babotka", date_crt, date_mdf, user)

    db_session.add(test)
    db_session.flush()

    return test.id
@view_config(route_name='showtest', request_method='GET', renderer='project:templates/showtest.mako')
def test_view(request):

    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()
    questions = request.db_session.query(Question).filter_by(test_id=test.id).all()
    if test is None:
        raise HTTPException
        return HTTPException('Neexistujuci test')

    return {'test':test,'questions':questions}

@view_config(route_name='newtest', request_method='GET', renderer='project:templates/newtest.mako')
def newtest_view(request):
    """Shows new test.
    """

    return {'errors':[]}

@view_config(route_name='showtest', request_method='POST')
def test_show(request):
    """Handles question form submission.
    """
    POST = request.POST

    if '_method' in POST:
        testid = request.matchdict['test_id']
        test = request.db_session.query(Test).filter_by(id=testid).one()
        request.db_session.delete(test)
        return HTTPFound(request.route_path('dashboard'))

    if '_share' in POST:
        testid = request.matchdict['test_id']
        #test = request.db_session.query(Test).filter_by(id=testid).one()
        share_test(request,testid)
        return HTTPFound(request.route_path('showtest',test_id=testid))
    else:
        question_submission(request)

def question_submission(request):
    POST = request.POST
    testid = request.matchdict['test_id']

    question_id = create_question(request, request.db_session,
                                  POST['text'],
                                  POST['points'],
                                  testid
    )

    answer_id = create_answer(request, request.db_session,
                                POST['odpoved'],
                                1,question_id
    )

    return HTTPFound(request.route_path('showtest',test_id=testid))


def create_question(request, db_session, text, points, qtype):         # pridať password !!!
    """Registers a new user and returns his ID (single number).
    """

    test_id = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=test_id).one()

    lastnum = len(request.db_session.query(Question).filter_by(test_id=test_id).all())
    qnum = lastnum + 1

    question = Question(qnum, text, points, 'S', test)

    db_session.add(question)
    db_session.flush()

    return question.id

def create_answer(request, db_session, text, correct,question_id):         # pridať password !!!
    """Creates a new answer for the question.

    """
    question = request.db_session.query(Question).filter_by(id=question_id).one()

    answer = Answer( text, correct, question)

    db_session.add(answer)
    db_session.flush()

    return answer.id

def share_test(request, test_id):
    test = request.db_session.query(Test).filter_by(id=test_id).one()

    if request.userid is test.user.id:
        token = str(random.getrandbits(70))
        test.share_token = token

        return token

    raise HTTPException
    return HTTPException('Nie tvoj test!')



