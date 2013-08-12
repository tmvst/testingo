// Generated by CoffeeScript 1.6.3
(function() {
  var answer_template, button_template, delete_entry, form_submit, ix, process_submit, update_cnt;

  ix = 1;

  answer_template = function() {
    return "<div class=\"answerblock\">\n<input class=\"checkInputC\" name=\"check" + ix + "\" type=\"checkbox\" value=\"\">\n<input name=\"text" + ix + "\" class=\"checkInput form-control\">\n<div class=\"btn btn-default btn-small delete-button\"> Zmazať odpoveď </div> <br>\n</div>";
  };

  button_template = function() {
    return "<a class=\"btn btn-default btn-small\" id='submit'> Pridať odpoveď </a> <br>";
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
    var answers, bodyQ, correctness, q_type, textQ;
    q_type = $("input[name='q_typeC']").val();
    textQ = $("textarea[name='textC']").val();
    bodyQ = $("input[name='points2']").val();
    answers = $("input.checkInput").serializeArray();
    correctness = $("input.checkInputC").serializeArray();
    $.ajax({
      url: post_url,
      type: "post",
      data: {
        q_type: q_type,
        text: textQ,
        points: bodyQ,
        answers: answers,
        correctness: correctness
      }
    }).done(function(response) {
      return alert("Done!");
    }).fail(function() {
      return alert("Fail!");
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
