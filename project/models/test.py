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
        email: User email, used as a login, so it's must be unique
        password: User Password
        active: Indicates, whether user-account is active
        games: relationship to table Game
    """
    __tablename__ = 'test'
    id = Column(Integer, primary_key=True) 
    name = Column(String(200), nullable=False)
    description = Column(String(500))
    password = Column(String(20))
    date_crt = Column(DateTime)
    date_mdf = Column(DateTime)
    user_id = Column(Integer, ForeignKey('uzer.id'), index=True)
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
        """Returns representative object of class User.
        """
        return "Test<{name}>".format(name=self.name)
