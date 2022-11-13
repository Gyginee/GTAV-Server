
local sansang = true
local timer = 0
RegisterNetEvent('xt-base:client:duatien', function()
    if sansang == true then
        local noidung = exports['qb-input']:ShowInput({
            header = 'ĐƯA TIỀN',
            submitText = "Xác nhận",
            inputs = {
                {
                    text = 'ID Người chơi',
                    name = 'id',
                    type = 'number',
                    isRequired = true
                },
                {
                    text = 'Số tiền ($)',
                    name = 'price',
                    type = 'number',
                    isRequired = true
                },
            }
        })
        if noidung then
            if not noidung.id or not noidung.price then return
            else
                local id = tonumber(noidung.id)
                local sotien = tonumber(noidung.price)
                TriggerServerEvent('xt-base:server:duatien', id, sotien)
                duatien = false
                timer = 30
            end
        end
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn đang thao tác quá nhanh", 5000, 'error')
    end
end)


CreateThread(function()
    while true do
        if sansang == false then
            if timer <= 0 then
                timer = 0
                sansang = true
            else
                timer = timer - 10
            end
        end
        Wait(10000)
    end
end)

RegisterNetEvent('xt-base:client:check:players:near', function(TargetPlayer, Amount)
    local Player, Distance = QBCore.Functions.GetClosestPlayer()
    if Player ~= -1 and Distance < 3.0 then
        if GetPlayerServerId(Player) == TargetPlayer then
            RequestAnimDict("friends@laf@ig_5")
            while not HasAnimDictLoaded("friends@laf@ig_5") do
                Wait(0)
            end
            TaskPlayAnim(PlayerPedId(), 'friends@laf@ig_5', 'nephew', 5.0, 1.0, 5.0,48, 0.0, 0, 0, 0)
            RemoveAnimDict("friends@laf@ig_5")
            TriggerServerEvent('xt-base:server:give:cash', TargetPlayer, Amount)
        else
            exports['xt-notify']:Alert("HỆ THỐNG", "Công dân không chính xác", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Không tìm thấy công dân", 5000, 'error')
    end
end)