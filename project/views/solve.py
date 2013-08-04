
#{{{
import datetime

from pyramid.view import (
    view_config,
    )
from pyramid.httpexceptions import (
    HTTPException,
    HTTPFound,
    HTTPForbidden,
    HTTPUnauthorized
    )

from ..models.user import (
    User,
    )
from ..models.test import (
    Test,
    )
from ..models.answer import (
    Answer,
    )
from ..models.incomplete_test import (
    Incomplete_test
)
from ..models.complete_answer import (
    Complete_answer,
)
from ..models.question import (
    Question,
)

#}}}

@view_config(route_name='solve', request_method='GET', renderer='project:templates/solve.mako')
def view_question(request):
    try:
        test_token = request.matchdict['token']
        test = request.db_session.query(Test).filter_by(share_token=test_token).one()
        if request.db_session.query(Incomplete_test).filter_by(test=test,user_id=request.userid):
            raise HTTPException
    except HTTPException:

        return HTTPFound(request.route_path('dashboard'))

    return {'test':test}

@view_config(route_name='solve', request_method='POST', renderer='project:templates/solve.mako')
def submit_test(request):
    POST = request.POST
    test_token = request.matchdict['token']
    test = request.db_session.query(Test).filter_by(share_token=test_token).one()
    if test is None:
        raise HTTPException
        return HTTPException('Neexistujuci test')

    user_id = request.userid
    user = request.db_session.query(User).filter_by(id=user_id).first()

    date_crt = datetime.datetime.now()
    date_mdf = datetime.datetime.now()

    incomplete_test = Incomplete_test(date_crt, date_mdf, user, test)

    complete_answers = POST.getall('user_answer')
    q_number=0
    for ans in complete_answers:
        q_number+=1
        question = request.db_session.query(Question).filter_by(test_id=test.id,number=q_number).one()
        correct_answer = request.db_session.query(Answer).filter_by(question_id=question.id,correct=1).one()
        complete_answer=Complete_answer(ans,0,incomplete_test,correct_answer,question)
        if ((question.qtype is 'S') and (ans == correct_answer.text)):
            complete_answer.correct=1
        request.db_session.add(complete_answer)
    request.db_session.add(incomplete_test)

    request.db_session.flush()
    return HTTPFound(request.route_path('dashboard'))

@view_config(route_name='solved_test', request_method='GET', renderer='project:templates/solved_test.mako')
def show_solved_test(request):
    POST = request.POST

    incomplete_test_id = request.matchdict['incomplete_test_id']
    incomplete_test = request.db_session.query(Incomplete_test).filter_by(id=incomplete_test_id).one()
    test = request.db_session.query(Test).filter_by(id=incomplete_test.test_id).one()
    complete_answers = request.db_session.query(Complete_answer).filter_by(incomp_test=incomplete_test).all()
    questions=[a.question for a in complete_answers]
    user_answers=[a for a in complete_answers]
    questions_and_answers =zip(questions,user_answers)
    if request.userid is None:
        raise  HTTPForbidden
        return  HTTPForbidden('Pre prístup je nutné sa prihlásiť')

    if request.userid is not test.user_id:
        raise  HTTPUnauthorized
        return  HTTPUnauthorized('Nie je to tebou vytvorený test')

    return {'incomplete_test':incomplete_test,'questions_and_answers':questions_and_answers}




