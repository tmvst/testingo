#{{{
from pyramid.view import (
    view_config,
    )

from pyramid.httpexceptions import (
    HTTPException,
    HTTPFound,
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

@view_config(route_name='solve', request_method='GET', renderer='project:templates/solve.mako')
def view_question(request):
    test_token = request.matchdict['token']
    test = request.db_session.query(Test).filter_by(share_token=test_token).one()

    if test is None:
        raise HTTPException
        return HTTPException('Neexistujuci test')

    return {'test':test}

