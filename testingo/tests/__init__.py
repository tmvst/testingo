import unittest
import inspect

import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from ..models import set_up_tables

current_filedir_path = os.path.dirname(__file__)
engine_path = 'sqlite:///' + current_filedir_path + '/test.db'
engine = create_engine(engine_path)
set_up_tables(engine)

class BaseTestCase(unittest.TestCase):
    """Base class for testing without database use.
    """
    def setUp(self):
        """Calls child's set_up function.
        """
        if hasattr(self, 'set_up'):
            self.set_up()
            
    def tearDown(self):
        """Calls child's tear_down function.
        """
        if hasattr(self, 'tear_down'):
            self.tear_down() 


        
class DatabaseTestCase(BaseTestCase):
    """Base class for testing database.
    """
        
    def setUp(self):
        """Prepares session objects, begins transaction and calls child's set_up method.
        """
        connection = engine.connect()

        self.trans = connection.begin()
        Session = sessionmaker(bind=connection)
        self.db_session = Session()
        
        super().setUp()
            
    def tearDown(self):
        """Calls child's tear_down method and rollbacks the transaction.
        """    
        # rollback - everything that happened with the
        # Session above (including calls to commit())
        # is rolled back.
        super().tearDown()
        self.trans.rollback()
        self.db_session.close()
        
        
        
class ClassMock():
    """Class used for mocking other classes.
    """
    def __call__(self, *args, **kwargs):
        """Create fake constructor that returns Mock object when invoked.
        """
        instance = Mock()
        instance._original_class = self._original_class
        instance._init_parameters = inspect.getcallargs(self._original_class.__init__, self, *args, **kwargs)
        del instance._init_parameters['self']
        return instance

    
    def __init__(self, original_class):
        """Initialization of the class.
        """
        self._original_class = original_class if not isinstance(original_class, ClassMock) else original_class._original_class

