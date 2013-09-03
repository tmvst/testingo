<%inherit file="default.mako" />
<%block name="title">Nová otázka - checkbox</%block>
<%block name="page_content">
    <script src="${request.static_path('project:static/js/question_c.js')}"></script>
    <script type="text/javascript">
        post_url="${request.route_path('newquestion_c', test_id=test.id)}"
        test_url="${request.route_path('showtest', test_id=test.id)}"
    </script>
    <ol class="breadcrumb">
      <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> </a></li>
        <li><a href="${request.route_path('dashboard')}">Vaše testy</a></li>
        <li><a href="${request.route_path('showtest', test_id=test.id)}">Test ${test.name}</a></li>
        <li class="active">Nová otázka</li>
    </ol>

    <div class="page-header">
        <h1>Nová otázka do testu <a href="${request.route_path('showtest',test_id=test.id)}">${test.name}</a>
        <br>
        s viacerými správnymi odpoveďami</h1>
    </div>

    <div id="newq">
        <form action="#" id="form_c">
            <div class="form-group">
                <label for="text">Znenie otázky</label>
                <textarea class="form-control" name="text" id="text" rows="3" placeholder="Znenie otázky" required></textarea>
            </div>

            <div class="form-group">
                <label for="points">Body</label>
                <input id="points" name="points" class="form-control" placeholder="Body">
            </div>

            <div class="form-group">
                <label for="points">Povinnosť vyplniť otázku</label>
                <input type="checkbox" id="is_q_mandatory" name="is_q_mandatory">
            </div>

            <div id="answer"></div>

            <div class="form-group btn-group pull-left">
                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-ok"></span> Uložiť a pridať ďalšiu <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="" id="save_and_add_s">otázka s frázovou odpoveďou</a></li>
                    <li><a href="" id="save_and_add_c">otázka s viacerými správnymi odpoveďami</a></li>
                    <li><a href="" id="save_and_add_r">otázka s jednou správnou odpoveďou</a></li>
                    <li><a href="" id="save_and_add_o">otázka s otvorenou odpoveďou</a></li>
                </ul>
            </div>
            <button type="submit" formaction="#" class="btn btn-default" id="save_and_end" style="margin-left: 5px;">Uložiť a skončiť</button>

            <div class="pull-right"><a href="${request.route_path('showtest', test_id=test.id)}" class="btn btn-danger">Zrušiť</a></div>
        </form>
    </div>

    <%include file="showquestions.mako"/>
</%block>