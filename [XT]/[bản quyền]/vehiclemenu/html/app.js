AxVehicleMenu = {}
AxVehicleMenu.ShowNUI = function(data){
    if(!$(`#${data.id}`).length){
        $('body').append(`<p id=${data.id} style="display:none;color:white;position:absolute;left:'${data.position[0]*100}'%;top:${data.position[1]*100}%">${data.html}</p>`)
        $(`#${data.id}`).fadeIn(500)
    }else{
        $(`#${data.id}`).css({left:data.position[0]*100+'%',top:data.position[1]*100+'%'})
    }
    $(`#${data.id}`).off()
    $(`#${data.id}`).click(function(){
        $.post(`http://${GetParentResourceName()}/OpenDoor`, JSON.stringify({
            id:data.id,
        }));
    })
}
window.addEventListener("message", function(event){
    let data = event.data;
    switch(data.action){
        case 'show':
            AxVehicleMenu.ShowNUI(data)
            break;
        case 'close':
            $('body').html('')
            break;    
        case 'bonnet':
            $("#bonnet").remove()
            break;
    }
})