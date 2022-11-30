local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("case", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem("case", 1, item.slot) then
		TriggerClientEvent('xt-vongquay:client:dunghom', source, "case")
	end
end)
RegisterServerEvent('xt-vongquay:server:nhantien', function(sotien)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.Functions.AddMoney('cash', sotien, 'quay-hom')
		TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG",
			"Bạn đã nhận được <span style='color:#47cf73'>" .. sotien .. "$</span>", 5000, 'success')
	end
end)
RegisterServerEvent('xt-vongquay:server:nhando', function(ten, soluong)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local item = QBCore.Shared.Items[ten]
	
	if Player ~= nil then
		TriggerEvent('QBCore:CallCommand', "sv", { src, ten, soluong })
		if item.type =='item' then
			Player.Functions.AddItem(item, soluong)
		elseif item.type =='weapon'then
			Player.Functions.AddItem(item, soluong,false, {serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)), ammo = 1, quality = 100.0})
			TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG",
			"Chay" .. QBCore.Shared.Items[tostring(ten)], 5000, 'success')
		end
	
		TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG",
			"Bạn đã nhận được x" .. soluong .. " " .. QBCore.Shared.Items[ten].label, 5000, 'success')
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ten], 'add', soluong)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message staff"><i class="fas fa-gift"></i> <b><span style="color: #1ebc62">[Quà Tặng]</span>&nbsp;</b><div style="margin-top: 5px; font-weight: 300;">{0}</div></div>',
			args = { '^2Người chơi: ' .. GetPlayerName(source) .. ' may mắn trúng ' .. QBCore.Shared.Items[ten].label }
		})
		
		--TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2Người chơi: ' .. GetPlayerName(source) .. ' may mắn trúng '..QBCore.Shared.Items[ten].label)
	end
end)
--[[ 
RegisterServerEvent('mkbuss:giveReward')
AddEventHandler('mkbuss:giveReward', function (t, data, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if t == "item" then
		xPlayer.addInventoryItem(data, amount)
	elseif t == "weapon" then
		xPlayer.addWeapon(data, 1)
	elseif t == "money" then
		xPlayer.addMoney(data)
	elseif t == "black_money" then
		xPlayer.addAccountMoney('black_money', data)
	end
	
end)
]]
