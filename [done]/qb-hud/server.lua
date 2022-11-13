local QBCore = exports['qb-core']:GetCoreObject()
local ResetStress = false
local ResetPee = false
local ResetPoo = false

QBCore.Commands.Add('cash', 'Kiểm tra tiền mặt', {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local cashamount = Player.PlayerData.money.cash
    TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
end)

QBCore.Commands.Add('bank', 'Kiểm tra số dư ngân hàng', {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local bankamount = Player.PlayerData.money.bank
    TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
end)

QBCore.Commands.Add("dev", "Bật/Tắt chế độ Dev", {}, false, function(source, args)
    TriggerClientEvent("qb-admin:client:ToggleDevmode", source)
end, 'god')

--Stress
RegisterNetEvent('hud:server:GainStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player or (Config.DisablePoliceStress and Player.PlayerData.job.name == 'police') then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    --exports['xt-notify']:Alert("THÔNG BÁO", "Cảm thấy nhẹ người hơn", 5000, 'success')
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    --exports['xt-notify']:Alert("THÔNG BÁO", "Cảm thấy dễ chịu hơn", 5000, 'success')
end)

--Pee
RegisterNetEvent('hud:server:GainPee', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newPee
    if not ResetPee then
        if not Player.PlayerData.metadata['pee'] then
            Player.PlayerData.metadata['pee'] = 100
        end
        newPee = Player.PlayerData.metadata['pee'] - amount
        if newPee >= 100 then newPee = 100 end
    else
        newPee = 100
    end
    if newPee < 0 then
        newPee = 0
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
            Player.PlayerData.metadata['pee'] = 100
        end
        newPee = Player.PlayerData.metadata['pee'] + amount
        if newPee >= 100 then newPee = 100 end
    else
        newPee = 100
    end
    if newPee < 0 then
        newPee = 0
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
            Player.PlayerData.metadata['poo'] = 100
        end
        newPoo = Player.PlayerData.metadata['poo'] - amount
        if newPoo >= 100 then newPoo = 100 end
    else
        newPoo = 100
    end
    if newPoo < 0 then
        newPoo = 0
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
            Player.PlayerData.metadata['poo'] = 100
        end
        newPoo = Player.PlayerData.metadata['poo'] + amount
        if newPoo >= 100 then newPoo = 100 end
    else
        newPoo = 100
    end
    if newPoo < 0 then
        newPoo = 0
    end
    Player.Functions.SetMetaData('poo', newPoo)
    TriggerClientEvent('hud:client:UpdatePoo', src, newPoo)
    --exports['xt-notify']:Alert("THÔNG BÁO", "Cảm thấy nhẹ người hơn", 5000, 'success')
end)

QBCore.Functions.CreateCallback('hud:server:HasHarness', function(source, cb)
    local Ply = QBCore.Functions.GetPlayer(source)
    local Harness = Ply.Functions.GetItemByName("harness")
    if Harness ~= nil then
        cb(true)
    else
        cb(false)
    end
end)
QBCore.Functions.CreateCallback('hud:server:getMenu', function(source, cb)
    cb(Config.Menu)
end) 
