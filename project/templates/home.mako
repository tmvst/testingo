<%inherit file="default.mako" />
<%block name="title">Úvodná stránka</%block>
<%block name="before_content">
	<script src="${request.static_path('project:static/js/home.js')}"></script>
	<script type="text/javascript">
        post_url="${request.route_path('home')}"
    </script>

    <div class="headrow">
        <div class="container">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 whyt">
                        <h2>Prečo si vybrať testingo?</h2>
                        <ul class="list-unstyled checks">
                            <li><span class="glyphicon glyphicon-ok"></span> Kedykoľvek a kdekoľvek k dispozícii</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Už žiadne papiere</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Žiadne ponocovanie</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Žiadne meškajúce termíny</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Rovnocenné podmienky</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Okamžité výsledky</li>
                        </ul>
                    </div>
	                <div class="col-lg-4">
	                </div>
                    <div class="col-lg-4">
                        <div class="pull-left">
                            <form class="form-signin" method="post" action="" id="form-signin">
                                <h2 class="form-signin-heading">Rýchla registrácia</h2>

                                <div class="control-group">
                                    <div class="controls">
                                        <input size="50" name="login" id="login" value="" type="text" class="form-control" placeholder="Meno" autofocus="autofocus" required>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <div class="controls">
                                        <input size="50" name="email" id="email" value="" type="email" class="form-control" placeholder="E-Mail" required>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <div class="controls">
                                        <input size="50" name="password" id="password" value="" type="password" class="form-control" placeholder="Heslo" required>
                                    </div>
                                </div>

                                <button name="submit" id="submit" value="" type="submit" class="btn btn-large btn-primary btn-block">Registrovať</button>
                                <p class="help-block text-right">
                                    <a href="${request.route_path('dashboard')}">Prihlásenie</a> |
                                    <a href="${request.route_path('beg_for_recovery')}" >Zabudnuté heslo</a>
                                </p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</%block>

<%block name="page_content">
    <script src="${request.static_path('project:static/js/lightbox-2.6.min.js')}"></script>

    <div class="page-header text-center">
        <h1 class="text-center">Testingo je lepšie ako čakajúca kopa papierov :)<br>
            <small class="text-center">Jednoduchý systém tvorby online testov s automatickým vyhodnocovaním</small></h1>
    </div>

    <div class="howitwork">
        <div class="wrapper">
            <h2>Ako to funguje?</h2>
            <div class="row">

                <!-- ###   Feature 1 ### -->
                <div class="col-lg-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/how1.png')}"> </div>
                    <h6> 1. Registrujte sa</h6>
                    <p> Po registrácii získate prístup k vytváraniu a riešeniu testov a užitočným štatistikám </p>
                    <div class="step"><p>Krok 1</p></div>
                </div>

                <!-- ###   Feature 2 ### -->
                <div class="col-lg-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/how2.png')}"> </div>
                    <h6> 2. Vytvorte test</h6>
                    <p> Po vytvorení testu do neho môžete pridávať ľubovoľný počet otázok rôznych typov </p>
                    <div class="step"><p>Krok 2</p></div>
                </div>

                <!-- ###   Feature 2 ### -->
                <div class="col-lg-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/how3.png')}"> </div>
                    <h6> 3. Zdieľajte test</h6>
                    <p> Keď budete so zadaním spokojní, môžete test jednoducho poslať respondentom na riešenie </p>
                    <div class="step"><p>Krok 3</p></div>
                </div>


            </div>
        </div>
    </div>

    <div class="screenshots">
        <h2>Ako to vyzerá?</h2>
        <div class="row">
            <div class="col-sm-6 col-md-3">
                <a href="http://www.atozed.com/indy/demos/9/RBSODFiles/BSOD.gif" data-lightbox="BSOD" class="thumbnail">
                    <img data-src="holder.js/100%x180" src="http://www.atozed.com/indy/demos/9/RBSODFiles/BSOD.gif" alt="">
                </a>
            </div>
        </div>
    </div>


    <div class="fblike">
        <iframe src="//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Ftestingo.sk&amp;width=450&amp;height=80&amp;colorscheme=light&amp;layout=standard&amp;action=like&amp;show_faces=false&amp;send=true&amp;appId=57820298747" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:80px;" allowTransparency="true"></iframe>
    </div>

</%block>
