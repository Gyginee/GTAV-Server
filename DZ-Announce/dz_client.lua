RegisterNetEvent('dz-announce:client:sendNuiMessage')
AddEventHandler('dz-announce:client:sendNuiMessage', function(length, text)
    if length == 0 or length == nil then length = 7500 end
    TransitionToBlurred(200)
    TriggerServerEvent('InteractSound_SV:PlayOnAll',"thongbao", 0.5)
    SendNUIMessage { mode = "toggleOn", length = tonumber(length), text = text }
    Wait(length)
    TransitionFromBlurred(200)
end)