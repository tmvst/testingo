#{{{
import random

from pyramid.view import (
    view_config,
    notfound_view_config,
    forbidden_view_config,
    )
from pyramid.httpexceptions import (
    HTTPNotFound,
    HTTPFound,
    HTTPForbidden,
    )
from pyramid_mailer.message import (
    Message,
    )

from ..models.user import (
    User,
    )
from ..utils import valid_email
from ..authenticator import (
    WrongPasswordError,
    NonExistingUserError,
    )
#}}}

@notfound_view_config(append_slash=True)
def notfound(request):
    return HTTPNotFound("Hľadaná stránka neexistuje")


@view_config(route_name='home', renderer='project:templates/home.mako')
def main_page_view(request):
    """Shows a Home Page.
    """
    return {
        'page_title': 'HomePage',
        'logged': (request.userid is not None)
    }


@view_config(route_name='dashboard', request_method='GET', renderer='project:templates/dashboard.mako')
def dashboard(request):
    """Shows dashboard.
    """

    if request.userid == None:
        raise HTTPForbidden

    uid = request.userid
    user = request.db_session.query(User).filter_by(id=uid).one()

    return {'errors':[], 'tests': user.tests,'userid':uid}


@view_config(route_name='getlist', request_method='GET', renderer='project:templates/list_respondents.mako')
def get_list(request):

    return {}





