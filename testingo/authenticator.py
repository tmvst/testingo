from .models.user import User

from pyramid.security import (remember, forget)

class Authenticator:

    def __init__(self, session, request):
        self._session = session
        self._request = request

    def login(self, email, password):
        """Logs user into a system.
        
        Args:
            email: User's email
            password: User's password
        """

        user = self._session.query(User).filter_by(email=email).first()
        
        if user is None: raise NonExistingUserError('This user doesn\'t exist.')
        if (user.password != password): raise WrongPasswordError('Passwords don\'t match.') 
        
        return (
            remember(self._request, user.id),
            user,
            )
                             
    def logout(self):
        return forget(self._request)
        
class AuthenticationError(Exception):
    pass        
class WrongPasswordError(AuthenticationError):
    pass
class NonExistingUserError(AuthenticationError):
    pass
