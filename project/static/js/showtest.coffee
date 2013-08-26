process = () ->
  $('#focusedInput').focus()
  $('#focusedInput').select()

$(document).ready ->
  $('#focusedInput').click(() -> this.select())
  $('#focusBtn').click(() -> process())