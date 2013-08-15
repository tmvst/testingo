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
        text: Text of the answer
        correct: automatically assigned by comparing to correct answer defined by admin
                if it is an open answer, then judged by user
        question_id: FK to question table
        question: relationship to table question - object
        answer_id: FK to answer table - to the admin defined answer
        answer: relationship to table answer
    """
    __tablename__ = 'complete_answer'
    id = Column(Integer, primary_key=True) 
    text = Column(String(500))
    correct = Column(Boolean)
    incomp_test_id = Column(Integer, ForeignKey('incomplete_test.id'), index=True)
    incomp_test = relationship('Incomplete_test', backref=backref("complete_answers", cascade="all, delete-orphan"))
    answer_id = Column(Integer, ForeignKey('answer.id'), index=True)
    answer = relationship('Answer', backref=backref("complete_answers", cascade="all, delete-orphan"))
    question_id = Column(Integer, ForeignKey('question.id'), index=True)
    question = relationship('Question', backref=backref("complete_answers", cascade="all, delete-orphan"))

    def __init__(self, text, correct, test, answer, question):
        """Initialization of class.
        """
        self.text = text
        self.correct = correct
        self.incomp_test = test
        self.answer = answer
        self.question = question
        
    def __repr__(self):
        """Returns representative object of class Complete_Answer.
        """
        return "Complete_answer<{id}>".format(id=self.id)
