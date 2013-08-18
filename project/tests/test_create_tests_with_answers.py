from pyramid import testing
from mock import Mock
from random import randrange
import random

from ..models.user import User

from . import DatabaseTestCase
from ..views.test import (
        newtest_submission,
        )
from ..views.question import (
        create_question,
        )

ul = User('user1@gmail.com', 'user1_pass')
request = testing.DummyRequest() 
class TestCreateTests(DatabaseTestCase):

    def set_up(self):
        request = testing.DummyRequest()                #ako do Dummy zakomponovať user-a
        request.db_session = self.db_session
        request.route_url = Mock()
        u1=User('user1@gmail.com', 'user1_pass')
        self.u1=u1
        request.userid = ul.id
        request.db_session.add_all([u1])
        request.db_session.commit()
        self.request=request

    def tear_down(self):
        pass

    def test_create(self):
        for i in range(10):
            self.request.POST={
                'name': 'test'+str(i),
                'description': 'Description'+str(i),
            }
            response=newtest_submission(self.request)
            print('test'+str(i))

            for j in range(5):
                qtype = random.sample(('S', 'C', 'R', 'O'), 1)
                self.request.POST={
                'text': 'test '+str(i)+'+ question '+str(j),
                'points': randrange(8),
                'qtype': qtype
                }
                if qtype is 'R':
                    r_question_post(self.request)
                elif qtype is 'S':
                    s_question_post(self.request)
                elif qtype is 'O':
                    o_question_post(self.request)
                elif qtype is 'C':
                    c_question_post(self.request)
                print('Otazka c.' +str(j)+ str(qtype))

        
