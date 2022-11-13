
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('xt-haicam:getOrange', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('orange', 2)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['orange'], "add", 2)
end)


RegisterServerEvent('xt-haicam:getPackOrange', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('orange', 20)
    Player.Functions.AddItem('packed_orange', 5)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['orange'], "remove", 20)
	TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['packed_orange'], "add", 4)
end)


