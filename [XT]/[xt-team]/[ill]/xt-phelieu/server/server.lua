local QBCore = exports['qb-core']:GetCoreObject()
-- Code

QBCore.Functions.CreateCallback('xt-phelieu:server:is:vehicle:owned', function(source, cb, plate)
    exports.oxmysql:fetch('SELECT * FROM player_vehicles WHERE plate = ?',
        {plate}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

QBCore.Functions.CreateCallback('xt-phelieu:server:get:reward', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local RandomValue = math.random(1, 100)
    local RandomItems = Config.BinItems[math.random(#Config.BinItems)]
    local number = math.random(2, 3)
    if RandomValue <= 90 then
        Player.Functions.AddItem(RandomItems, number)
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[RandomItems], 'add', number)
    else
        TriggerClientEvent('xt-notify:client:Alert', Player.PlayerData.source, "THÔNG BÁO", "Bạn không tìm thấy gì cả", 5000, 'error')
    end
end)

RegisterServerEvent('xt-phelieu:server:scrap:reward', function()
    local Player = QBCore.Functions.GetPlayer(source)
    for i = 1, math.random(4, 8), 1 do
        local Items = Config.CarItems[math.random(1, #Config.CarItems)]
        local RandomNum = math.random(5, 6)
        Player.Functions.AddItem(Items, RandomNum)
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[Items], 'add', RandomNum)
        Citizen.Wait(500)
    end
    if math.random(1, 100) <= 35 then
        local number = math.random(3,4)
        Player.Functions.AddItem('rubber', number)
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['rubber'], 'add', number)
    end
end)
