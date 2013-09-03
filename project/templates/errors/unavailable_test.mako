<%inherit file="../default.mako" />
<%block name="title">Test je nepristupny</%block>
<%block name="page_content">
    <div>
        <div style="padding-top: 150px"class="page-header">
            <h1 class="text-danger" style="text-align:center"><p>Test je neprístupný</p></h1>
        </div>
        <h1 style="text-align:center">Vami požadovanému testu vypršal čas pre jeho sprístupnenie.</h1>
        <br><br>
        <p>Myslíte si, že by mal byť prístupný?</p>
        <ul class="list-group">
            <li class="list-group-item">Kontaktujte tvorcu Vášho testu.</li>
            <li class="list-group-item">Pokúste sa o spustenie neskôr.</li>
        </ul>
        <br>
        <p style="text-align:center"><strong>Prosím pokračujte návratom na <a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> Dashboard</a></strong></p>
    </div>
</%block>