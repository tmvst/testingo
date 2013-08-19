  input_template = (points,tu) ->
  "
    <div class=\"form-group\">
        <label for=\"text\"> Komentár: </label>
        <textarea class=\"form-control\" name=\"text\" id=\"text\" rows=\"3\" placeholder=\"Obsah komentáru...\" required></textarea>
    </div> 
  "

  hide_process = (id, body) ->
    tu = (id.substring(1))
    alert(tu)
    $("#k" + tu).hide()
    $("#koment" + tu).append input_template(body,tu)
    $("#t" + tu).click ->
      process_update @id, post_url

  process_update = (id, post_url) ->
    q_id = 's'+(id.substring(1))
    new_bodyQ = $("input[name='"+q_id+"']").val()
    alert(id.substring(1))

    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        points: new_bodyQ
        id_question: (id.substring(1))
    .done (response) ->
      top.location.href = post_url
    .fail (response) ->
      console.log response + "neupdatol som sa"

    return false

  $(document).ready ->
    ebody = $(".zkomment")
    alert("tu som")
    $(".zkomment").click ->
      hide_process @id, @name