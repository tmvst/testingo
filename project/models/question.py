from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
    Float,
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
        number: order of the question in test
        text: text of the question
        points; value in points
        qtype: type of question - phrase,open,multiple,checklist,-- to be defined later
        test: relationship to table Test
    """
    __tablename__ = 'question'
    id = Column(Integer, primary_key=True) 
    number = Column(Integer)
    text = Column(String(500))
    points = Column(Float)
    qtype = Column(String(5))
    test_id = Column(Integer, ForeignKey('test.id'), index=True)
    test = relationship('Test', backref=backref("questions",order_by=id.asc(),cascade="all, delete-orphan"))

    def __init__(self, number, text, points, qtype, test):
        """Initialization of class.
        """
        self.number = number
        self.text = text
        self.points = points
        self.qtype = qtype
        self.test = test

    def __repr__(self):
        """Returns representative object of class Question.
        """
        return "Question<{number}>".format(number=self.number)
