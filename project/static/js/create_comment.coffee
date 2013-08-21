  input_template = (text,tu) ->
    """
      <div class="form-group" id="textarea_vykresli#{tu}">
          <label for="text"> Komentár: </label>
          <textarea class="form-control" name="area#{tu}" id="area#{tu}"  rows="3" placeholder="Obsah komentára..." required>#{text}</textarea>
          <a href="#" class="update_b pull-right" id="ulozit#{tu}"> Uložiť </a>
      </div> 
    """

  comment_template = (koment,tu) ->
    """
    <div id="koment_text#{tu}">
      Komentár:<br>
      #{koment}
    </div>
    """

  hide_process = (id, text, event) ->

    event.preventDefault
    q_id = (id.substring(11))
    $("#upravit_btn" + q_id).hide()
    $("#koment_text" + q_id).hide()

    if  not not text
      text=''
    $("#koment_area" + q_id).append(input_template(text, q_id))

    $("#ulozit" + q_id).click ->
      process_update q_id, post_url

  process_update = (id, post_url) ->
    id_q = id
    id_area = "area" + id_q
    new_comment = $("textarea[name='"+id_area+"']").val()
    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        comment: new_comment
        id_question: id_q
        nc: 1
    .done (response) ->
      $("#koment_area" + id_q).append comment_template(new_comment, id_q)
      $("#textarea_vykresli" + id_q).hide()
      $("#upravit_btn" + id_q).show()
    .fail (response) ->
      console.log response + "neupdatol som comment"

    return false

  $(document).ready ->
    ebody = $(".zkomment")
    $(".zkomment").click ->
      hide_process @id, @name, event