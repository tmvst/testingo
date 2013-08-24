#{{{
from pyramid.view import (
    view_config,
    )
import random
from pyramid.httpexceptions import (
    HTTPFound,
    HTTPForbidden,
    HTTPUnauthorized,
    HTTPNotFound,
    )

from ..models.answer import (
    Answer,
    )
from ..models.test import (
    Test,
    )
from ..models.question import (
    Question,
    )

from ..models.complete_answer import (
    Complete_answer,
    )
from ..models.incomplete_test import (
    Incomplete_test,
    )
from ..models.complete_question import (
    CompleteQuestion,
    )
import json
from sqlalchemy import func
#}}}

@view_config(route_name='showquestion', request_method='GET', renderer='project:templates/showquestion.mako')
def view_question(request):
    """
    Shows requested question.
    """
    testid = request.matchdict['test_id']
    questionid = request.matchdict["question_id"]
    try:
        test = request.db_session.query(Test).filter_by(id=testid).one()
        question = request.db_session.query(Question).filter_by(id=questionid).one()
    except:
        raise HTTPNotFound

    if request.userid is None:
        raise  HTTPForbidden
    if request.userid is not test.user_id:
        raise HTTPUnauthorized
    answers = request.db_session.query(Answer).filter_by(question=question).all()
    list_of_answers = view_respondents_answer(request)

    user_ans=request.db_session.query(Complete_answer.text,func.count(Complete_answer.id)).filter_by(question=question).group_by(Complete_answer.text).limit(7).all()
    graph_data= create_pie_chart(user_ans)
    return {'graph_data':graph_data,'test':test,'question':question, 'answers':answers, 'list_of_answers':list_of_answers}
def create_pie_chart(data):
    list=[]
    colors=["#F38630","#69D2E7","#F7464A","#7D4F6D","#21323D","#949FB1","#D4CCC5"]
    for a in data:
        item={}
        item['value']=a[1]
        item['label']=a[0]
        color_code=random.randint(0,len(colors)-1)
        item['color']=colors[color_code]
        colors.pop(color_code)
        list.append(item)
    return json.dumps(list)


def view_respondents_answer(request):
    """
    odpovede a emaily respondentov
    """
    questionid = request.matchdict["question_id"]
    question = request.db_session.query(Question).filter_by(id=questionid).one()
    list=[]
    for cq in question.complete_question:
        user_and_answers =[cq.incomplete_test.user,cq.complete_q_complete_answers]
        acq_points =  sum(float(a.points) for a in user_and_answers[1])
        item=[cq,user_and_answers,acq_points]
        list.append(item)

    return list

@view_config(route_name='showquestion', request_method='POST')
def question_delete(request):
    """
    Deletes selected question from test and db.
    """
    testid = request.matchdict['test_id']
    try:
        test = request.db_session.query(Test).filter_by(id=testid).one()
    except:
        raise HTTPNotFound
    if request.userid is None:

        raise  HTTPForbidden
    if request.userid is not test.user_id:
        raise HTTPUnauthorized

    if test.share_token:
        json = request.json_body
        comp_q = request.db_session.query(CompleteQuestion).filter_by(id=json['id_question']).one()
        request.matchdict['incomplete_test'] = comp_q.incomplete_test
        return update_points_in_question_showQ(request)

    questionid = request.matchdict['question_id']
    question= request.db_session.query(Question).filter_by(id=questionid).one()
    question_number=question.number
    questions_with_number_to_be_changed = request.db_session.query(Question).filter(Question.number > question_number).all()
    for q in questions_with_number_to_be_changed:
        q.number=q.number-1

    test.sum_points-=question.points
    request.db_session.delete(question)
    request.db_session.flush()
    return HTTPFound(request.route_path('showtest', test_id=testid))

