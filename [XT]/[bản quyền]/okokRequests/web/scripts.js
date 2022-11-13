var darkMode = false // false = light mode, true = dark mode
var selectedWindow = "none"

window.addEventListener('message', function(event) {
	if (darkMode == true) {
		$(".request .card-body").css("background-color", "#1d1e22");
		$(".request .card-body").css("color", "rgba(160, 160, 160, 1)");
		$(".request #title").css("color", "#e6e6e6");
		$("#switchbtn").removeClass("switchbtn_labelc1");
		$("#switchbtn").addClass("switchbtn_labelc2");
		$(".blockrequest .card-body").css("background-color", "#1d1e22");
		$(".blockrequest .card-body").css("color", "rgba(110, 113, 121, 0.5)");
		$(".blockrequest #titleblock").css("color", "#e6e6e6");

	}
});

// Windows
window.addEventListener('message', function(event) {
	switch (event.data.action) {
		case 'open':
			var popup = new Audio('popup.mp3');
			popup.volume = 0.4;
			popup.play();

			$("#title").html(event.data.title);
			$("#message").html(event.data.message);
			selectedWindow = "request"
			$(".request").fadeIn();
			break
		case 'openblock':
			var popup = new Audio('popup.mp3');
			popup.volume = 0.4;
			popup.play();

			if (event.data.status == 'enabled') {
				$('#status').prop('checked', true);
			} else if (event.data.status == 'disabled') {
				$('#status').prop('checked', false);
			}

			$(".blockrequest").fadeIn();
			selectedWindow = "blockRequest"
			break
		case 'close':
			var popuprev = new Audio('popupreverse.mp3');
			popuprev.volume = 0.4;
			popuprev.play();

			$(".request").fadeOut();
			$(".blockrequest").fadeOut();
			selectedWindow = "none"
			break
	}
});

// Close ESC Key
$(document).ready(function(){
	document.onkeyup = function(data) {
		if (data.which == 27) {
			var popuprev = new Audio('popupreverse.mp3');
			popuprev.volume = 0.4;
			popuprev.play();
			switch (selectedWindow) {
				case 'request' :
					$(".request").fadeOut();
					$(".blockrequest").fadeOut();
					$.post('https://okokRequests/action', JSON.stringify({
						action: "closeEsc",
					}));
					selectedWindow = "none"
					break
				case 'blockRequest' :
					$(".request").fadeOut();
					$(".blockrequest").fadeOut();
					$.post('https://okokRequests/action', JSON.stringify({
						action: "closeBlockEsc",
					}));
					selectedWindow = "none"
					break
			}
		}
	};
});

// Button Actions
$(document).on('click', "#acceptRequest", function() {
	var accept = new Audio('accept.mp3');
	accept.volume = 0.5;
	accept.play();

	$(".request").fadeOut();
	$(".blockrequest").fadeOut();

	$.post('https://okokRequests/action', JSON.stringify({
		action: "acceptRequest",
	}));
});

$(document).on('click', "#declineRequest", function() {
	var decline = new Audio('decline.mp3');
	decline.volume = 0.2;
	decline.play();

	$(".request").fadeOut();
	$(".blockrequest").fadeOut();

	$.post('https://okokRequests/action', JSON.stringify({
		action: "declineRequest",
	}));
});

$(document).on('click', "#saveBlockRequest", function() {
	var status
	var accept = new Audio('accept.mp3');
	accept.volume = 0.5;
	accept.play();

	if ($("#status").is(':checked')) {
		status = "enabled"
	} else {
		status = "disabled"
	}

	$(".request").fadeOut();
	$(".blockrequest").fadeOut();

	$.post('https://okokRequests/action', JSON.stringify({
		action: "saveBlockRequest",
		status: status,
	}));
});

$(document).on('click', "#closeBlockRequest", function() {
	var decline = new Audio('decline.mp3');
	decline.volume = 0.2;
	decline.play();

	$(".request").fadeOut();
	$(".blockrequest").fadeOut();

	$.post('https://okokRequests/action', JSON.stringify({
		action: "closeBlockRequest",
	}));
});