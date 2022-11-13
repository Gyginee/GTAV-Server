local QBCore = exports['qb-core']:GetCoreObject()

local Webhook = 'https://discord.com/api/webhooks/926487811857711164/rYQ37V6437cOShJZfpSZED0JEPg4ADMxHOEUbdoQqpJqAH7JGPt8apd0v_1hOVVUHiUZ'

RegisterServerEvent('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local tPlayer = QBCore.Functions.GetPlayer(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
		['@plate'] = plate
	}, function(result)
		if Config.RemoveMoneyOnSign then
			local bankMoney = tPlayer.PlayerData.money.bank
			if result[1] ~= nil  then
				if bankMoney >= vehicle_price then
					MySQL.Async.fetchAll('UPDATE player_vehicles SET citizenid = @target WHERE citizenid = @owner AND plate = @plate', {
						['@owner'] = xPlayer.PlayerData.citizenid,
						['@target'] = tPlayer.PlayerData.citizenid,
						['@plate'] = plate
					}, function (result2)
						if result2 ~= 0 then	
							tPlayer.Functions.RemoveMoney('bank', vehicle_price)
							xPlayer.Functions.AddMoney('bank', vehicle_price)
							TriggerEvent('xt-vehiclekeys:server:give:keys', target, plate, true)
							TriggerClientEvent('xt-notify:client:Alert', _source, "BÁN XE", "Bạn đã bán thành công phương tiện <b>"..model.."</b> với biển số <b>"..plate.."</b>", 5000, 'success')
							TriggerClientEvent('xt-notify:client:Alert', target, "BÁN XE", "Bạn đã mua thành công phương tiện <b>"..model.."</b> với biển số <b>"..plate.."</b>", 5000, 'success')
							if Webhook ~= '' then
								sellVehicleWebhook(webhookData)
							end
						end
					end)
				else
					TriggerClientEvent('xt-notify:client:Alert', _source, "BÁN XE", target_name.." không đủ tiền để mua phương tiện của bạn", 5000, 'error')
					TriggerClientEvent('xt-notify:client:Alert', target, "BÁN XE", "Bạn không đủ tiền để mua phương tiện của "..source_name.."", 5000, 'error')
				end
			else
				TriggerClientEvent('xt-notify:client:Alert', _source, "BÁN XE", "Phương tiện với biển số <b>"..plate.."</b> không thuộc về bạn", 5000, 'error')
				TriggerClientEvent('xt-notify:client:Alert', target, "BÁN XE", source_name.." cố gắng bán cho bạn phương tiện không thuộc về họ", 5000, 'error')
			end
		else
			if result[1] ~= nil then
				MySQL.Async.fetchAll('UPDATE player_vehicles SET citizenid = @target WHERE citizenid = @owner AND plate = @plate', {
					['@owner'] = xPlayer.PlayerData.citizenid,
					['@target'] = tPlayer.PlayerData.citizenid,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then
						TriggerEvent('qg-vehiclekeys:server:give:keys', target, plate, true)
						TriggerClientEvent('xt-notify:client:Alert', _source, "BÁN XE", "Bạn đã bán thành công phương tiện <b>"..model.."</b> với biển số xe <b>"..plate.."</b>", 5000, 'success')
						TriggerClientEvent('xt-notify:client:Alert', target, "BÁN XE", "Bạn đã mua thành công phương tiện <b>"..model.."</b> với biển số xe <b>"..plate.."</b>", 5000, 'success')
						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent('xt-notify:client:Alert', _source, "BÁN XE", "Phương tiện với biển số <b>"..plate.."</b> Không phải của bạn", 5000, 'error')
				TriggerClientEvent('xt-notify:client:Alert', target, "BÁN XE", source_name.." Cố gắng bán cho bạn phương tiện không thuộc về họ", 5000, 'error')
			end
		end
	end)
end)

QBCore.Functions.CreateCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = QBCore.Functions.GetPlayer(targetid)
	local targetname = json.encode(target.PlayerData.charinfo.firstname.." "..target.PlayerData.charinfo.lastname)
	cb(targetname)
end)

RegisterServerEvent('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local name = json.encode(xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname)
	TriggerClientEvent('okokContract:GetVehicleInfo', _source, name, os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
	TriggerClientEvent('okokContract:startContractAnimation', data.targetID)
	if Config.RemoveContractAfterUse then
		xPlayer.Functions.RemoveItem('contract', 1)
	end
end)

QBCore.Functions.CreateUseableItem('contract', function(source)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	TriggerClientEvent('okokContract:OpenContractInfo', _source)
	TriggerClientEvent('okokContract:startContractAnimation', _source)
end)
--[[ 
QBCore.Functions.CreateUseableItem('contract1', function(source)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	if xPlayer.PlayerData.job.name == "cardealer" then
		TriggerClientEvent('okokContract:OpenContractInfo', _source)
		TriggerClientEvent('okokContract:startContractAnimation', _source)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn không phải là Nhân viên bán xe", 5000, 'error')
	end
end) ]]
-------------------------- SELL BÁN XE WEBHOOK

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'BÁN XE SALE',
			["description"] = '**Phương tiện: **'..data.model..'**\nBiển số: **'..data.plate..'**\nNgười mua: **'..data.target_name..'**\nNgười bán: **'..data.source_name..'**\nGiá xe: **'..data.vehicle_price..'$',

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end