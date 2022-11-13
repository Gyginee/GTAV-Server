QBCore = exports['qb-core']:GetCoreObject()


-- // Events \\ --

RegisterNetEvent('xt-doben:client:set:current:tool')
AddEventHandler('xt-doben:client:set:current:tool', function(data)
    if data ~= false then
        Config.CurrentToolData = data
    end
end)

RegisterNetEvent('xt-doben:client:set:quality')
AddEventHandler('xt-doben:client:set:quality', function(amount)
    if Config.CurrentToolData ~= nil then
        TriggerServerEvent("xt-doben:server:SetToolQuality", Config.CurrentToolData, amount)
    end
end)

function UpdateToolQuality(amount)
    if Config.CurrentToolData ~= nil  then
        TriggerServerEvent("xt-doben:server:UpdateToolQuality", Config.CurrentToolData, amount)
    end
end