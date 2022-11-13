AxMenu = {}
AxMenu.Open = function(data){
    AxMenu.HomeMenu = data.menus;
    AxMenu.PreviousMenu = undefined;
    AxMenu.CurrentMenu = undefined;
    $('.menu').fadeIn(100);
    AxMenu.SetupMenu(data.menus);
}
AxMenu.SetupMenu = function(table){
    AxMenu.CurrentMenu = table;
    AxMenu.Reset()
    if (table==true){return;}
    $.each(table, function(i, label){
        i++
        $('#label-'+i).html(i+'.'+label.label)
        $('.hex-'+i).show().data(label)
        $('.i-'+i).addClass(label.icon+' fa-2x')
        $('.hex-'+i).click(function(){
            var menu = $(this).data()
            if (menu.submenu == false){
                $.post('https://'+GetParentResourceName()+'/Event', JSON.stringify({
                    event:menu.event,
                    parameter:menu.parameter,
                    type:menu.type
                }));
                if(menu.shouldclose){
                    AxMenu.Close()
                }
            }else{
                AxMenu.PreviousMenu = AxMenu.CurrentMenu;
                AxMenu.CurrentMenu = menu.submenu;
                AxMenu.SetupMenu(menu.submenu)
            }
        })
    })
}
AxMenu.Reset = function(){
    for (i = 0; i < 10; i++) {
        $('#label-'+i).html('')
        $('.hex-'+i).hide().data('')
        $('.hex-'+i).removeData()
        $('.i-'+i).attr('class','i-'+i)
    };$('.hexagon').off()
    $('.close').click(function(){ 
        if (AxMenu.CurrentMenu == AxMenu.HomeMenu){
            AxMenu.Close()
        }else if(AxMenu.CurrentMenu == AxMenu.PreviousMenu){
            AxMenu.SetupMenu(AxMenu.HomeMenu)
        }else{
            AxMenu.SetupMenu(AxMenu.PreviousMenu)
        }
    })
    if(AxMenu.CurrentMenu == AxMenu.HomeMenu){
        $('.i-close').attr('class','i-close fa fa-times fa-2x');$('#label-close').html('Close')
    }else{
        $('.i-close').attr('class','i-close fas fa-chevron-circle-right fa-2x');$('#label-close').html('Back')
    }
    $('.menu').hide();
    setTimeout(function(){$('.menu').fadeIn(500)},100)
}
AxMenu.Close = function(){
    $.post('https://'+GetParentResourceName()+'/CloseMenu', JSON.stringify({}));
    $('.menu').fadeOut()
    $('.hexagon').off()
}

var keys = {
    49:1,
    50:2,
    51:3,
    52:4,
    53:5,
    54:6,
}

$(document).on('keydown', function(event) {
    switch(event.keyCode) {
        case 27:
            AxMenu.Close()
            break;
        case 55:
            $('.close').trigger('click')
            break;
        default:
            $(`.hex-${keys[event.keyCode]}`).trigger('click')
            break;
    }
});
window.addEventListener("message", function(event) {
    var data = event.data;
    switch(data.action) {
        case "open":AxMenu.Open(data);break;
        case 'forceclose': AxMenu.Close();break;
    }
});