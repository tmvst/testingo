#{{{


from pyramid.view import (
    view_config,
    notfound_view_config,

    )
from pyramid.httpexceptions import (

    HTTPForbidden,
    HTTPUnauthorized
    )

from ..models.user import (
    User,
    )
from ..models.incomplete_test import (
    Incomplete_test,
    )

from ..models.test import (
    Test
    )

#}}}
@view_config(context=HTTPUnauthorized, renderer='project:templates/errors/unauthorized.mako')

@notfound_view_config(renderer='project:templates/errors/notfound.mako')
def not_found(request):
    if request.userid == None:
        raise HTTPForbidden

    uid = request.userid
    user = request.db_session.query(User).filter_by(id=uid).one()
    tests=user.tests
    return {'errors':[], 'tests': tests,'userid':uid}


    return {}
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
    tests=user.tests
    alls=request.db_session.query(Incomplete_test).join(Test).filter_by(Test.user.id=uid).all()
    print(alls)
    tests_in_activity=[]

    return {'errors':[], 'tests': tests,'userid':uid,'tests_in_activity':tests_in_activity}




@view_config(route_name='getlist', request_method='GET', renderer='project:templates/list_respondents.mako')
def get_list(request):

    return {}





