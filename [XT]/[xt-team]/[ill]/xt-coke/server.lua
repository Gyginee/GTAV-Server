local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('xt-coke:updateTable', function(bool)
    TriggerClientEvent('xt-coke:syncTable', -1, bool)
end)

local hiddenprocess = vector3(1952.517578125,5179.2705078125,47.963077545166) -- Change this to whatever location you want. This is server side to prevent people from dumping the coords

local hiddenstart = vector3(2122.2004394531,4784.7919921875,40.970275878906) -- Change this to whatever location you want. This is server side to prevent people from dumping the coords

QBCore.Functions.CreateCallback('xt-coke:processcoords', function(source, cb)
    cb(hiddenprocess)
end)

QBCore.Functions.CreateCallback('xt-coke:startcoords', function(source, cb)
    cb(hiddenstart)
end)

QBCore.Functions.CreateCallback('xt-coke:pay', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = Config.Tiencoc
	local cashamount = Player.PlayerData.money["cash"]
    local bankamount = Player.PlayerData.money["bank"]
	if cashamount >= amount then
		Player.Functions.RemoveMoney('cash', amount)
    	cb(true)
    elseif bankamount >= amount then
        Player.Functions.RemoveMoney('bank', amount)
    	cb(true)
	else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn cần "..amount.."$ để thuê máy bay", 5000, 'error')
		cb(false)
	end
end)

RegisterServerEvent('xt-coke:server:reward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RandomValue = math.random(1, 10)
    if RandomValue < 9 then
		Player.Functions.AddItem('coke_brick', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coke_brick'], "add", 1)
    else
		Player.Functions.AddItem('coke_brick', 2)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coke_brick'], "add", 2)
    end
end)

RegisterServerEvent('xt-coke:server:donggoi')
AddEventHandler('xt-coke:server:donggoi', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('plastic-bag').amount > 1 then
		Player.Functions.RemoveItem('coke_brick', 1)
		Player.Functions.RemoveItem('plastic-bag', 2)
		Player.Functions.AddItem('cokebaggy', 2)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coke_brick'], "remove")
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['plastic-bag'], "remove", 2)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cokebaggy'], "add", 2)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn không đủ nguyên liệu (Cần 1x "..QBCore.Shared.Items['coke_brick'].label.." và 2x "..QBCore.Shared.Items['plastic-bag'].label, 5000, 'error')
    end
end)