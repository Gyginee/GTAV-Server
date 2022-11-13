QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('xt-vatsua:getMilk', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('milk_bottle', 1)
    Player.Functions.RemoveItem('glass_bottle', 1)
	TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['milk_bottle'], "add")
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['glass_bottle'], "remove")
end)

RegisterServerEvent('xt-vatsua:getfreshMilk', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then 
        Player.Functions.RemoveItem('milk_bottle', 1)
        Player.Functions.AddItem('milk', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['milk_bottle'], "remove")
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['milk'], "add")
    end
end)


