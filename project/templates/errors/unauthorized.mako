<%inherit file="../default.mako" />
<%block name="title">Chyba Unauthorized</%block>
<%block name="page_content">
    <div>
        <div style="padding-top: 150px"class="page-header">
            <h1 class="text-danger" style="text-align:center"><p>Chyba 401</p></h1>
        </div>
        <h1 style="text-align:center">Obsah požadovanej stránky vám nie je prístupný</h1>
        <br><br>
        <p>Dôvodom môže byť jedna z nasledujúcich možností</p>
        <ul class="list-group">
            <li class="list-group-item">Chybne zadaná URL adresa, skontrolujte prosím jej  správnosť</li>
            <li class="list-group-item">Vyskytla sa interná chyba, za ktorú sa opsravedlňujeme</li>
            <li class="list-group-item">Odkaz z ktorého ste prišli na aktuálnu stránku je neplatný alebo out of date</li>
        </ul>
        <br>
        <p style="text-align:center"><strong>Prosím pokračujte návratom na <a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> Dashboard</a></strong></p>
    </div>
</%block>
