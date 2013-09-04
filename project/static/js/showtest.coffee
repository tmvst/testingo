process = () ->
  $('#focusedInput').focus()
  $('#focusedInput').select()

$(document).ready ->
  if $('#focusedInput').val()
    if window.location.host == "testingo.sk"
      url = $('#focusedInput').val()
      url = url.replace('0.0.0.0:6543', 'testingo.sk')
      $('#focusedInput').val(url)

  $('#focusedInput').click(() -> this.select())
  $('#focusBtn').click(() -> process())