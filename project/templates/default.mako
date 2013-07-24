<!DOCTYPE HTML>
<html lang="sk-SK">
<head>
	<meta charset="utf-8">

    <link href="${request.static_path('project:static/stylesheets/screen.css')}" media="screen, projection" rel="stylesheet" type="text/css" />
</head>

<body id='museum'>
    <div id="main">
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
        <div id='content'>
            <%block name="page_content">${content | n}</%block>
        </div>
    </div>
</body>
</html>
