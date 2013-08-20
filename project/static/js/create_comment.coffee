  input_template = (points,tu) ->
    """
      <div class="form-group">
          <label for="text"> Komentár: </label>
          <textarea class="form-control" name="v" id="l#{tu}"  rows="3" placeholder="Obsah komentáru..." required></textarea>
          <a href="#" class="update_b pull-right" id="u#{tu}"> Uložiť </a>
      </div> 
    """

  hide_process = (id, body) ->
    alert(id)
    tu = (id.substring(1))
    $("#k" + tu).hide()
    $("#koment" + tu).append input_template(body,tu)
    $("#u" + tu).click ->
      process_update @id, post_url

  process_update = (id, post_url) ->
    tu = "l" + (id.substring(1))
    new_comment = $("input[name='"+tu+"']").val()
    alert(tu)

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
    $(".zkomment").click ->
      hide_process @id, @name