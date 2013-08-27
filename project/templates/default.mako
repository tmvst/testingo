<!DOCTYPE HTML>
<html lang="sk-SK">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon"
      type="image/png"
      href="${request.static_path('project:static/templates/stylesheet/favicon.ico')}">
    <!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/css/bootstrap.min.css">

    <link href="${request.static_path('project:static/stylesheets/bootstrap-glyphicons.css')}" media="screen, projection" rel="stylesheet" type="text/css" />
    <link href="${request.static_path('project:static/stylesheets/custom.css')}" media="screen, projection" rel="stylesheet" type="text/css" />


    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>

    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"></script>
</head>


<body>
    <div class="navbar navbar-fixed-top navbar-inverse navbar-custom">
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
            % if request.userid:
            <ul class="nav navbar-nav pull-right">
                <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> Dashboard</a></li>
                <li><p class="navbar-text">Prihlásený ${request.user.email}</p></li>
                <li>
                    <form action="${request.route_path('logout')}" method="POST">
                        <button type="submit" class="btn btn-link navbar-btn">Odhlásiť</button>
                    </form>
                </li>
            </ul>
            % endif
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
