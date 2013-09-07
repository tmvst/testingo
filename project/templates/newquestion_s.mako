<%inherit file="default.mako" />
<%block name="title">Nová otázka - fráza</%block>
<%block name="page_content">

    <script src="${request.static_path('project:static/js/question_s.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('newquestion_s', test_id=test.id)}"
        test_url="${request.route_path('showtest', test_id=test.id)}"
    </script>

        <ol class="breadcrumb">
      <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> </a></li>
        <li><a href="${request.route_path('dashboard')}">Vaše testy</a></li>
            <li><a href="${request.route_path('showtest', test_id=test.id)}">Test ${test.name}</a></li>

            <li class="active">Nová otázka</li>
        </ol>


    <div class="page-header">
        <h1>Nová otázka s frázovou odpoveďou</h1>
    </div>

    <div id="newq">
        <form action="#" id="form_s">
            <div class="form-group">
                <label for="text">Znenie otázky</label>
                <textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
            </div>

            <div class="form-group">
                <label for="points">Body</label>
                <input id="points" name="points" class="form-control" placeholder="Body">
            </div>

            <hr>

	        <label>Odpovede</label>

            <div id="answer_s"></div>

            <a class="btn btn-default" id='submit'> Pridať odpoveď </a> <br>

            <div class="form-group btn-group">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" style="margin-top: 15px;">
                    <span class="glyphicon glyphicon-ok"></span> Uložiť a pridať ďalšiu <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="" id="save_and_add_s">s frázovou odpoveďou</a></li>
                    <li><a href="" id="save_and_add_c">s viacerými správnymi odpoveďami</a></li>
                    <li><a href="" id="save_and_add_r">s jednou správnou odpoveďou</a></li>
                    <li><a href="" id="save_and_add_o">s otvorenou odpoveďou</a></li>
                </ul>
            </div>
            <button type="submit" formaction="#" class="btn btn-default" id="save_and_end" style="margin-left: 5px;">Uložiť a skončiť</button>

            <a href="${request.route_path('showtest', test_id=test.id)}" class="btn btn-danger pull-right" style="margin-top: 15px;">Zrušiť</a>
        </form>
    </div>
    <hr>

    <%include file="showquestions.mako"/>

</%block>