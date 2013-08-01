from sqlalchemy import (
    Column,
    Integer,
    String,
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

class Test(Base):
    """Database table User.

    Attributes:
        id: Identificator of object
        name: name of the test
        description: short description of the test and its question, can be used as Instructions for the user
        password: test password - not currently implemented - babotka for now
        date_crt:date when the test was created by admin
        date_mdf:date when the test was modified - added/deleted or question, changed desc.
        share_token: unique number to serve as a access token to a test
        user: relationship to table User
    """
    __tablename__ = 'test'
    id = Column(Integer, primary_key=True) 
    name = Column(String(200), nullable=False)
    description = Column(String(500))
    password = Column(String(20))
    date_crt = Column(DateTime)
    date_mdf = Column(DateTime)
    share_token = Column(String(30))
    user_id = Column(Integer, ForeignKey('user.id'), index=True)
    user = relationship('User', backref=backref("tests", cascade="all, delete-orphan"))

    def __init__(self, name, description, password, date_crt, date_mdf, user):
        """Initialization of class.
        """
        self.name = name
        self.description = description
        self.password = password
        self.date_crt = date_crt
        self.date_mdf = date_mdf
        self.user = user

    def __repr__(self):
        """Returns representative object of class Test.
        """
        return "Test<{name}>".format(name=self.name)
