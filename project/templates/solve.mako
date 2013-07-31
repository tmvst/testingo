<%inherit file="default.mako" />
<%block name="title">${test.name}</%block>
<%block name="page_content">
    <div class="page-header">
        <h1>${test.name}</h1>
    </div>

    <div class="container">
        
        <div class="control-group">
            <div class="controls">
                <p>${test.description}</p>
            </div>

            <h2>Otázky</h2>


            
        </div>
    </div>
</%block>
