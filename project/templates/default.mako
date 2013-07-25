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
                <a class="brand" href="#">Testingo</a>

                <!-- Everything you want hidden at 940px or less, place within here -->
                <div class="nav-collapse collapse">
                    <!-- .nav, .navbar-search, .navbar-form, etc -->
                    <form class="navbar-form pull-right" action="${request.route_path('login')}" method="POST">
                        <input type="email" name="email" id="email-login" class="input-small" placeholder="E-mail" required/>
                        <input type="password" name="password" id="password-login" class="input-small" placeholder="Heslo" required/>
                        <button type="submit" class="btn">Prihlásiť sa</button>
                    </form>

                    <ul class="nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                Account
                            <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li>Ahoj</li>
                                <a href="#">Ahoj</a>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="container" id="main">
        <div id="header">
            <h1><a href="/">Project</a></h1>
            <div class="login">
            % if request.userid is None:
                <div id="log in">
                    <form class="login-form" action="${request.route_path('login')}" method="POST">
                        <div class="input-group">
                            <label for="email-login">E-mail</label>
                            <input type="email" name="email" id="email-login" required/>
                        </div>
                        <div class="input-group">
                            <label for="password-login">Heslo</label>
                            <input type="password" name="password" id="password-login" required/>    
                        </div>
                        <button type="submit" class="submit-form">Prihlásiť sa</button>
                        <a class="register-button" href="${request.route_path('register')}">Zaregistrovať sa</a>
                        <div class="recovery-password">
                        <a href="${request.route_path('beg_for_recovery')}" >Zabudol som heslo</a>
                        </div>
                    </form>
                </div>
            % else:
                <form action="${request.route_path('logout')}" method="POST">
                    <button type="submit" class="signout-button">Odhlásiť ${request.user.email}</button>
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
