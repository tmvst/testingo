from pyramid.view import (
    view_config,
    )
from pyramid.httpexceptions import (
    HTTPForbidden,
    HTTPUnauthorized,
    HTTPNotFound
    )

from ..models.incomplete_test import (
    Incomplete_test
)

@view_config(route_name='filled_test', request_method='GET', renderer='project:templates/filled_test.mako')
def show_filled_test(request):
    #moznost premenit vracany objekt na pole dictov a nie pole poli, zprehladnilo by to mako  a bolo by hned jasne aj
    # cudzim ludom,kde co a ako vypisujeme, nevyhodou je , ze dict je pomalsi aj ked asi len o 0.0000001% ako pole

    incomplete_test_id = request.matchdict['incomplete_test_id']
    try:
        incomplete_test = request.db_session.query(Incomplete_test).filter_by(id=incomplete_test_id).one()
    except:
         raise HTTPNotFound
    if request.userid is None:
        raise HTTPForbidden

    if request.userid is not incomplete_test.user_id:
        raise HTTPUnauthorized
    questions = incomplete_test.complete_questions
    questions_and_answers=[]
    sum_points = float(0)
    for q in questions:
        q_answers = q.complete_q_complete_answers
        acq_points =  sum(float(a.points) for  a in q_answers)
        sum_points += acq_points
        list=[q, q_answers,acq_points]
        questions_and_answers.append(list)
    return {'incomplete_test':incomplete_test,'questions_and_answers':questions_and_answers, 'userid': request.userid, 'sum_points': sum_points}

