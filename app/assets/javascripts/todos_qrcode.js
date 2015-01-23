(function () {
	$(function() {

		$('#gen-qrcode').click(function () {
			$('#qrcode-popup').bPopup({ onOpen: function () { 
				$.getJSON('todos/qrcode', function (data) {
					var img_qr = $('#img-qrcode');
					var img_error = $('#img-no-qrcode');
					if (data['succeeded']) {
						img_qr.removeClass('hidden');
						img_error.addClass('hidden');
						img_qr.attr('src', 'data:image/png;base64,' + data['code']);
					} else {
						img_qr.addClass('hidden');
						img_error.removeClass('hidden');
					}
				});
			}});
		});

	});
}).call(this);