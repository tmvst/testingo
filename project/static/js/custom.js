// Generated by CoffeeScript 1.6.3
(function() {
  var answer_template, button_template, delete_entry, form_submit, ix, process_submit, update_cnt;

  ix = 1;

  answer_template = function() {
    return "<div class=\"answerblock\">\n<input class=\"checkInput\" name=\"check" + ix + "\" type=\"checkbox\" value=\"\">\n<input name=\"text" + ix + "\" class=\"checkInput\"> \n<div class=\"btn btn-default btn-small delete-button\"> Zmazať odpoveď </div> <br> \n</div>";
  };

  button_template = function() {
    return "<a class=\"btn btn-default btn-small\" id='submit'> Pridať odpoveď </a> <br> ";
  };

  process_submit = function() {
    $('#answer').append(answer_template());
    ix++;
    return update_cnt();
  };

  update_cnt = function() {
    var cnt;
    return cnt = $('.checkInput').length;
  };

  delete_entry = function(e) {
    return $(e.target).parent().remove();
  };

  form_submit = function() {
    var bodyQ, fields, textQ;
    textQ = $('input[name=text]').val();
    bodyQ = $('input[name=points]').val();
    fields = $(":input.checkInput").serializeArray();
    $.ajax({
      url: post_url,
      type: "post",
      data: {
        text: textQ({
          points: bodyQ,
          fields: fields
        })
      }
    });
    return false;
  };

  $(document).ready(function() {
    var answer;
    answer = $('#answer');
    answer.html(button_template());
    $('#submit').click(process_submit);
    $('#answer').on('click', '.delete-button', delete_entry);
    return $("#input_form_checkbox").submit(form_submit);
  });

}).call(this);
