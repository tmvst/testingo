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
    )

from bcrypt import (hashpw, gensalt)

from ..utils import valid_email
from . import Base

class ValidationError(Exception):
    pass

class Question(Base):
    """Database table User.

    Attributes:
        id: Identificator of object
        email: User email, used as a login, so it's must be unique
        password: User Password
        active: Indicates, whether user-account is active
        games: relationship to table Game
    """
    __tablename__ = 'question'
    id = Column(Integer, primary_key=True) 
    number = Column(String(50), unique=True, nullable=False)
    text = Column(String(500))
    points = Column(Integer)
    qtype = Column(Enum)
    test_id = Column(Integer, ForeignKey('user.id'), index=True)
    test = relationship('Test', backref=backref("questions", cascade="all, delete-orphan"))

    def __init__(self, number, text, points, qtype, test):
        """Initialization of class.
        """
        self.number = number
        self.text = text
        self.points = points
        self.qtype = qtype
        self.test = test

    def __repr__(self):
        """Returns representative object of class User.
        """
        return "Question<{number}>".format(number=self.number)