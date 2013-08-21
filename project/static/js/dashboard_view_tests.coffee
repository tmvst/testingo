hide_process = (id, event) ->
    event.preventDefault
    alert(id)
    $("#" + id).hide()

$(document).ready ->
    ebody = $(".preh_test")
    alert("tu")
    $(".preh_test").click ->
      hide_process @name, event