// Generated by CoffeeScript 1.6.1
(function() {
  var hide_process, input_template, process_update;

  input_template = function(points, tu) {
    return "<div class=\"form-group\">\n    <label for=\"text\"> Komentár: </label>\n    <textarea class=\"form-control\" name=\"v\" id=\"l" + tu + "\"  rows=\"3\" placeholder=\"Obsah komentáru...\" required></textarea>\n    <a href=\"#\" class=\"update_b pull-right\" id=\"u" + tu + "\"> Uložiť </a>\n</div> ";
  };

  hide_process = function(id, body) {
    var tu;
    alert(id);
    tu = id.substring(1);
    $("#k" + tu).hide();
    $("#koment" + tu).append(input_template(body, tu));
    return $("#u" + tu).click(function() {
      return process_update(this.id, post_url);
    });
  };

  process_update = function(id, post_url) {
    var new_comment, tu;
    tu = "l" + (id.substring(1));
    new_comment = $("input[name='" + tu + "']").val();
    alert(tu);
    $.ajax({
      url: post_url,
      type: "POST",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify({
        points: new_bodyQ,
        id_question: id.substring(1)
      })
    }).done(function(response) {
      return top.location.href = post_url;
    }).fail(function(response) {
      return console.log(response + "neupdatol som sa");
    });
    return false;
  };

  $(document).ready(function() {
    var ebody;
    ebody = $(".zkomment");
    return $(".zkomment").click(function() {
      return hide_process(this.id, this.name);
    });
  });

}).call(this);
