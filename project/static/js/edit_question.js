// Generated by CoffeeScript 1.6.1
(function() {
  var process_submit, question_template;

  question_template = function() {
    return "<div class=\"modal fade\">\n  <div class=\"modal-dialog\">\n    <div class=\"modal-content\">\n	    <div class=\"modal-header\">\n	    	<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\n	        <h4 class=\"modal-title\">Modal title</h4>\n	    </div>\n	    <div class=\"modal-body\">\n	        <p>One fine body&hellip;</p>\n	    </div>\n	    <div class=\"modal-footer\">\n	        <button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button>\n	        <button type=\"button\" class=\"btn btn-primary\">Save changes</button>\n	    </div>\n    </div><!-- /.modal-content -->\n  </div><!-- /.modal-dialog -->\n</div><!-- /.modal -->";
  };

  process_submit = function() {
    alert("tu_vykresli");
    return $('.edit_question').html(question_template());
  };

  $(document).ready(function() {
    var question;
    question = $('#edit_question');
    alert("tu");
    return $('#edit_question').click(process_submit);
  });

}).call(this);
