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

class Answer(Base):
    """Database table User.

    Attributes:
        id: Identificator of object
        email: User email, used as a login, so it's must be unique
        password: User Password
        active: Indicates, whether user-account is active
        games: relationship to table Game
    """
    __tablename__ = 'answer'
    id = Column(Integer, primary_key=True) 
    text = Column(String(500))
    correct = Column(Boolean)
    question_id = Column(Integer, ForeignKey('question.id'), index=True)
    question = relationship('Question', backref=backref("answers", cascade="all, delete-orphan"))

    def __init__(self, text, correct, question):
        """Initialization of class.
        """
        self.text = text
        self.correct = correct
        self.question = question

    def __repr__(self):
        """Returns representative object of class User.
        """
        return "Answer<{text}>".format(text=self.text)
