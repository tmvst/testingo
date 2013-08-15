// Generated by CoffeeScript 1.6.3
(function() {
  var form_submit;

  form_submit = function() {
    var user_answers_C, user_answers_S;
    user_answers_S = $("input.user_answers_S").serializeArray();
    user_answers_C = $("input.user_answers_C").serialize();
    $.ajax({
      url: post_url,
      type: "POST",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify({
        user_answers_S: user_answers_S,
        user_answers_C: user_answers_C
      })
    }).done(function(response) {
      return top.location.href = "/dashboard";
    }).fail(function(response) {
      alert('kkt');
      return console.log(response);
    });
    return false;
  };

  $(document).ready(function() {
    $('#form_solve').submit(function() {
      return false;
    });
    return $("#solve_test").click(form_submit);
  });

}).call(this);