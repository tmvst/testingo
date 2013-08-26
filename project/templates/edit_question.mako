<div id="newq">
        <form action="#" id="form_showQ">
            <div class="form-group">
                <label for="text">Znenie otázky</label>
                <textarea class="form-control" name="text" id="text" rows="3" required>${question.text}</textarea>
            </div>

            <div class="form-group">
                <label for="points">Body</label>
                <input id="points" name="points" class="form-control" placeholder="${question.points}">
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
                % else:
                    % for answer in question.answers:
                        % if answer.correct == 1:
                            <span>
                            % if (question.qtype == "C"):
                                <input class="indikator" type="checkbox" value="" checked disabled="disabled">
                            % elif (question.qtype == "R"):
                                <input class="indikator" type="radio" value="" checked disabled="disabled" >
                            % elif (question.qtype == "O"):
                                <textarea class="text form-control" rows="3" placeholder="Odpoveď myslím, že vyplniť pre vlastnú potrebu snáď môžete...">${answer.text}</textarea>
                            % else:
                                <input class="text form-control" rows="2" value="${answer.text}">
                            % endif

                            </span>
                        % else:
                            <span>
                            % if (question.qtype == "C"):
                                    <input class="indikator" type="checkbox" value="" disabled="disabled">

                            % elif (question.qtype == "R"):
                                    <input class="indikator" type="radio" value="" disabled="disabled">

                            % endif
                            <input class="text form-control" rows="2" value="${answer.text}">
                            </span>

                        % endif
                    % endfor
                % endif

                % if (question.qtype != "O"):
                    <a class="btn btn-default btn-sm" id='create_answer_showQ' name="${question.qtype}"> Pridať odpoveď </a> <br>
                    <div id="input_answer_showQ"></div>
                % endif
             </div>
        </form>
</div>