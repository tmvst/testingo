<!DOCTYPE HTML>
<html lang="sk-SK">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${request.static_path('project:static/stylesheets/custom.css')}" media="screen, projection" rel="stylesheet" type="text/css" />
    <link href="${request.static_path('project:static/stylesheets/bootstrap.css')}" media="screen, projection" rel="stylesheet" type="text/css" />
    <link href="${request.static_path('project:static/stylesheets/bootstrap-glyphicons.css')}" media="screen, projection" rel="stylesheet" type="text/css" />

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="${request.static_path('project:static/js/bootstrap.js')}"></script>
</head>

<body>
    <div class="navbar navbar-fixed-top navbar-inverse">
        <div class="navbar-inner">
            <div class="container">

              <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
              <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <!-- Be sure to leave the brand out there if you want it shown -->
            <a class="navbar-brand" href="/">Testingo <span class="glyphicon glyphicon-ok"></span></a>

            <!-- Everything you want hidden at 940px or less, place within here -->
            <ul class="nav navbar-nav pull-right">
                % if request.userid:
                <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> Dashboard</a></li>
                <li><a href="${request.route_path('newtest')}">Nový test</a></li>
                % endif
            </ul>
        </div>
    </div>
</div>

<div class="container" id="main">
    <div id="header">
        <div class="pull-right">
            % if request.userid is None:
            <div id="log in">
                <form class="form-inline" action="${request.route_path('login')}" method="POST">
                    <input type="email" name="email" class="form-control" style="width: 180px;" placeholder="Email" required>
                    <input type="password" name="password" class="form-control" style="width: 180px;" placeholder="Heslo" required>
                    <button type="submit" class="btn btn-default">Prihlásiť</button>
                    <span class="help-block">
                        <a href="${request.route_path('register')}">Zaregistrovať sa</a> |
                        <a href="${request.route_path('beg_for_recovery')}" >Zabudol som heslo</a>
                    </span>
                </form>
            </div>
            % else:
            <form action="${request.route_path('logout')}" method="POST">
                <span>Prihlásený ${request.user.email}</span>
                <button type="submit" class="btn btn-default">Odhlásiť</button>
            </form>
            % endif
        </div>
    </div>

    <div class="container">
        <div class="content">
            <%block name="page_content">${content | n}</%block>
        </div>
    </div>
</div>
</body>
</html>
