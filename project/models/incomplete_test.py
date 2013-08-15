
from sqlalchemy import (
    Column,
    Integer,
    ForeignKey,
    DateTime,
    )

from sqlalchemy.orm import (
    relationship,
    backref
    )

from . import Base

class ValidationError(Exception):
    pass

class Incomplete_test(Base):
    """Database table User.

    Attributes:
        id: Identificator of object
        date_crt: datetime when the user submitted solved test
        date_mdf: last modification of solving the test ( not currently implemented)
        test: relationship to table Test
        user: relationship to table Answer
    """
    __tablename__ = 'incomplete_test'
    id = Column(Integer, primary_key=True) 
    date_crt = Column(DateTime)
    date_mdf = Column(DateTime)
    user_id = Column(Integer, ForeignKey('user.id'), index=True)
    user = relationship('User', backref=backref("incomplete_tests", cascade="all, delete-orphan"))
    test_id = Column(Integer, ForeignKey('test.id'), index=True)
    test = relationship('Test', backref=backref("incomplete_tests",order_by=date_crt.desc(), cascade="all, delete-orphan"))

    def __init__(self, date_crt, date_mdf, user, test):
        """Initialization of class.
        """
        self.date_crt = date_crt
        self.date_mdf = date_mdf
        self.user = user
        self.test = test

    def __repr__(self):
        """Returns representative object of class Incomplete_test.
        """
        return "Incomplete_Test<{test_id}>".format(test_id=self.test.id)
