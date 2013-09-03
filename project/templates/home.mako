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
                            <li><span class="glyphicon glyphicon-ok"></span> Vytvorte si test kedykoľvek a kdekoľvek potrebujete.</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Nestrácajte čas opravovaním papierových testov.</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Žiadne ponocovanie! Zautomatizujte opravovanie svojich testov.</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Meškajúce termíny a nervózni študenti sú Vašou minulosťou.</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Vytvorte rovnocenné podmienky riešenia pre svojich študentov.</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Výsledok je študentovi zverejnený okamžite alebo kedykoľvek sa rozhodnete.</li>
                            <li><span class="glyphicon glyphicon-ok"></span> Majte všetko pod kontrolou!</li>
                        </ul>
                    </div>
                    <div class="col-lg-4">
                    </div>
                    <div class="col-lg-4">
                        <div class="pull-left">
							% if request.userid is None:
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
							% else:
                                <div class="form-signin">
                                    <div class="user-pic"> <img src="${request.static_path('project:static/img/icons/User.png')}"> </div>
                                    <p class="text-center">
                                        Prihlásený ${request.user.name} <br>
                                        <em>${request.user.email}</em> <br>
                                    </p>
                                    <form action="${request.route_path('logout')}" method="POST">
                                        <p class="text-center"><button type="submit" class="btn btn-primary btn-sm">Odhlásiť</button></p>
                                    </form>
                                </div>
							% endif
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
                    <div class="icon"> <img src="${request.static_path('project:static/img/icons/Lock.png')}"> </div>
                    <h6> 1. Registrujte sa</h6>
                    <p> Po registrácii získate prístup k vytváraniu testov, ich riešeniu a k užitočným štatistikám </p>
                    <div class="step"><p>Krok 1</p></div>
                </div>

                <!-- ###   Feature 2 ### -->
                <div class="col-lg-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/icons/Dashboard.png')}"> </div>
                    <h6> 2. Vytvorte test</h6>
                    <p> Po vytvorení testu môžete pridávať ľubovoľný počet otázok s rôznymi typmi odpovedí </p>
                    <div class="step"><p>Krok 2</p></div>
                </div>

                <!-- ###   Feature 2 ### -->
                <div class="col-lg-4 featu">
                    <div class="icon"> <img src="${request.static_path('project:static/img/icons/Mail3.png')}"> </div>
                    <h6> 3. Zdieľajte test</h6>
                    <p> Keď budete so zadaním spokojní, jednoducho pošlite svoj test svojim respondentom </p>
                    <div class="step"><p>Krok 3</p></div>
                </div>


            </div>
        </div>
    </div>

    <div class="screenshots">
        <h2>Ako to vyzerá?</h2>
        <div class="row">
            <div class="col-md-3">
                <a href="http://www.atozed.com/indy/demos/9/RBSODFiles/BSOD.gif" data-lightbox="BSOD" class="thumbnail">
                    <img data-src="holder.js/100%x180" src="http://www.atozed.com/indy/demos/9/RBSODFiles/BSOD.gif" alt="">
                </a>
            </div>
            <div class="col-sm-3 col-sm-offset-6">
                <div class="fb-like-box" data-href="https://www.facebook.com/testingo.sk" data-width="250" data-height="190" data-show-faces="true" data-header="false" data-stream="false" data-show-border="true"></div>
            </div>
        </div>
    </div>


    <div id="fb-root"></div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=57820298747";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
</%block>
