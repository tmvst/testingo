from pyramid.config import Configurator
from sqlalchemy import create_engine

import os

from pyramid.events import (
    ContextFound,
    BeforeRender,
    )

from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.security import (
    authenticated_userid,
    Allowed,
    Denied,
    has_permission,
    )

from pyramid_mailer.mailer import Mailer

from sqlalchemy import engine_from_config

from .models import (
    DBSession,
    Base,
    )

from .models.user import User

from .helpers import attr
from project import helpers

from .authenticator import Authenticator

import random
import os

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """

    def add_renderer_globals(event):
        """Adding renderer globals to event.
        """
        request = event['request']
        event['attr'] = attr
        event['user'] = request.user
        event['h'] = helpers

    def prepare_request(event): #{{{
        """Add some additional information to the request object.
        """
        request = event.request
        request.settings = settings
        request.db_session = DBSession
        request.userid = authenticated_userid(request)

        if request.userid is not None:
            request.user = request.db_session.query(User).\
                    filter(User.id == request.userid).\
                    first()
        else:
            request.user = None

        if request.registry and 'mailer' in request.registry:
            mailer = request.registry['mailer']
            request.mailer = mailer

        request.authenticator = Authenticator(request.db_session, request)

    # Settings
    authn_policy = AuthTktAuthenticationPolicy(secret=settings['auth_secret_key']) 
    authz_policy = ACLAuthorizationPolicy()
    #engine = engine_from_config(settings, 'sqlalchemy.')
    #engine = create_engine('postgresql://tomasvestenicky:heslo@localhost:5432/testingo_dev')
    engine = create_engine(os.environ["DATABASE_URL"])
    #engine = create_engine('postgresql://adam:1234@localhost:5432/testingo_dev')
    DBSession.configure(bind=engine)
    Base.metadata.bind = engine

    config = Configurator(settings=settings)
    config.add_subscriber(add_renderer_globals, BeforeRender)
    config.add_subscriber(prepare_request, ContextFound)
    config.registry['mailer'] = Mailer.from_settings(settings)

    config.set_authentication_policy(authn_policy)
    config.set_authorization_policy(authz_policy)

    config.add_static_view('static', 'static', cache_max_age=3600)

    # Routes
    config.add_route('home', '/')
    config.add_route('register', '/registracia/')
    config.add_route('register_success', '/uspesna-registracia/{user_id}/')
    config.add_route('login', '/login/')
    config.add_route('logout', '/logout/')
    config.add_route('beg_for_recovery', '/stratene-heslo/')
    config.add_route('new_password', '/nove-heslo/{user_id}/{code}/')
    config.add_route('get_user_info', '/get-user-info/{user_id}/')
    config.add_route('recovery_small_success', '/stratene-heslo-uspech/')
    config.add_route('dashboard', '/dashboard')
    config.add_route('newtest', '/newtest')
    #config.add_route('newquestion', '/test/{test_id}/newquestion')
    config.add_route('showtest', '/test/{test_id}')
    config.add_route('getlist', '/getlist')
    config.add_route('showquestion', '/test/{test_id}/question/{question_id}')
    config.add_route('solve', 'solve/{token}')
    config.add_route('solved_test','solved_test/{incomplete_test_id}')
    config.add_route('filled_test','filled_test/{incomplete_test_id}')

    config.add_route('newquestion', '/test/{test_id}/newquestion/{question_type}/')

    config.add_route('newquestion_s','/test/{test_id}/new-phrase-question') # frazova
    config.add_route('newquestion_c','/test/{test_id}/new-checkbox-question') # checkbox
    config.add_route('newquestion_o','/test/{test_id}/new-open-question') # open
    config.add_route('newquestion_r','/test/{test_id}/new-radio-question') # radio

    config.scan()
    random.seed()

    return config.make_wsgi_app()
