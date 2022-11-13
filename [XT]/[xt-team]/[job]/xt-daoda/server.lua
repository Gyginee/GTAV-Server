-- MADE BY Q4D
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('xt-daoda:client:getstone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('stone', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['stone'], "add", 1)
end)


RegisterServerEvent('xt-daoda:washStone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.RemoveItem('stone', 5)
        Player.Functions.AddItem('washedstone', 5)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['stone'], "remove", 5)
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['washedstone'], "add", 5)
    end
end)

RegisterServerEvent('xt-daoda:meltStone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randomChance = math.random(1, 100)
    if Player ~= nil then
        if randomChance < 2 then
            Player.Functions.RemoveItem('washedstone', 5)
            Player.Functions.AddItem('diamond', 1)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['washedstone'], "remove", 5)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['diamond'], "add")
        elseif randomChance >= 2 and randomChance < 20 then
            Player.Functions.RemoveItem('washedstone', 5)
            Player.Functions.AddItem('gold', 5)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['washedstone'], "remove", 5)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['gold'], "add", 5)
        elseif randomChance >= 20 and randomChance < 50 then
            Player.Functions.RemoveItem('washedstone', 5)
            Player.Functions.AddItem('iron', 10)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['washedstone'], "remove", 5)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['iron'], "add", 10)
        elseif randomChance >= 50 and randomChance <= 100 then
            Player.Functions.RemoveItem('washedstone', 5)
            Player.Functions.AddItem('copper', 20)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['washedstone'], "remove", 5)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['copper'], "add", 20)
        end
    end
end)



