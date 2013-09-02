<%inherit file="default.mako" />
<%block name="title">Prihlasenie</%block>
<%block name="page_content">
	<div class="page-header">
		<h1>Prihlásenie</h1>
	</div>
    <div id="log in">
        <form action="${request.route_path('login')}" method="POST">
			% if errors != []:
				<div class="alert alert-danger">
					${errors[0]}
					% if errors[1] == "email":
						<a href="${request.route_path('home')}" class="alert-link">Registruj sa!</a>
					% endif
					% if errors[1] == "passw":
						<a href="${request.route_path('beg_for_recovery')}" class="alert-link">Zabudnuté heslo?</a>
					% endif
				</div>
			% endif
            <div class="form-group col-md-4 col-md-offset-4">
                <div class="form-group">
                    <label for="email">E-mail</label>
                    <input type="email" name="email" id="email" class="form-control" placeholder="Email" required/>
                </div>
                <div class="form-group">
                    <label>Heslo</label>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Heslo" required/>
                </div>
	            <button type="submit-form" class="btn btn-primary">Prihlásiť sa</button>
            </div>
        </form>
    </div>
</%block>
