-- MADE BY Q4D
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('xt-tieuphu:pickcotton', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.AddItem('wood', 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['wood'], "add", 2)
    end
end)

RegisterServerEvent('xt-tieuphu:weaving', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.RemoveItem('wood', 5)
        Player.Functions.AddItem('cutted_wood', 5)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['wood'], "remove", 5)
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['cutted_wood'], "add", 5)
    end
end)

RegisterServerEvent('xt-tieuphu:sewing', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.RemoveItem('cutted_wood', 5)
        Player.Functions.AddItem('packaged_plank', 5)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['cutted_wood'], "remove", 5)
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['packaged_plank'], "add")
    end
end)
