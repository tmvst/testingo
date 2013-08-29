<div id="newq">
    <form action="#" id="form_showQ">

        <div class="form-group">
            <label for="text">Znenie otázky</label>
            <textarea class="form-control" name="text" id="text" rows="3" required>${question.text}</textarea>
        </div>

        <div class="form-group">
            <label for="points">Body</label>
            <input id="points" name="points" class="form-control" value="${question.points}" >
        </div>

        <div class="form-group">
            %if question.mandatory:
                    <input type="checkbox" id="is_q_mandatory" name="is_q_mandatory" checked>
            %else:
                    <input type="checkbox" id="is_q_mandatory" name="is_q_mandatory">
            %endif

            <label for="points">Povinnosť vyplniť otázku</label>
        </div>



        <div class="list-group">
                % if len(answers) is 0:
                    <span> Otázka neobsahuje žiadne možnosti</span>
                   <div id="input_answer_showQ"></div>

                            <br>
                            <a class="btn btn-default btn-sm" id='create_answer_showQ' name="${question.qtype}"> Pridať odpoveď </a>

                % else:
                    <div id="odpovede_showQ">
                    <% counter =0%>
                    % for answer in question.answers:
                        <% counter = counter +1 %>
                        <div class="answerblock">

                            % if answer.correct == 1:
                            <span>
                            % if (question.qtype == "C"):
                                    <input class="indikator" type="checkbox" name ="ind${counter}"value="" checked >

                            % elif (question.qtype == "R"):
                                    <input class="indikator Rradio" name="radio" type="radio" value="ind${counter}" checked >
                            % endif
                            % if (question.qtype == "O"):
                                    <textarea class="text form-control" name="odpoved" rows="3" placeholder="Odpoveď myslím, že vyplniť pre vlastnú potrebu snáď môžete...">${answer.text}</textarea>
                            % else:
                                %if question.qtype == "S":
                                        <input class="text form-control radiotext indikator" name="text${counter}" id="text${counter}" value="${answer.text}">
                                %else:

                                        <input class="text radiotext  form-control" name="text${counter}" id="text${counter}" value="${answer.text}">
                                %endif
                                    <div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
                            % endif
                            </span>
                            % else:
                            <span>
                            % if (question.qtype == "C"):
                                    <input class="indikator " name ="ind${counter}" type="checkbox" value="">

                            % elif (question.qtype == "R"):
                                    <input class="indikator Rradio" name="radio" type="radio" value="ind${counter}" >

                            % endif
                                <input class="text form-control radiotext"  name="text${counter}"  id="text${counter}"  value="${answer.text}">
                                <div class="btn btn-default btn-sm delete-button"> Zmazať </div> <br>
                            </span>

                            % endif
                        </div>
                    % endfor
                        <div id="input_answer_showQ"></div>
                    % if (question.qtype != "O"):
                            <br>
                            <a class="btn btn-default btn-sm" id='create_answer_showQ' name="${question.qtype}"> Pridať odpoveď </a>
                    % endif
                    </div>
                    % endif
        </div>
    </form>
</div>