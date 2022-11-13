local ItemTable = {
    "metalscrap",
    "plastic",
    "copper",
    "iron",
    "aluminum",
    "steel",
    "glass",
	"rubber",
}

RegisterServerEvent("qb-bocvac:server:getItem")
AddEventHandler("qb-bocvac:server:getItem", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', 5, 'tienbo')
    for i = 1, math.random(1, 3), 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        local amount = math.random(1, 3)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add')       
        Citizen.Wait(500)
    end

    local chance = math.random(1, 100)
    if chance < 60 then
        Player.Functions.AddItem("plastic", math.random(3, 6), false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["plastic"], "add")
    end
	
	 local chance = math.random(1, 100)
    if chance > 70 then
        Player.Functions.AddItem("metalscrap", math.random(3, 7), false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["aluminum"], "add")
    end

    local Luck = math.random(1, 10)
    local Odd = math.random(1, 10)
    if Luck == Odd then
        local random = math.random(1, 3)
        Player.Functions.AddItem("rubber", random)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rubber"], 'add')
    end
end)
