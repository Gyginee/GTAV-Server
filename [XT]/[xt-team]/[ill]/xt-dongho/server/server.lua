local QBCore = exports['qb-core']:GetCoreObject()
-- Code

RegisterServerEvent('xt-dongho:server:phanthuong', function(count)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local sl = math.random(5, 8)
    xPlayer.Functions.AddItem('tienban', sl)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["tienban"], 'add', sl)
end)