$(document).ready ->
    host = window.location.host
    $("#solved_tests").click ->
       window.location.replace "http://#{host}/dashboard?tab=3"
    $("#filled_tests").click ->
       window.location.replace "http://#{host}/dashboard?tab=2"
    $("#own_tests").click ->
      window.location.replace "http://#{host}/dashboard?tab=1"
