# helpers.py

pretty_points = lambda acq_points: int(acq_points) if acq_points.is_integer() else round(acq_points, 1)
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


def pretty_date(time = False):
    """
    Get a datetime object or a int() Epoch timestamp and return a
    pretty string like 'an hour ago', 'Yesterday', '3 months ago',
    'just now', etc
    """
    from datetime import datetime

    now = datetime.now()

    if type(time) is int:
        diff = now - datetime.fromtimestamp(time)
    elif isinstance(time,datetime):
        diff = now - time 
    elif not time:
        diff = now - now

    second_diff = diff.seconds
    day_diff = diff.days

    if day_diff < 0:
        return ''

    if day_diff == 0:
        if second_diff < 10:
            return "pred chvíľou"
        if second_diff < 60:
            return "Pred " + str( int(second_diff) ) + " sekundami"
        if second_diff < 120:
            return "Pred minútou"
        if second_diff < 3600:
            return "Pred " + str( int(second_diff / 60) ) + " minútami"
        if second_diff < 7200:
            return "Pred hodinou"
        if second_diff < 86400:
            return "Pred " + str( int(second_diff / 3600) ) + " hodinami"
    if day_diff == 1:
        return "Včera"
    if day_diff < 7:
        return "Pred " + str( int(day_diff) ) + " dňami"
    if day_diff < 31:
        return "Pred " + str( int(day_diff/7) ) + " týždňami"
    if day_diff < 365:
        return "Pred " + str( int(day_diff/30) ) + " mesiacmi"
    return "Dávno"