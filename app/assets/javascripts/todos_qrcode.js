(function () {
	$(function() {

		$('#gen-qrcode').click(function () {
			$('#qrcode-popup').bPopup({ onOpen: function () { 
				$.getJSON('todos/qrcode', function (data) {
					$('#qrcode-popup img').attr('src', 'data:image/png;base64,' + data['code']); 
				});
			}});
		});

	});
}).call(this);