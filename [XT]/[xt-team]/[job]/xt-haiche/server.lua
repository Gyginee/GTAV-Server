
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('xt-haiche:getTea', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local sl = 1
    if Player ~= nil then
        Player.Functions.AddItem('tea', sl)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['tea'], "add", sl)
    end
end)


RegisterServerEvent('xt-haiche:getDryTea', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        if Player.Functions.GetItemByName('tea').amount >= 5 then
            Player.Functions.RemoveItem('tea', 5)
            Player.Functions.AddItem('drytea', 1)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['tea'], "remove", 5)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['drytea'], "add", 1)
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['tea'].label, 5000, 'error')
        end
    end
end)
RegisterServerEvent('xt-haiche:getMatcha', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        if Player.Functions.GetItemByName('drytea').amount >= 10 then
            Player.Functions.RemoveItem('drytea', 10)
            Player.Functions.AddItem('matcha', 10)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['drytea'], "remove", 10)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['matcha'], "add", 10)

        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['drytea'].label, 5000, 'error')
        end
    end
end)


