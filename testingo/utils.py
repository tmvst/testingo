import re
def valid_email(email):
    return True if re.match("[^@]+@[^@]+\.[^@]+", email) else False
