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
    url = window.location.href
    host = window.location.host
    params = url.replace("http://#{host}/dashboard", "")

    if params is "?tab=2"
      $('#dtab a[href="#solved_tests"]').tab('show')
    else if params is "?tab=3"
      $('#dtab a[href="#view_all_tests"]').tab('show')
      hide_process event

    $("#preh_test").click ->
      hide_process event
    $(".showTest").click ->
      show_process event