def create_question(request, db_session, text, points, q_type):         # pridať password !!!
    """Creates a new question and returns its id.
    """

    test_id = request.matchdict['test_id']
    try:
        test = request.db_session.query(Test).filter_by(id=test_id).one()
    except:
        raise HTTPNotFound
    if request.userid is None:
        raise  HTTPForbidden
    if request.userid is not test.user_id:
        raise HTTPUnauthorized
    if points is '':
        points = 0
    test.sum_points=test.sum_points + int(points)
    lastnum = len(request.db_session.query(Question).filter_by(test_id=test_id).all())
    qnum = lastnum + 1

    question = Question(qnum, text, points, q_type, test)

    db_session.add(question)
    db_session.flush()

    return question

def create_answer(request, db_session, text, correct, question):         # pridať password !!!
    """Creates a new answer for the question.
    """


    answer = Answer( text, str(correct), question)

    db_session.add(answer)
    db_session.flush()

    return answer.id

def update_points_in_question_showQ(request):

    incomplete_test= request.matchdict['incomplete_test']
    testid=incomplete_test.test_id
    json = request.json_body


    if request.userid is None:
        raise  HTTPForbidden
    if request.userid is not incomplete_test.test.user_id:
        raise  HTTPUnauthorized

    if json['nc']:

        create_comment(request)
        #HTTPFound(request.route_path('solved_test', incomplete_test_id=testid))
    else:

        points = json['points']
        id_question = json['id_question']

        complete_question = request.db_session.query(CompleteQuestion).filter_by(id=id_question).one()
        qtype=complete_question.question.qtype

        if qtype is 'S' or 'C':
            answer = complete_question.complete_q_complete_answers
            for ans in answer:
                ans.points = float(points)/len(answer)
                request.db_session.merge(ans)

        elif qtype is 'O' or 'R':
            answer = complete_question = request.db_session.query(Complete_answer).filter_by(complete_question=complete_question).one()
            answer.points=points
            request.db_session.merge(answer)

        request.db_session.flush()

    return HTTPFound(request.route_path('showtest', test_id=testid))

def create_comment(request):
    json = request.json_body
    id_question = json['id_question']
    comment = json['comment']

    complete_question = request.db_session.query(CompleteQuestion).filter_by(id=id_question).one()
    complete_question.comment = comment
    request.db_session.merge(complete_question)

    request.db_session.flush()

    return 0
def new_question_wrapper(request,qtype):
    testid = request.matchdict['test_id']

    json = request.json_body
    points = json['points']
    text = json['text']

    try:
        test = request.db_session.query(Test).filter_by(id=testid).one()
    except:
        raise HTTPNotFound
    if test.share_token:
        return HTTPFound(request.route_path('showtest', test_id=testid))

    question = create_question(request, request.db_session,
                                  text,
                                  int(points),
                                  qtype
    )
    question.mandatory=json['is_q_mandatory']
    return question


# ---------------------------------- new stuff ------- (babotkina volba) ----------------


@view_config(route_name='newquestion_s', request_method='GET', renderer='project:templates/newquestion_s.mako')
def s_question_view(request):
    testid = request.matchdict['test_id']
    try:
        test = request.db_session.query(Test).filter_by(id=testid).one()
    except:
        raise HTTPNotFound
    if request.userid is None:

        raise  HTTPForbidden
    if request.userid is not test.user_id:

        raise HTTPUnauthorized
    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_c', request_method='GET', renderer='project:templates/newquestion_c.mako')
def c_question_view(request):
    testid = request.matchdict['test_id']
    try:
        test = request.db_session.query(Test).filter_by(id=testid).one()
    except:
        raise HTTPNotFound
    if request.userid is None:

        raise  HTTPForbidden
    if request.userid is not test.user_id:

        raise HTTPUnauthorized


    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_r', request_method='GET', renderer='project:templates/newquestion_r.mako')
def r_question_view(request):
    testid = request.matchdict['test_id']
    try:
        test = request.db_session.query(Test).filter_by(id=testid).one()
    except:
        raise HTTPNotFound
    if request.userid is None:

        raise  HTTPForbidden
    if request.userid is not test.user_id:

        raise HTTPUnauthorized

    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_o', request_method='GET', renderer='project:templates/newquestion_o.mako')
