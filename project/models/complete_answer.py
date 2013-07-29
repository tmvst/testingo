from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    ForeignKey,
    )

from sqlalchemy.orm import (
    relationship,
    backref
    )

from . import Base

class ValidationError(Exception):
    pass

class Complete_answer(Base):
    """Database table User.

    Attributes:
        id: Identificator of object
        email: User email, used as a login, so it's must be unique
        password: User Password
        active: Indicates, whether user-account is active
        games: relationship to table Game
    """
    __tablename__ = 'complete_answer'
    id = Column(Integer, primary_key=True) 
    text = Column(String(500))
    correct = Column(Boolean)
    incomp_test_id = Column(Integer, ForeignKey('incomplete_test.id'), index=True)
    incomp_test = relationship('Incomplete_test', backref=backref("complete_answers", cascade="all, delete-orphan"))
    answer_id = Column(Integer, ForeignKey('answer.id'), index=True)
    answer = relationship('Answer', backref=backref("complete_answers", cascade="all, delete-orphan"))

    def __init__(self, text, correct, test, answer):
        """Initialization of class.
        """
        self.text = text
        self.correct = correct
        self.incomp_test = test
        self.answer = answer
        
    def __repr__(self):
        """Returns representative object of class User.
        """
        return "Complete_answer<{text}>".format(text=self.text)
