
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
import re

#}}}

@view_config(route_name='solve', request_method='GET', renderer='project:templates/solve.mako')
def view_question(request):

    test_token = request.matchdict['token']
    test = request.db_session.query(Test).filter_by(share_token=test_token).one()
    return {'test':test, 'token':test_token}

@view_config(route_name='solve', request_method='POST')
def submit_test(request):
    json = request.json_body
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

    user_answers_C= json['user_answers_C']
    user_answers_S = json['user_answers_S']
    uac=user_answers_C.replace('&','').split('=')
    uac.remove('')

    # here we go through each S answer that user has filled, we substring the question's id from the field name
    # user_answerXX and get its correct answer
    # then we compare whether user answer is equal to it if so , we change the complete answer object attribute
    # correct to 1 and save it do DB
    for ans in user_answers_S:
        answer_text=ans['value']
        question = request.db_session.query(Question).filter_by(id=ans['name'][11:]).one()
        correct_answer = request.db_session.query(Answer).filter_by(question_id=question.id,correct=1).one()
        complete_answer=Complete_answer(answer_text,0,incomplete_test,correct_answer,question)
        if answer_text == correct_answer.text:
            complete_answer.correct=1
        request.db_session.add(complete_answer)

    # now the same shit for C question, we get the answer's id directly from checkbox's name
    # answer_text as a attribute of db object and model complete_answer's gonna be either
    # 0-user uchecked,
    # 1 -user checked

    questions_c=request.db_session.query(Question).filter_by(test=test,qtype='C').all()

    for q in questions_c:
        answers_c= q.answers
        for ans in answers_c:
            correct_answer=request.db_session.query(Answer).filter_by(id=ans.id).one()
            if str('check'+str(ans.id)) in uac and ans.correct == 1:
                uac.remove(str('check'+str(ans.id)))
                complete_answer=Complete_answer(str(1),1,incomplete_test,correct_answer,q)
                request.db_session.add(complete_answer)
            elif str('check'+str(ans.id))  in uac and ans.correct == 0:
                complete_answer=Complete_answer(str(1),0,incomplete_test,correct_answer,q)
                request.db_session.add(complete_answer)
            elif str('check'+str(ans.id)) not in uac and ans.correct == 1:
                complete_answer=Complete_answer(str(0),0,incomplete_test,correct_answer,q)
                request.db_session.add(complete_answer)
            elif str('check'+str(ans.id)) not in uac and ans.correct == 0:
                complete_answer=Complete_answer(str(0),1,incomplete_test,correct_answer,q)
                request.db_session.add(complete_answer)

            request.db_session.add(incomplete_test)
            request.db_session.flush()
    return HTTPFound(request.route_path('dashboard'))

@view_config(route_name='solved_test', request_method='GET', renderer='project:templates/solved_test.mako')
def show_solved_test(request):

    incomplete_test_id = request.matchdict['incomplete_test_id']
    incomplete_test = request.db_session.query(Incomplete_test).filter_by(id=incomplete_test_id).one()
    test = request.db_session.query(Test).filter_by(id=incomplete_test.test_id).one()
    questions = test.questions
    questions_and_answers=[]
    for q in questions:
        q_answers = request.db_session.query(Complete_answer).filter_by(incomp_test=incomplete_test,question=q).all()
        q_points = q.points
        list=[q, q_answers,q_points]
        questions_and_answers.append(list)
    if request.userid is None:
        raise HTTPForbidden
        return HTTPForbidden('Pre prístup je nutné sa prihlásiť')

    if request.userid is not test.user_id:
        raise HTTPUnauthorized
        return HTTPUnauthorized('Nie je to tebou vytvorený test')

    return {'incomplete_test':incomplete_test,'questions_and_answers':questions_and_answers}




