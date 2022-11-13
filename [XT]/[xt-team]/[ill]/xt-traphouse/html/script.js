var selectedWindow = "none"

window.addEventListener('message', function(event) {
    switch (event.data.action) {
        case 'atm':
            var popup_sound = new Audio('popup.mp3');
            popup_sound.volume = 0.2;
            popup_sound.play();
            atm_numpad(event.data.pin);
            $(".atm_card").fadeIn();
            selectedWindow = "atm";
            break
    }
});

$(document).ready(function() {
    document.onkeyup = function(data) {
        if (data.which == 27) {
            switch (selectedWindow) {
                case 'atm':
                    var popuprev_sound = new Audio('popupreverse.mp3');
                    popuprev_sound.volume = 0.2;
                    popuprev_sound.play();
                    $(".atm_card").fadeOut();
                    $.post('https://xt-traphouse/action', JSON.stringify({
                        action: "close",
                    }));
                    selectedWindow = "none";
                    break
            }
        }
    };
});
$(document).on('click', ".close-atm", function() {
    var popuprev_sound = new Audio('popupreverse.mp3');
    popuprev_sound.volume = 0.2;
    popuprev_sound.play();

    $('.atm_card').fadeOut();
    $.post('https://xt-traphouse/action', JSON.stringify({
        action: "close",
    }));
    selectedWindow = "none";
})
var canSetClick = true;

function atm_numpad(pin) {
    var input = "";
    correct = pin;

    var dots = document.querySelectorAll(".dot");
    numbers = document.querySelectorAll(".number");
    dots = Array.prototype.slice.call(dots);
    numbers = Array.prototype.slice.call(numbers);


    numbers.forEach(function(number, index) {
        if (canSetClick) {
            number.addEventListener("click", numpad);
        }

        function numpad() {
            if (index == 9 || index == 11) {
                if (index == 9) {
                    dots.forEach(function(dot, index) {
                        dot.className = "dot clear";
                    });
                } else if (index == 11) {
                    if (input == correct) {
                        var correct_sound = new Audio('correct.mp3');
                        correct_sound.volume = 0.2;
                        correct_sound.play();

                        dots.forEach(function(dot, index) {
                            dot.className = "dot active correct";
                        });

                        setTimeout(function() {
                            var popuprev_sound = new Audio('popupreverse.mp3');
                            popuprev_sound.volume = 0.2;
                            popuprev_sound.play();

                            $(".atm_card").fadeOut();
                            $.post('https://xt-traphouse/action', JSON.stringify({
                                action: "close",
                            }));
                            selectedWindow = "none";

                            $.post('https://xt-traphouse/action', JSON.stringify({
                                action: "atm",
                            }));
                        }, 900);
                    } else {
                        var wrong_sound = new Audio('wrong.mp3');
                        wrong_sound.volume = 0.2;
                        wrong_sound.play();

                        dots.forEach(function(dot, index) {
                            dot.className = "dot active wrong";
                        });
                        $.post('https://xt-traphouse/action', JSON.stringify({
                                action: "sai",
                        }));
                    }
                }
                setTimeout(function() {
                    dots.forEach(function(dot, index) {
                        dot.className = "dot";
                    });
                    input = "";
                }, 900);
                setTimeout(function() {
                    document.body.className = "";
                }, 2000);
            } else {
                var atm_sound = new Audio('atm.mp3');
                atm_sound.volume = 0.2;
                atm_sound.play();

                if (input.length < 4) {
                    if (index == 10) {
                        index = -1
                    }
                    number.className = "number grow";
                    input += index + 1;
                    dots[input.length - 1].className = "dot active";
                    setTimeout(function() {
                        number.className = "number";
                    }, 1000);
                }
            }
        }
    });
    canSetClick = false
}