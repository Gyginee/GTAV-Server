QBCore = exports['qb-core']:GetCoreObject()
local menhgia = math.random(150, 200)
-- Code

QBCore.Functions.CreateCallback("xt-traphouse:server:get:config", function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback("xt-traphouse:server:pin:code", function(source, cb)
    cb(Config.TrapHouseCode)
end)

QBCore.Functions.CreateCallback('xt-traphouse:pay', function(source, cb)
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
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn cần "..amount.."$ để thuê xe tải", 5000, 'error')
		cb(false)
	end
end)
CreateThread(function()
    while true do
        Wait(4)
        Config.TrapHouseCode = math.random(1111,9999)
        print('Mã con lợn: '..Config.TrapHouseCode)
        Wait((1000 * 60) * 60)
    end
end)

RegisterServerEvent('xt-traphouse:server:bando', function(name, gia, soluong)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(name, soluong)
    local nhan = gia * soluong
    Player.Functions.AddItem('tienban', nhan)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "remove", soluong)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "add", nhan)
end)

RegisterServerEvent('xt-traphouse:server:muado', function(name, ton, soluong)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('tienban', ton)
    Player.Functions.AddItem(name, soluong)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "add", soluong)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "remove", ton)
end)

RegisterServerEvent('xt-traphouse:server:ruatien', function()
    local src = source
    local sl = math.random(50, 75)
    local Player = QBCore.Functions.GetPlayer(src)
    local co = Player.Functions.GetItemByName('tienban').amount
    if co < sl then
        local doiduoc = co * menhgia
        Player.Functions.RemoveItem('tienban', co)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "remove", co)
        Player.Functions.AddMoney('cash', doiduoc, 'rua-tien')
    else
        local doiduoc = sl * menhgia
        Player.Functions.RemoveItem('tienban', sl)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "remove", sl)
        Player.Functions.AddMoney('cash', doiduoc, 'rua-tien')
    end
end)

RegisterServerEvent('xt-traphouse:server:cuopNPC', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RandomValue = math.random(1, 50)
    local tien = math.random(150, 200)
    if RandomValue <= 20 then
        Player.Functions.AddItem("stickynote", 1, false, {label = 'Mã Con lợn: '..tonumber(Config.TrapHouseCode)})
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stickynote"], "add")
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn đã nhận được một mẩu giấy", 5000, 'success')
    else
        Player.Functions.AddMoney('cash', tien, 'rua-tien')
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn đã cướp được "..tien.."$", 5000, 'success')
    end
end)
