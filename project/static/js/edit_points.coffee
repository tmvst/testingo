  input_template = (points,tu) ->
    """
    <a href="#" class="update_b pull-right" id="t#{tu}"> Uložiť </a>
    <input class="form-control-my pull-right" value="#{points}" name="s#{tu}"> 
    """

  hide_process = (id, body) ->
    tu = (id.substring(1))
    $("#b" + tu).hide()
    $("#o" + tu).append input_template(body,tu)
    $("#c" + tu).hide()
    $("#t" + tu).click ->
      process_update @id, post_url

  process_update = (id, post_url) ->
    q_id = 's'+(id.substring(1))
    new_bodyQ = $("input[name='"+q_id+"']").val()

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
    ebody = $(".zbody")
    $(".zbody").click ->
      hide_process @id, @name