local QBCore = exports['qb-core']:GetCoreObject()

-- Code

RegisterServerEvent('xt-alerts:server:send:alert', function(data, forBoth)
    forBoth = forBoth ~= nil and forBoth or false
    TriggerClientEvent('xt-alerts:client:send:alert', -1, data, forBoth)
end)