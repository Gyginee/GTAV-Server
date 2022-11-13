local QBCore = exports['qb-core']:GetCoreObject()
  
QBCore.Functions.CreateCallback('xt-cansa:server:GetConfig', function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback('xt-cansa:server:has:nugget', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local ItemNugget = Player.Functions.GetItemByName("wet-dry")
    local ItemBag = Player.Functions.GetItemByName("plastic-bag")
	if ItemNugget ~= nil and ItemBag ~= nil then
        if ItemNugget.amount >= 5 and ItemBag.amount >= 1 then
            cb(true)
		else
            cb(false)
		end
	   else
        cb(false)
	end
end)

RegisterServerEvent('xt-cansa:server:weed:reward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RandomValue = math.random(1, 1000)
    if RandomValue >= 100 and RandomValue < 650 then
        local SubValue = math.random(1,3)
        if SubValue == 1 then
            Player.Functions.AddItem('wet-tak', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-tak'], "add")
        elseif SubValue == 2 then
            Player.Functions.AddItem('wet-tak', 2)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-tak'], "add", 2)
        else
            Player.Functions.AddItem('wet-tak', 3)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-tak'], "add", 3)
        end
    elseif RandomValue >= 750 and RandomValue < 820 then
        local SubValue = math.random(1,50)
        if SubValue == 1 then
            Player.Functions.AddItem('wet-tak', 5)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-tak'], "add", 5)
        else
            Player.Functions.AddItem('wet-tak', 3)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-tak'], "add", 3)
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Cây này chưa thể thu hoạch!", 5000, 'error')
    end
end)

RegisterServerEvent('xt-cansa:server:chebien:reward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local number = math.random(1, 200)
        Player.Functions.RemoveItem('wood', 1)
        Player.Functions.RemoveItem('wet-tak', 1)
        Player.Functions.AddItem('wet-dry', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wood'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-tak'], "remove")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-dry'], "add")
    if number >= 140 then
        Player.Functions.AddItem('wet-bud', 2)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-bud'], "add", 2)
    end
end)

RegisterServerEvent('xt-cansa:server:donggoi:reward')
AddEventHandler('xt-cansa:server:donggoi:reward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('plastic-bag', 1)
    Player.Functions.RemoveItem('wet-dry', 5)
    Player.Functions.AddItem('weed_skunk', 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weed_skunk'], "add", 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['wet-dry'], "remove", 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['plastic-bag'], "remove")
end)
