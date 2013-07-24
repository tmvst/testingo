# helpers.py

import string

def attr(attribute, value):
    """
    Helper for mako templates, creates attribute for html element
    Args:
        attribute:
            string with name of required attribute
        value:
            either a string of list of values for attribute
            Example:
                "<div ${attr('id', 'footer')}>" => "<div id="footer">"
    """
    if isinstance(value, str):
        result = attribute + '=' + '"' + value + '"'
    elif len(value) != 0:
        result = attribute + '=' + '"' + " ".join(value) + '"'
    else:
        result = ""
    return result

def shortify(string, max_length):
    if len(string) > max_length:
        return string[:max_length - 3] + '...'
    else:
        return string
