
#{{{
import datetime

from sqlalchemy import func

from pyramid.view import (
    view_config,
    )
from pyramid.httpexceptions import (
    HTTPNotFound,
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
from ..models.complete_question import (
    CompleteQuestion,
    )

#}}}
@view_config(route_name='unavailable_test', request_method='GET', renderer='project:templates/errors/unavailable_test.mako')
def view_test(request):
    test = request.db_session.query(Test).filter_by(id=request.matchdict['test_id']).one()
    return {'test':test}  

@view_config(route_name='solve', request_method='GET', renderer='project:templates/solve.mako')
def view_question(request):
    if request.userid:
        test_token = request.matchdict['token']
        test = request.db_session.query(Test).filter_by(share_token=test_token).one()

        time = datetime.datetime.now()
        if test.start_time and test.end_time:
            if ((time < test.start_time) or (time > test.end_time)):
                raise HTTPFound(request.route_path('unavailable_test', test_id=test.id))
            else:
                return {'test':test, 'token':test_token}
        else:
            return {'test':test, 'token':test_token}
    else:
        raise HTTPForbidden

@view_config(route_name='solve', request_method='POST')
def submit_test(request):
    json = request.json_body
    test_token = request.matchdict['token']
    try:
        test = request.db_session.query(Test).filter_by(share_token=test_token).one()
    except:
        raise HTTPNotFound

    if request.userid is None:
        raise HTTPForbidden

    user_id = request.userid
    user = request.db_session.query(User).filter_by(id=user_id).first()

    date_crt = datetime.datetime.now()
    date_mdf = datetime.datetime.now()

    incomplete_test = Incomplete_test(date_crt, date_mdf, user, test)

    user_answers_C= json['user_answers_C']
    user_answers_S = json['user_answers_S']
    user_answers_R = json['user_answers_R']
    user_answers_O = json['user_answers_O']
    uac=user_answers_C.replace('&','').split('=')
    uac.remove('')
    uar=user_answers_R.split('&')

    # here we go through each S answer that user has filled, we substring the question's id from the field name
    # user_answerXX and get its correct answer
    # then we compare whether user answer is equal to it if so , we change the complete answer object attribute
    # correct to 1 and save it do DB

    questions_s=request.db_session.query(Question).filter_by(test=test,qtype='S').all()

    for q in questions_s:
        answers_s= q.answers
        complete_question = CompleteQuestion(incomplete_test,q)
        complete_question.date_crt = datetime.datetime.now()
        complete_question.date_mdf = datetime.datetime.now()
        for ans in answers_s:
            correct_answer = request.db_session.query(Answer).filter_by(correct=str(1),id=ans.id).one()
            for ua in user_answers_S:
                right_u_answer={}
                if ua['name']==str(str(q.id)+'&'+str(ans.id)):
                    right_u_answer=ua
                    user_answers_S.remove(right_u_answer)
                    break
            complete_answer=Complete_answer(right_u_answer['value'],str(0),incomplete_test,correct_answer,q,complete_question)
            if complete_answer.text == correct_answer.text:
                complete_answer.correct=str(1)
                complete_answer.points=q.points/len(answers_s)
            else:
                complete_answer.points=0
            request.db_session.add(complete_answer)
        request.db_session.add(complete_question)

    # now the same shit for C question, we get the answer's id directly from checkbox's name
    # answer_text as a attribute of db object and model complete_answer's gonna be either
    # 0-user uchecked,
    # 1 -user checked

    questions_c=request.db_session.query(Question).filter_by(test=test,qtype='C').all()

    for q in questions_c:
        answers_c= q.answers
        complete_question = CompleteQuestion(incomplete_test,q)
        complete_question.date_crt = datetime.datetime.now()
        complete_question.date_mdf = datetime.datetime.now()
        for ans in answers_c:
            correct_answer=request.db_session.query(Answer).filter_by(id=ans.id).one()
            if str('check'+str(ans.id)) in uac and ans.correct :
                uac.remove(str('check'+str(ans.id)))
                complete_answer=Complete_answer(str(1),str(1),incomplete_test,correct_answer,q,complete_question)
                complete_answer.points=q.points/len(answers_c)
                request.db_session.add(complete_answer)
            elif str('check'+str(ans.id))  in uac and not ans.correct:
                complete_answer=Complete_answer(str(1),str(0),incomplete_test,correct_answer,q,complete_question)
                complete_answer.points=0
                request.db_session.add(complete_answer)
            elif str('check'+str(ans.id)) not in uac and ans.correct:
                complete_answer=Complete_answer(str(0),str(0),incomplete_test,correct_answer,q,complete_question)
                complete_answer.points=0
                request.db_session.add(complete_answer)
            elif str('check'+str(ans.id)) not in uac and not ans.correct:
                complete_answer=Complete_answer(str(0),str(1),incomplete_test,correct_answer,q,complete_question)
                complete_answer.points=q.points/len(answers_c)
                request.db_session.add(complete_answer)
            request.db_session.add(complete_question)

    questions_r=request.db_session.query(Question).filter_by(test=test,qtype='R').all()

    for q in questions_r:
        complete_question = CompleteQuestion(incomplete_test,q)
        complete_question.date_crt = datetime.datetime.now()
        complete_question.date_mdf = datetime.datetime.now()
        correct_answer = request.db_session.query(Answer).filter_by(question_id=q.id,correct=str(1)).one()
        selected_answer=[]
        selected_answer=[s for s in uar if 'radio'+str(q.id) in s]
        if str('radio'+str(q.id)+'='+str(correct_answer.id)) in uar:
            complete_answer=Complete_answer(str(selected_answer[0][selected_answer[0].find("=")+1:]),str(1),incomplete_test,correct_answer,q,complete_question)
            complete_answer.points=q.points
            request.db_session.add(complete_answer)
        elif len(selected_answer) is not 0:
            complete_answer=Complete_answer(str(selected_answer[0][selected_answer[0].find("=")+1:]),str(0),incomplete_test,correct_answer,q,complete_question)
            complete_answer.points=0
            request.db_session.add(complete_answer)
            request.db_session.add(complete_question)
        elif q.mandatory is False:
                complete_answer=Complete_answer(str(0),str(0),incomplete_test,correct_answer,q,complete_question)
                complete_answer.points=0

    for ua in user_answers_O:
        q=request.db_session.query(Question).filter_by(id=ua['name'][11:],qtype='O').one()
        complete_question = CompleteQuestion(incomplete_test,q)
        complete_question.date_crt = datetime.datetime.now()
        complete_question.date_mdf = datetime.datetime.now()
        correct_answer = request.db_session.query(Answer).filter_by(correct=str(1),question_id=q.id).one()
        complete_answer=Complete_answer(ua['value'],str(0),incomplete_test,correct_answer,q,complete_question)
        complete_answer.points=0
        request.db_session.add(complete_answer)
    request.db_session.add(incomplete_test)
    request.db_session.flush()
    if request.userid == incomplete_test.test.user_id:
        return HTTPFound(request.route_path('solved_test',incomplete_test_id= incomplete_test.id))
    else:
        return HTTPFound(request.route_path('filled_test',incomplete_test_id= incomplete_test.id))

@view_config(route_name='solved_test', request_method='GET', renderer='project:templates/solved_test.mako')
def show_solved_test(request):
    incomplete_test_id = request.matchdict['incomplete_test_id']
    try:
        incomplete_test = request.db_session.query(Incomplete_test).filter_by(id=incomplete_test_id).one()
    except:
        raise HTTPNotFound
    test = incomplete_test.test
    if request.userid is None:
        raise  HTTPForbidden
    if request.userid is not test.user_id:
        raise HTTPUnauthorized
    questions = incomplete_test.complete_questions
    questions_and_answers=[]
    sum_points = float(0)
    for q in questions:
        q_answers = q.complete_q_complete_answers
        acq_points =  sum(float(a.points) for a in q_answers)
        sum_points += acq_points
        list=[q, q_answers,acq_points]
        questions_and_answers.append(list)
    return {'incomplete_test':incomplete_test,'questions_and_answers':questions_and_answers, 'sum_points': sum_points}




