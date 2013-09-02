<!DOCTYPE HTML>
<html lang="sk-SK">
<head>
	<title><%block name="title"/></title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${request.static_path('project:static/templates/stylesheet/favicon.ico')}">

    <!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/css/bootstrap.min.css">

    <link href="${request.static_path('project:static/stylesheets/bootstrap-glyphicons.css')}" media="screen, projection" rel="stylesheet" type="text/css" />
    <link href="${request.static_path('project:static/stylesheets/custom.css')}" media="screen, projection" rel="stylesheet" type="text/css" />

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>

    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"></script>
	<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>


<body>
    <div class="navbar navbar-fixed-top navbar-inverse navbar-custom">
        <div class="navbar-inner">
            <div class="container">
	            <a href="/"><img src="${request.static_path('project:static/img/darklogo.png')}" class="tlogo"></a>

              <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
              <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <!-- Be sure to leave the brand out there if you want it shown -->
            <!-- <a class="navbar-brand" href="/">Testingo <span class="glyphicon glyphicon-ok"></span></a> -->

            <!-- Everything you want hidden at 940px or less, place within here -->
            % if request.userid:
            <ul class="nav navbar-nav pull-right">
                <li><a href="${request.route_path('dashboard')}"><span class="glyphicon glyphicon-home"></span> Ovládací panel</a></li>
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

<%block name="before_content">
</%block>
<div class="container" id="main">
    <div class="container">
            <%block name="page_content">${content | n}</%block>
    </div>
	<div class="container">
		<div class="footer">
			<p class="text-center">Testingo.sk (c) 2013</p>
		</div>
	</div>
</div>

</body>
</html>
