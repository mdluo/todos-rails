(function () {
	$(function() {

		$('#gen-qrcode').click(function () {
			$('#qrcode-popup').bPopup({ onOpen: function () { 
				$.getJSON('todos/qrcode', function (data) {
					var img_qr = $('#qrcode-popup img');
					var img_error = $('#img-no-qrcode');
					if (data['succeeded']) {
						img_qr.show();
						img_error.hide();
						img_qr.attr('src', 'data:image/png;base64,' + data['code']);
					} else {
						img_qr.hide();
						img_error.show();
					}
				});
			}});
		});

	});
}).call(this);