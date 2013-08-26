hide_process = (event) ->
    event.preventDefault
    $("#help-panel").toggle()

$(document).ready ->
    $("#help-panel").hide()

    $('#card1').tooltip(delay: { show: 800, hide: 100 })
    $('#card2').tooltip(delay: { show: 800, hide: 100 })
    $('#preh_test').tooltip(delay: { show: 800, hide: 100 })
    $("#help-panel-toggle").tooltip(title: 'Pomoc', placement: 'bottom')

    $('#help-panel-toggle').click ->
      hide_process event

    $("#help-panel-close").click ->
      hide_process event