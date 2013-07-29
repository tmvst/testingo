from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    Enum,
    )

from sqlalchemy.orm import (
    relationship,
    backref
    )

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
    number = Column(String(50))
    text = Column(String(500))
    points = Column(Integer)
    qtype = Column(Enum)
    test_id = Column(Integer, ForeignKey('test.id'), index=True)
    test = relationship('Test', backref=backref("tests", cascade="all, delete-orphan"))

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
