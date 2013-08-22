  input_template = (points,tu) ->
    """
    <span id="x#{tu}">
    <a href="#" class="update_b pull-right" id="t#{tu}"> Uložiť </a>
    <input class="form-control-my pull-right" value="#{points}" name="s#{tu}"> 
    </span>
    """

  hide_process = (id, body, max) ->
    tu = (id.substring(1))
    $("#b" + tu).hide()
    $("#o" + tu).append input_template(body,tu)
    $("#c" + tu).hide()
    $("#t" + tu).click ->
      process_update @id, post_url, max

  process_update = (id, post_url, max) ->
    tu = (id.substring(1))
    q_id = ('s' + tu)
    new_bodyQ = $("input[name='"+q_id+"']").val()

    $.ajax
      url: post_url
      type: "POST"
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify
        points: new_bodyQ
        id_question: tu
        nc: 0
    .done (response) ->
      $("#x" + tu).hide()
      $("#b" + tu).show()
      $("#c" + tu).show()
      $("#b" + tu).html(new_bodyQ + " / " + max)
    .fail (response) ->
      console.log response + "neupdatol som sa"

    return false

  $(document).ready ->
    ebody = $(".zbody")
    maxp = $(".zbody").data("points")
    $(".zbody").click ->
      hide_process @id, @name, maxp