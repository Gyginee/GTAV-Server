local QBCore = exports['qb-core']:GetCoreObject()
local ResetPee = false
local ResetPoo = false

--Pee
RegisterNetEvent('hud:server:GainPee', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newPee
    if not ResetPee then
        if not Player.PlayerData.metadata['pee'] then
            Player.PlayerData.metadata['pee'] = 0
        end
        newPee = Player.PlayerData.metadata['pee'] + amount
        if newPee <= 0 then newPee = 0 end
    end
    if newPee > 100 then
        newPee = 100
    end
    Player.Functions.SetMetaData('pee', newPee)
    TriggerClientEvent('hud:client:UpdatePee', src, newPee)

end)


RegisterNetEvent('hud:server:RelievePee', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newPee
    if not Player then return end
    if not ResetPee then
        if not Player.PlayerData.metadata['pee'] then
            Player.PlayerData.metadata['pee'] = 0
        end
        newPee = Player.PlayerData.metadata['pee'] + amount
        if newPee <= 0 then newPee = 0 end
    end
    if newPee > 100 then
        newPee = 100
    end
    Player.Functions.SetMetaData('pee', newPee)
    TriggerClientEvent('hud:client:UpdatePee', src, newPee)
    --exports['xt-notify']:Alert("THÔNG BÁO", "Cảm thấy nhẹ người hơn", 5000, 'success')
end)

--Poo
RegisterNetEvent('hud:server:GainPoo', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newPoo
    if not ResetPoo then
        if not Player.PlayerData.metadata['poo'] then
            Player.PlayerData.metadata['poo'] = 0
        end
        newPoo = Player.PlayerData.metadata['poo'] + amount
        if newPoo <= 0 then newPoo = 0 end
    end
    if newPoo > 100 then
        newPoo = 100
    end
    Player.Functions.SetMetaData('poo', newPoo)
    TriggerClientEvent('hud:client:UpdatePoo', src, newPoo)

end)


RegisterNetEvent('hud:server:RelievePoo', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newPoo
    if not Player then return end
    if not ResetPoo then
        if not Player.PlayerData.metadata['poo'] then
            Player.PlayerData.metadata['poo'] = 0
        end
        newPoo = Player.PlayerData.metadata['poo'] + amount
        if newPoo <= 0 then newPoo = 0 end
    end
    if newPoo > 100 then
        newPoo = 100
    end
    Player.Functions.SetMetaData('poo', newPoo)
    TriggerClientEvent('hud:client:UpdatePoo', src, newPoo)
    --exports['xt-notify']:Alert("THÔNG BÁO", "Cảm thấy nhẹ người hơn", 5000, 'success')
end)
