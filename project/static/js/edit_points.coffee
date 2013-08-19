  hide_process = undefined
  input_template = undefined
  input_template = (points) ->
    "<a href=\"#\" class=\"pull-right\"> Uložiť </a>\n
    <input class=\"pull-right\" value=\"" + points + "\"> "

  hide_process = (id, body) ->
    tu = (id.substring(1))
    $("#b" + tu).hide()
    $("#o" + tu).append input_template(body)
    $("#c" + tu).hide()

  $(document).ready ->
    ebody = undefined
    ebody = $(".zbody")
    $(".zbody").click ->
      hide_process @id, @name