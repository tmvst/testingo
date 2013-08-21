<%inherit file="default.mako" />
<div id="fb-root"></div>
<div id="fb-root"></div>

<%block name="title">Úvodná stránka</%block>
<%block name="page_content">

    <div class="page-header">
        <h1>Vitaj na Testingu!</h1>
    </div>


<iframe src="//www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Ftestingo.sk&amp;width=450&amp;height=80&amp;colorscheme=light&amp;layout=standard&amp;action=like&amp;show_faces=false&amp;send=true&amp;appId=57820298747" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:450px; height:80px;" allowTransparency="true"></iframe>

    <h2><ul>
        <li>konzistentna kontrola input fieldov na celom webe , pri registracii je to napr defualt html, pri vytvarani otazok nas validator od jquery</li>
        <li>vytvorenie noveho testu z existujuceho</li>
        <li>vytvorenie viewu riesitelia testu, v riesiteloch moznost vyhladavania</li>
        <li>statistiky - mozno vo forme grafov </li>
    </ul>
    </h2>
</%block>
