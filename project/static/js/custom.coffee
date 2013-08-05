 $ ()->
  answer=$('#answer')
  main.html(answer_template()) 
  main.html(button_template())
  $('#submit').click(process_submit)
                    
  process_submit = () ->
    $('#answer').append(answer_template())

answer_template= () ->
"""
    <label>
    <input type="Checkbox" value="">
    <input type="newCheckbox" id = "checkboxName">
    </label> 
"""

button_template= () ->
"""
    <button id='submit'> Pridať odpoveď </button>
"""