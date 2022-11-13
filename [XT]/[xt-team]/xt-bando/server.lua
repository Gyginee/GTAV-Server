local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent('xt-bando:server:bando' , function(name, giamin, giamax, soluong)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local giaban = math.random(giamin, giamax)
    Player.Functions.RemoveItem(name, soluong)
    local sotien = giaban * soluong
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "remove", soluong)
    Player.Functions.AddMoney('cash', sotien, 'ban-do')
end)
