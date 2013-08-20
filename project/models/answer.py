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
    """Database table Answer.

    Attributes:
        id: Identificator of object
        text: Text of the answer
        correct: 1 - correct answer for question
                0 - incorrect answer as defined by admin
        question_id: FK to question table
        question: relationship to table question - object
    """
    __tablename__ = 'answer'
    id = Column(Integer, primary_key=True) 
    text = Column(String(500))
    correct = Column(Boolean)
    question_id = Column(Integer, ForeignKey('question.id'), index=True)
    question = relationship('Question', backref=backref("answers",order_by=id.desc(), cascade="all, delete-orphan"))

    def __init__(self, text, correct, question):
        """Initialization of class.
        """
        self.text = text
        self.correct = str(correct)
        self.question = question

    def __repr__(self):
        """Returns representative object of class Answer.
        """
        return "Answer<{id}>".format(id=self.id)
    def __eq__(self, other):
        return self.id == other.id