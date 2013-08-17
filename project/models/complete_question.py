from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    Float
    )

from sqlalchemy.orm import (
    relationship,
    backref
    )

from . import Base

class ValidationError(Exception):
    pass

class CompleteQuestion(Base):
    """
    comment - komentar admina testu po vyhodnoteni otazky a jej odpovedi
            - je aj v inite!
    points - body udelene za uzivatelovu odpoved pre celu otazku dokopy
    """
    __tablename__ = 'complete_question'
    id = Column(Integer, primary_key=True)
    comment = Column(String(500))
    points = Column(Float)
    incomplete_test_id = Column(Integer, ForeignKey('incomplete_test.id'), index=True)
    incomplete_test = relationship('Incomplete_test', backref=backref("complete_questions", cascade="all, delete-orphan"))
    question_id = Column(Integer, ForeignKey('question.id'), index=True)
    question = relationship('Question', backref=backref("complete_question", cascade="all, delete-orphan"))

    def __init__(self, incomplete_test, question):
        """Initialization of class.
        """
        self.incomplete_test = incomplete_test
        self.question = question

    def __repr__(self):
        """Returns representative object of class Complete_Answer.
        """
        return "Complete_answer<{id}>".format(id=self.id)