def o_question_view(request):
    testid = request.matchdict['test_id']
    try:
        test = request.db_session.query(Test).filter_by(id=testid).one()
    except:
        raise HTTPNotFound
    if request.userid is None:
        raise  HTTPForbidden
    if request.userid is not test.user_id:
        raise HTTPUnauthorized

    solved_tests=request.db_session.query(Incomplete_test).filter_by(test=test).all()

    return {'errors':[], 'test':test,'solved_tests':solved_tests}

@view_config(route_name='newquestion_s', request_method='POST')
def s_question_post(request):
    testid = request.matchdict['test_id']
    json = request.json_body
    question = new_question_wrapper(request,'S')
    # q_type reprezentuje typ otazky S,C,R,O
    answers = json['answers']
    for a in answers :
        ans = a['value']
        create_answer(request,request.db_session,
                      ans,
                      1,
                      question)
    return HTTPFound(request.route_path('newquestion_s', test_id=testid))

@view_config(route_name='newquestion_c', request_method='POST')
def c_question_post(request):
    testid = request.matchdict['test_id']
    json = request.json_body
    question = new_question_wrapper(request,'C')

    counter = 1
    counterc = 0
    answers = json['answers']
    correctness = json['correctness']
    for a in answers :
        ans = a['value']
        if counterc < len(correctness) and 'check'+str(counter) == correctness[counterc]['name']:
            create_answer(request,request.db_session,
                          ans,
                          1,
                          question)
            counterc += 1
        else:
            create_answer(request,request.db_session,
                          ans,
                          0,
                          question)
        counter += 1

    return HTTPFound(request.route_path('newquestion_c', test_id=testid))

@view_config(route_name='newquestion_r', request_method='POST')
def r_question_post(request):
    testid = request.matchdict['test_id']
    json = request.json_body
    question = new_question_wrapper(request,'R')

    counter = 1
    counterc = 0
    answers = json['answers']
    correctness = json['correctness']
    for a in answers :
        ans = a['value']
        if counterc < len(correctness) and 'radio'+str(counter) == correctness[counterc]['value']:
            create_answer(request,request.db_session,
                          ans,
                          1,
                          question)
            counterc += 1
        else:
            create_answer(request,request.db_session,
                          ans,
                          0,
                          question)
        counter += 1

    return HTTPFound(request.route_path('newquestion_r', test_id=testid))

@view_config(route_name='newquestion_o', request_method='POST')
def o_question_post(request):
    testid = request.matchdict['test_id']
    json = request.json_body
    question = new_question_wrapper(request,'O')
    answer = json['answer']
    question.mandatory=json['is_q_mandatory']

    create_answer(request,request.db_session,
                  answer,
                  1,
                  question)
    return HTTPFound(request.route_path('newquestion_o', test_id=testid))

@view_config(route_name='solved_test', request_method='POST')
def update_points_in_question(request):
    testid = request.matchdict['incomplete_test_id']
    json = request.json_body
    try:
        incomplete_test = request.db_session.query(Incomplete_test).filter_by(id=testid).one()
    except:
        raise HTTPNotFound
    if request.userid is None:
        raise  HTTPForbidden
    if request.userid is not incomplete_test.test.user_id:
        return  HTTPUnauthorized('Nie je to tvoja test')
    if json['nc'] is 1:
        create_comment(request)
        #HTTPFound(request.route_path('solved_test', incomplete_test_id=testid))
    else:
        points = json['points']
        id_question = json['id_question']
        complete_question = request.db_session.query(CompleteQuestion).filter_by(id=id_question).one()
        qtype=complete_question.question.qtype

        if qtype is 'S' or 'C':
            answers = complete_question.complete_q_complete_answers
            for ans in answers:
                ans.points = float(points)/len(answers)
                request.db_session.merge(ans)

        elif qtype is 'O' or 'R':
            answer = request.db_session.query(Complete_answer).filter_by(complete_question=complete_question).one()
            answer.points=points
            request.db_session.merge(answer)

        request.db_session.flush()

    return HTTPFound(request.route_path('solved_test', incomplete_test_id=testid))


