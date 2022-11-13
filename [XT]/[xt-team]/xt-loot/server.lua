

local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("case", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem("case", 1, item.slot) then
        TriggerClientEvent('xt-vongquay:client:dunghom', source, "case")
    end
end)
RegisterServerEvent('xt-vongquay:server:nhantien' , function(sotien)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		Player.Functions.AddMoney('cash', sotien, 'quay-hom')
		TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn đã nhận được <span style='color:#47cf73'>"..sotien.."$</span>", 5000, 'success')
	end
end)
RegisterServerEvent('xt-vongquay:server:nhando' , function(ten, soluong)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player ~= nil then
		TriggerEvent('QBCore:CallCommand', "sv", { src, ten, soluong })
		TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn đã nhận được x"..soluong.." "..QBCore.Shared.Items[ten].label, 5000, 'success')
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



RegisterServerEvent("mkbuss:boradcast")
AddEventHandler("mkbuss:boradcast", function(tier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if Config["broadcast"] then
        tier = tonumber(tier)
        if Config["broadcast_tier"][tier] == true then
            TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2Gachapon: ' .. GetPlayerName(source) .. ' Got '..Config["chance"][tier].name) 
        end
    end
end)
 ]]