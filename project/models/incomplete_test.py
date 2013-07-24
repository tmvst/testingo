from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    Float,
    Boolean,
    Table,
    ForeignKey,
    Enum,
    Float,
    DateTime,
    )

from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
    )

from sqlalchemy.ext.hybrid import (
    Comparator, 
    hybrid_property,
    )

from sqlalchemy.orm import (
    validates,
    relationship,
    scoped_session,
    sessionmaker,
    backref
    )

from bcrypt import (hashpw, gensalt)

from ..utils import valid_email
from . import Base

class ValidationError(Exception):
    pass

class Incomplete_test(Base):
    """Database table User.

    Attributes:
        id: Identificator of object
        email: User email, used as a login, so it's must be unique
        password: User Password
        active: Indicates, whether user-account is active
        games: relationship to table Game
    """
    __tablename__ = 'incomplete_test'
    id = Column(Integer, primary_key=True) 
    date_crt = Column(DateTime)
    date_mdf = Column(DateTime)
    user_id = Column(Integer, ForeignKey('uzer.id'), index=True)
    user = relationship('User', backref=backref("incomplete_tests", cascade="all, delete-orphan"))
    test_id = Column(Integer, ForeignKey('test.id'), index=True)
    test = relationship('Test', backref=backref("incomplete_tests", cascade="all, delete-orphan"))

    def __init__(self, date_crt, date_mdf, user, test):
        """Initialization of class.
        """
        self.date_crt = date_crt
        self.date_mdf = date_mdf
        self.user = user
        self.test = test

    def __repr__(self):
        """Returns representative object of class User.
        """
        return "Incomplete_Test<{test_id}>".format(test_id=self.test.id)