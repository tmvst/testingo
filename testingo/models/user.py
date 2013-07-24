from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    Float,
    Boolean,
    Table,
    ForeignKey,
    Enum,
    Float,
    DateTime,
    )

from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
    )

from sqlalchemy.ext.hybrid import (
    Comparator, 
    hybrid_property,
    )

from sqlalchemy.orm import (
    validates,
    relationship,
    scoped_session,
    sessionmaker,
    )

from bcrypt import (hashpw, gensalt)

from ..utils import valid_email
from . import Base

class ValidationError(Exception):
    pass

class MyPassword(Comparator):
    """Hybrid value representing a hashed representation of a word.

    Class is used for comparing string instances to hashed values.
    It can be used only in python code. It can't be used in SQL statements.
    """
    def __init__(self, hash_password):
        if isinstance(hash_password, str):
            self.hash_password = hash_password
        elif isinstance(hash_password, MyPassword):
            self.hash_password = hash_password.hash_password
        else:
            raise TypeError('Wrong argument type passed to MyPassword '
                            '- must be instance of str or MyPassword ('
                            +str(type(hash_password))+')')

    def operate(self, op, other):
        if not isinstance(other, str):
            raise TypeError('You must operate with string instance.')
        #return op(hashpw(other.encode('ascii'), self.hash_password), self.hash_password)
        return op(hashpw(other, self.hash_password), self.hash_password)

    def __clause_element__(self):
        return self.hash_password

    def __str__(self):
        return self.hash_password


class User(Base):
    """Database table User.

    Attributes:
        id: Identificator of object
        email: User email, used as a login, so it's must be unique
        password: User Password
        active: Indicates, whether user-account is active
        games: relationship to table Game
    """
    __tablename__ = 'uzer'
    id = Column(Integer, primary_key=True)
    email = Column(String(50), unique=True)
    _password = Column(String(100), nullable=False)
    fullname = Column(String(100))
    recovery_code = Column(String(100))

    @validates('email')
    def validate_email(self, key, address):
        if not valid_email(address):
            raise InvalidEmailError('You must input correct email.')
        return address

    @hybrid_property
    def password(self):
        """Password getter.
        """
        return MyPassword(self._password)

    @password.setter
    def password(self, value):
        """Password setter.
        """
        #self._password = hashpw(value.encode('ascii'), gensalt())
        self._password = hashpw(value, gensalt())

    def __init__(self, email, password):
        """Initialization of class.
        """
        self.email = email
        self.password = password

    def __repr__(self):
        """Returns representative object of class User.
        """
        return "User<{email}>".format(email=self.email)


class InvalidEmailError(ValidationError):
    pass

