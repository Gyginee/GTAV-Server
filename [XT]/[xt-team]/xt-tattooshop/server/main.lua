QBCore = exports['qb-core']:GetCoreObject()
QBCore.Functions.CreateCallback('SmallTattoos:GetPlayerTattoos', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        MySQL.Async.fetchAll('SELECT tattoos FROM players WHERE citizenid = @citizenid', {
            ['@citizenid'] = Player.PlayerData.citizenid
        }, function(result)
            if result[1].tattoos then
                cb(json.decode(result[1].tattoos))
            else
                cb()
            end
        end)
    else
        cb()
    end
end)
RegisterServerEvent('xt-tatooshop:server:xam', function(tattoo, tattooList, price, tattooName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney('cash', price)
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn đã xăm hình " .. tattooName .. " với giá $" .. price, 5000, 'success')
        TriggerEvent("qb-bossmenu:server:addAccountMoney", "cardealer", price)
        table.insert(tattooList, tattoo)
    end
    MySQL.Async.fetchAll('UPDATE players SET tattoos = @tattoos WHERE citizenid = @citizenid', {
        ['@tattoos'] = json.encode(tattooList),
        ['@citizenid'] = Player.PlayerData.citizenid
    })
end)
QBCore.Functions.CreateCallback('SmallTattoos:PurchaseTattoo', function(source, cb, tattooList, price, tattoo, tattooName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= price then
        cb(true)
        TriggerClientEvent('Apply:Tattoo', source, tattoo, tattooList, price, tattooName)
    else
        TriggerClientEvent('xt-notify:client:Alert', source, "THÔNG BÁO", "không đủ tiền mặt ", 5000, 'error')
    end
end)




RegisterServerEvent('Select:Tattoos', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT tattoos FROM players WHERE citizenid = @citizenid', {
        ['@citizenid'] = Player.PlayerData.citizenid
    }, function(result)
        if result[1].tattoos then
            local tats = result[1].tattoos
            TriggerClientEvent('xt-tattooshop:client:loadxam', src, tats)
        else
            TriggerEvent('remover:all')
            TriggerClientEvent('remover:tudo', src)
        end
    end)
end)

RegisterServerEvent('remover:all', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        MySQL.Async.fetchAll('UPDATE players SET tattoos = @tattoos WHERE citizenid = @citizenid', {
            ['@tattoos'] = 0,
            ['@citizenid'] = Player.PlayerData.citizenid
        })
    end
end)