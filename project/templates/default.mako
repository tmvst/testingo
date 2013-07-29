<!DOCTYPE HTML>
<html lang="sk-SK">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link href="${request.static_path('project:static/stylesheets/screen.css')}" media="screen, projection" rel="stylesheet" type="text/css" /> -->
    <link href="${request.static_path('project:static/stylesheets/bootstrap-responsive.css')}" media="screen, projection" rel="stylesheet" type="text/css" />
    <link href="${request.static_path('project:static/stylesheets/custom.css')}" media="screen, projection" rel="stylesheet" type="text/css" />
    <link href="${request.static_path('project:static/stylesheets/bootstrap.css')}" media="screen, projection" rel="stylesheet" type="text/css" />

    <link href="${request.static_path('project:static/js/bootstrap.js')}" type="text/javascript" />
</head>

<body>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">

              <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
              <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                </a>

                <!-- Be sure to leave the brand out there if you want it shown -->
                <a class="brand" href="/">Testingo</a>

                <!-- Everything you want hidden at 940px or less, place within here -->
                <ul class="nav pull-right">
                    % if request.userid:
                        <li><a href="/dashboard">Dashboard</a></li>
                        <li><a href="/newtest">Nový test</a></li>
                    % endif
                </ul>
            </div>
        </div>
    </div>

    <div class="container" id="main">
        <div id="header">
            <div class="login">
            % if request.userid is None:
                <div id="log in">
                    <form class="form-inline" action="${request.route_path('login')}" method="POST">
                        <input type="email" name="email" class="input-small" placeholder="Email" required>
                        <input type="password" name="password" class="input-small" placeholder="Heslo" required>
                        <button type="submit" class="btn">Sign in</button>
                        <label>
                            <a href="${request.route_path('register')}">Zaregistrovať sa</a> |
                            <a href="${request.route_path('beg_for_recovery')}" >Zabudol som heslo</a>
                        </label>
                    </form>
                </div>
            % else:
                <form action="${request.route_path('logout')}" method="POST">
                ${request.user.email}
                    <button type="submit" class="btn">Odhlásiť</button>
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
