from sqlalchemy import (
    Column,
    Integer,
    String,
    )

from sqlalchemy.orm import (
    validates,
    relationship,
    backref
    )

from ..utils import valid_email
from . import Base

class ValidationError(Exception):
    pass

class Visitor(Base):
    """Database table Visitor.

    Attributes:
        id: Identificator of object
        email: User email, used as a login, so it's must be unique
    """
    __tablename__ = 'vizitor'
    id = Column(Integer, primary_key=True) 
    email = Column(String(50), unique=True)
    user = relationship('User', backref=backref("visitor", cascade="all, delete-orphan"))
    @validates('email')
    def validate_email(self, key, address):
        if not valid_email(address):
            raise InvalidEmailError('You must input correct email.')
        return address

    def __init__(self, email):
        """Initialization of class.
        """
        self.email = email

    def __repr__(self):
        """Returns representative object of class User.
        """
        return "User<{email}>".format(email=self.email)


class InvalidEmailError(ValidationError):
    pass

