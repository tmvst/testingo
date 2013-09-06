$(document).ready ->
    $("#help-panel").hide()

    $('#card1').tooltip(delay: { show: 800, hide: 100 })
    $('#card2').tooltip(delay: { show: 800, hide: 100 })
    $('#preh_test').tooltip(delay: { show: 800, hide: 100 })
    $("#help-panel-toggle").tooltip(title: 'Pomoc', placement: 'bottom')

    $('#help-panel-toggle').click () ->
      $("#help-panel").toggle()

    $("#help-panel-close").click () ->
      $("#help-panel").toggle()