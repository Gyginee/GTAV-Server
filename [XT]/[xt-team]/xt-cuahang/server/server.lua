local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('xt-cuahang:server:GetConfig', function(source, cb)
    cb(Config)
end)

RegisterServerEvent('xt-cuahang:server:update:store:items', function(Shop, ItemData, Amount)
    Config.Shops[Shop]["Product"][ItemData.slot].amount = Config.Shops[Shop]["Product"][ItemData.slot].amount - Amount
    TriggerClientEvent('xt-cuahang:client:set:store:items', -1, ItemData, Amount, Shop)
end)