$(document).ready ->
    url = window.location.href
    host = window.location.host
    params = url.replace("http://#{host}/dashboard", "")

    if params is "?tab=2"
      $('#dtab a[href="#solved_tests"]').tab('show')
    else if params is "?tab=3"
      $('#dtab a[href="#view_all_tests"]').tab('show')
      $("#Activita").hide()
      $("#left-panel").removeClass("col-lg-6").addClass("col-lg-12")

    $("#preh_test").click ->
      $("#Activita").hide()
      $("#left-panel").removeClass("col-lg-6").addClass("col-lg-12")

    $(".showTest").click ->
      $("#left-panel").removeClass("col-lg-12").addClass("col-lg-6")
      $("#Activita").show()