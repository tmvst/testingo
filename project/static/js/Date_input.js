(function() {
    $(document).ready(function() {
        $('#start_time').datetimepicker({
			sliderAccessArgs: { touchonly: false },
			onClose: function(dateText, inst) {
				if ($('#end_time').val() != '') {
					var testStartDate = $('#start_time').datetimepicker('getDate');
					var testEndDate = $('#end_time').datetimepicker('getDate');
					if (testStartDate > testEndDate)
						$('#end_time').datetimepicker('setDate', testStartDate);
				}
				else {
					$('#end_time').val(dateText);
				}
			},
			onSelect: function (selectedDateTime){
				$('#end_time').datetimepicker('option', 'minDate', $('#start_time').datetimepicker('getDate') );
			}
        });

        $('#end_time').datetimepicker({
			sliderAccessArgs: { touchonly: false },
			onClose: function(dateText) {
				if ($('#start_time').val() != '') {
					var testStartDate = $('#start_time').datetimepicker('getDate');
					var testEndDate = $('#end_time').datetimepicker('getDate');
					if (testStartDate > testEndDate)
						$('#start_time').datetimepicker('setDate', testEndDate);
				}
				else {
					$('#start_time').val(dateText);
				}
			},
			onSelect: function (selectedDateTime){
				$('#start_time').datetimepicker('option', 'maxDate', $('#end_time').datetimepicker('getDate') );
			}
			
		});
    });

}).call(this);