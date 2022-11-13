$(function () {
    window.addEventListener('message', function(event) {
        if (event.data.action == "toggle") {
            if (event.data.show) {
                $("#ui").show();
                Thoigianonline(event.data);
            } else {
                $("#ui").hide();
            }
        } else if (event.data.action == "update") {
            $('#title').html("Online nhận quà mỗi ngày thả ga | hôm nay bạn online được: "+event.data.online+" phút ");  
            Thoigianonline(event.data);
        }    
    document.onkeyup = function (data) { if (data.which == 27) { $.post('https://onemore-onlinennhanqua/closemenu', JSON.stringify({})); $("#ui").hide(); }};
    });
    $("#imgqua1").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua1");
    });
    $("#imgqua2").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua2");
    });
    $("#imgqua3").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua3");
    });
    $("#imgqua4").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua4");
    });
    $("#imgqua5").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua5");
    });
    $("#imgqua6").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua6");
    });
    $("#imgqua7").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua7");
    });
    $("#imgqua8").click(function () {
        $.post("https://onemore-onlinennhanqua/nhanqua8");
    });
});

function Thoigianonline(check) {
    if (check.day1 == "danhan") {
            $('#imgqua1 img').attr('src', 'img/giftbox2.png');
            } else {       
            $('#imgqua1 img').attr('src', 'img/giftbox.png'); 
    }               
    if (check.day2 == "danhan") {
            $('#imgqua2 img').attr('src', 'img/giftbox2.png');
            } else { 
            $('#imgqua2 img').attr('src', 'img/giftbox.png'); 

    }              
    if (check.day3 == "danhan") {    
            $('#imgqua3 img').attr('src', 'img/giftbox2.png');
            } else {        
            $('#imgqua3 img').attr('src', 'img/giftbox.png');     
    }                 
    if (check.day4 == "danhan") {
            $('#imgqua4 img').attr('src', 'img/giftbox2.png');
            } else {
            $('#imgqua4 img').attr('src', 'img/giftbox.png');         
    }    
    if (check.day5 == "danhan") {
            $('#imgqua5 img').attr('src', 'img/giftbox2.png');
            } else {
            $('#imgqua5 img').attr('src', 'img/giftbox.png');         
    }    

    if (check.day6 == "danhan") {
            $('#imgqua6 img').attr('src', 'img/giftbox2.png');
            } else {
            $('#imgqua6 img').attr('src', 'img/giftbox.png');         
    }    

    if (check.day7 == "danhan") {
            $('#imgqua7 img').attr('src', 'img/giftbox2.png');
            } else {
            $('#imgqua7 img').attr('src', 'img/giftbox.png');         
    }    

    if (check.day8 == "danhan") {
            $('#imgqua8 img').attr('src', 'img/giftbox2.png');
            } else {
            $('#imgqua8 img').attr('src', 'img/giftbox.png');         
    }    
}
