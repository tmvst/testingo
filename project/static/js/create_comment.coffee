  input_template = (text,tu) ->
    """
      <div class="form-group" id="d#{tu}">
          <label for="text"> Komentár: </label>
          <textarea class="form-control" name="l#{tu}" id="l#{tu}"  rows="3" required>#{text}</textarea>
          <a href="#" class="update_b pull-right" id="u#{tu}"> Uložiť </a>
      </div> 
    """

  comment_template = (koment,tu) ->
    """
    <div id="koment_text#{tu}">
      Komentár:<br>
      #{koment}
    <div>
    """

  hide_process = (id, event) ->
    event.preventDefault
    q_id = (id.substring(1))
    $("#k" + q_id).hide()

    if $("textarea[name='l" + q_id + "']")
      $("#koment_text" + q_id).hide()
      $("#koment" + q_id).append(input_template($("textarea[name='l" + q_id + "']").val(), q_id))
    else
      $("#koment" + q_id).append(input_template("mm", q_id))       

    $("#u" + q_id).click ->
      process_update @id, post_url

  process_update = (id, post_url) ->
    id_q = (id.substring(1))
    id_area = "l" + id_q
    new_comment = $("textarea[name='"+id_area+"']").val()
    alert(new_comment)

    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        comment: new_comment
        id_question: id_q
        nc: 1
    .done (response) ->
      $("#koment" + id_q).append comment_template(new_comment, id_q)
      $("#d" + id_q).hide()
      $("#k" + id_q).show()
    .fail (response) ->
      console.log response + "neupdatol som comment"

    return false

  $(document).ready ->
    ebody = $(".zkomment")
    $(".zkomment").click ->
      hide_process @id, event