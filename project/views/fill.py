from pyramid.view import (
    view_config,
    )
from pyramid.httpexceptions import (
    HTTPException,
    HTTPFound,
    HTTPForbidden,
    HTTPUnauthorized
    )


from ..models.test import (
    Test,
    )

from ..models.incomplete_test import (
    Incomplete_test
)
from ..models.complete_answer import (
    Complete_answer,
)


@view_config(route_name='filled_test', request_method='GET', renderer='project:templates/filled_test.mako')
def show_filled_test(request):

    incomplete_test_id = request.matchdict['incomplete_test_id']
    incomplete_test = request.db_session.query(Incomplete_test).filter_by(id=incomplete_test_id).one()

    test = request.db_session.query(Test).filter_by(id=incomplete_test.test_id).one()
    questions = test.questions
    questions_and_answers=[]
    for q in questions:
        q_answers = request.db_session.query(Complete_answer).filter_by(incomp_test=incomplete_test,question=q).all()
        q_points = q.points
        list=[q, q_answers,q_points]
        questions_and_answers.append(list)
    if request.userid is None:
        raise HTTPForbidden
        return HTTPForbidden('Pre prístup je nutné sa prihlásiť')

    if request.userid is not incomplete_test.user_id:
        raise HTTPUnauthorized
        return HTTPUnauthorized('Nie je to tebou vytvorený test')

    return {'incomplete_test':incomplete_test,'questions_and_answers':questions_and_answers, 'userid': request.userid}