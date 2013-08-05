#{{{
import random

import datetime

from pyramid.view import (
    view_config,
    )
from pyramid.httpexceptions import (
    HTTPException,
    HTTPFound,
    HTTPForbidden,
    HTTPUnauthorized
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
from ..models.incomplete_test import (
    Incomplete_test,
)
from ..views.question import (
    question_submission,
)
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
    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()
    if request.userid is None:
        raise  HTTPForbidden
        return  HTTPForbidden('Pre prístup je nutné sa prihlásiť')

    if request.userid is not test.user_id:
        raise  HTTPUnauthorized
        return  HTTPUnauthorized('Nie je to tvoj test')

    if test is None:
        raise HTTPException
        return HTTPException('Neexistujuci test')
    else:
        return {'test':test,'questions':questions,'solved_tests':solved_tests}

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
    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()
    if '_method' in POST:
        test = request.db_session.query(Test).filter_by(id=testid).one()
        request.db_session.delete(test)
        return HTTPFound(request.route_path('dashboard'))

    if '_share' in POST:
        share_test(request,testid)
        return HTTPFound(request.route_path('showtest',test_id=testid))
    else:
        return question_submission(request)

def share_test(request, test_id):
    test = request.db_session.query(Test).filter_by(id=test_id).one()

    if request.userid is test.user.id:
        token = str(random.getrandbits(70))
        test.share_token = token

        return token

    raise HTTPException
    return HTTPException('Nie tvoj test!')




