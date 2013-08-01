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
from ..models.incomplete_test import (
    Incomplete_test
)
from ..models.complete_answer import (
    Complete_answer,
)
from ..models.question import (
    Question,
)

@view_config(route_name='filled_test', request_method='GET', renderer='project:templates/filled_test.mako')
def show_filled_test(request):
    POST = request.POST

    incomplete_test_id = request.matchdict['incomplete_test_id']
    incomplete_test = request.db_session.query(Incomplete_test).filter_by(id=incomplete_test_id).one()
    test = request.db_session.query(Test).filter_by(id=incomplete_test.test_id).one()
    complete_answers = request.db_session.query(Complete_answer).filter_by(incomp_test=incomplete_test).all()
    questions=[a.question for a in complete_answers]
    user_answers=[a for a in complete_answers]
    questions_and_answers =zip(questions,user_answers)
    if request.userid is None:
        raise  HTTPForbidden
        return  HTTPForbidden('Pre prístup je nutné sa prihlásiť')

    if request.userid is not test.user_id:
        raise  HTTPUnauthorized
        return  HTTPUnauthorized('Nie je to tebou vyplnený test')

    return {'incomplete_test':incomplete_test,'questions_and_answers':questions_and_answers}