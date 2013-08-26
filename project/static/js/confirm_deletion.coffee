confirmation = (event) ->
    event.preventDefault
    bootbox.dialog "I am a custom dialog", [
        label: "Success!"
        class: "btn-success"
        callback: ->
          Example.show "great success"
      ,
        label: "Danger!"
        class: "btn-danger"
        callback: ->
          Example.show "uh oh, look out!"
      ,
        label: "Click ME!"
        class: "btn-primary"
        callback: ->
          Example.show "Primary button"
      ,
        label: "Just a button..."
      ]


$(document).ready ->
    $("#delete_question").click ->
      confimation
