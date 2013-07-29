import unittest
from pyramid import testing
from ..models.user import User
from ..views.views import (
        dashboard,
        )

class MyTest(unittest.TestCase):
    def setUp(self):
        self.config = testing.setUp()

    def tearDown(self):
        testing.tearDown()

    def test_view_dashboard_forbidden(self):
        from pyramid.httpexceptions import HTTPForbidden
        request = testing.DummyRequest()
        request.context = testing.DummyResource()
        request.userid = None
        self.request = request
        #print(response,type(response))
        self.assertRaises(HTTPForbidden,dashboard,request)

