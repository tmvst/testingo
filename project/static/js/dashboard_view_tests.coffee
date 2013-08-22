hide_process = (event) ->
    event.preventDefault
    #alert(id)
    $("#Activita").hide()
    $("#left-panel").removeClass("col-lg-6").addClass("col-lg-12")

show_process = (event) ->
    event.preventDefault
    $("#left-panel").removeClass("col-lg-12").addClass("col-lg-6")
    $("#Activita").show()

$(document).ready ->
    $("#preh_test").click ->
      hide_process event
    $(".showTest").click ->
      show_process event