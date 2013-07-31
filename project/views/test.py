#{{{
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
from ..models.question import (
    Question,
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
    if test is None:
        raise HTTPException
        return HTTPException('Neexistujuci test')

    return {'test':test,'questions':questions}

@view_config(route_name='showtest', request_method='POST')
def delete_test(request):
    """
    Deletes selected test from db.
    """
    testid = request.matchdict['test_id']
    test = request.db_session.query(Test).filter_by(id=testid).one()
    request.db_session.delete(test)

    return HTTPFound(request.route_path('dashboard'))
@view_config(route_name='newtest', request_method='GET', renderer='project:templates/newtest.mako')
def newtest_view(request):
    """Shows new test.
    """

    return {'errors':[]}