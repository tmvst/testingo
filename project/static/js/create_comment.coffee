  input_template = (points,tu) ->
    """
      <div class="form-group" id="d#{tu}">
          <label for="text"> Komentár: </label>
          <textarea class="form-control" name="l#{tu}" id="l#{tu}"  rows="3" placeholder="Obsah komentáru..." required></textarea>
          <a href="#" class="update_b pull-right" id="u#{tu}"> Uložiť </a>
      </div> 
    """

  comment_template = (koment) ->
    """
      Komentár:<br>
      #{koment}
    """

  hide_process = (id, body, event) ->
    alert(id)
    event.preventDefault
    tu = (id.substring(1))
    $("#k" + tu).hide()
    $("#koment" + tu).append input_template(body,tu)
    $("#u" + tu).click ->
      process_update @id, post_url

  process_update = (id, post_url) ->
    tu = "l" + (id.substring(1))
    new_comment = $("textarea[name='"+tu+"']").val()
    alert(new_comment)

    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        comment: new_comment
        id_question: (id.substring(1))
        nc: 1
    .done (response) ->
      $("#koment" + (id.substring(1))).append comment_template(new_comment)
      $("#d" + (id.substring(1))).hide()
    .fail (response) ->
      console.log response + "neupdatol som comment"

    return false

  $(document).ready ->
    ebody = $(".zkomment")
    $(".zkomment").click ->
      hide_process @id, @name, event