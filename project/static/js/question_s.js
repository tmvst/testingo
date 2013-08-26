// Generated by CoffeeScript 1.6.1
(function() {
  var answer_template, button_template, delete_entry, form_submit, ix_s, process_submit, update_cnt;

  ix_s = 1;

  answer_template = function() {
    return "<div class=\"form-group\">\n	<label for=\"odpoved\">" + ix_s + ".</label>\n	<input type=\"text\" id=\"s" + ix_s + "\" name=\"odpoved\" class=\"phrase form-control\" placeholder=\"Správna odpoveď\">\n	<div class=\"btn btn-default btn-sm delete-button\"> Zmazať </div> <br>\n</div>";
  };

  button_template = function() {
    return "<a class=\"btn btn-default btn-sm\" id='submit'> Pridať odpoveď </a> <br>";
  };

  process_submit = function() {
    $('#answer_s').append(answer_template());
    ix_s++;
    return update_cnt();
  };

  update_cnt = function() {
    var cnt;
    return cnt = $('.phrase').length;
  };

  delete_entry = function(e) {
    return $(e.target).parent().remove();
  };

  form_submit = function(redir) {
    var answers, bodyQ, is_q_mandatory, textQ;
    $('#form_s').validate({
      rules: {
        text: {
          required: true
        },
        points: {
          required: true,
          number: true
        }
      },
      messages: {
        text: "Prosím zadajte text otázky",
        points: {
          required: "Prosím zadajte body",
          number: "Body musia byť číslo"
        }
      }
    });
    if ($('#form_s').valid()) {
      textQ = $("textarea[name='text']").val();
      bodyQ = $("input[name='points']").val();
      answers = $("input.phrase").serializeArray();
      is_q_mandatory = $('#is_q_mandatory').is(':checked');
      $.ajax({
        url: post_url,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
          text: textQ,
          points: bodyQ,
          answers: answers,
          is_q_mandatory: is_q_mandatory
        })
      }).done(function(response) {
        return top.location.href = redir;
      }).fail(function(response) {
        return console.log(response);
      });
    }
    return false;
  };

  $(document).ready(function() {
    var answer, new_c_url, new_o_url, new_r_url, new_s_url;
    answer = $('#answer_s');
    answer.html(button_template());
    $('#submit').click(process_submit);
    $('#answer_s').on('click', '.delete-button', delete_entry);
    $('#form_s').submit(function() {
      return false;
    });
    new_s_url = test_url + "/new-phrase-question";
    new_c_url = test_url + "/new-checkbox-question";
    new_r_url = test_url + "/new-radio-question";
    new_o_url = test_url + "/new-open-question";
    $("#save_and_add_s").click(function() {
      return form_submit(new_s_url);
    });
    $("#save_and_add_c").click(function() {
      return form_submit(new_c_url);
    });
    $("#save_and_add_r").click(function() {
      return form_submit(new_r_url);
    });
    $("#save_and_add_o").click(function() {
      return form_submit(new_o_url);
    });
    return $("#save_and_end").click(function() {
      return form_submit(test_url);
    });
  });

}).call(this);
