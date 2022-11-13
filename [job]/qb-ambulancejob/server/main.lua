local PlayerInjuries = {}
local PlayerWeaponWounds = {}
local QBCore = exports['qb-core']:GetCoreObject()
-- Events

-- Compatibility with txAdmin Menu's heal options.
-- This is an admin only server side event that will pass the target player id or -1.
AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end

	TriggerClientEvent('xt-benhvien:client:Revive', eventData.id)
	TriggerClientEvent("xt-benhvien:client:HealInjuries", eventData.id, "full")
end)

RegisterNetEvent('xt-benhvien:server:SendToBed', function(bedId, isRevive)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('xt-benhvien:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], isRevive)
	TriggerClientEvent('xt-benhvien:client:SetBed', -1, bedId, true)
	Player.Functions.RemoveMoney("bank", Config.BillCost , "respawned-at-hospital")
	TriggerEvent('qb-bossmenu:server:addAccountMoney', "ambulance", Config.BillCost)
	TriggerClientEvent('xt-benhvien:client:SendBillEmail', src, Config.BillCost)
end)

RegisterNetEvent('xt-benhvien:server:RespawnAtHospital', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	for k, v in pairs(Config.Locations["beds"]) do
		if not v.taken then
			TriggerClientEvent('xt-benhvien:client:SendToBed', src, k, v, true)
			TriggerClientEvent('xt-benhvien:client:SetBed', -1, k, true)
			if Config.WipeInventoryOnRespawn then
				Player.Functions.ClearInventory()
				MySQL.Async.execute('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode({}), Player.PlayerData.citizenid })
				TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã mất hết <span style='color:#ff0000'>tài sản</span>!", 5000, 'error')
			end
			Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
			TriggerEvent('qb-bossmenu:server:addAccountMoney', "ambulance", Config.BillCost)
			TriggerClientEvent('xt-benhvien:client:SendBillEmail', src, Config.BillCost)
			return
		end
	end
	--print("All beds were full, placing in first bed as fallback")

	TriggerClientEvent('xt-benhvien:client:SendToBed', src, 1, Config.Locations["beds"][1], true)
	TriggerClientEvent('xt-benhvien:client:SetBed', -1, 1, true)
	if Config.WipeInventoryOnRespawn then
		Player.Functions.ClearInventory()
		MySQL.Async.execute('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode({}), Player.PlayerData.citizenid })
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã mất hết <span style='color:#ff0000'>tài sản</span>!", 5000, 'error')
	end
	Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
	TriggerEvent('qb-bossmenu:server:addAccountMoney', "ambulance", Config.BillCost)
	TriggerClientEvent('xt-benhvien:client:SendBillEmail', src, Config.BillCost)
end)

RegisterNetEvent('xt-benhvien:server:ambulanceAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = QBCore.Functions.GetQBPlayers()
    for k ,v in pairs(players) do
        if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
			print(v)
            TriggerClientEvent('xt-benhvien:client:ambulanceAlert', v, coords, text)
        end
    end
end)

RegisterNetEvent('xt-benhvien:server:LeaveBed', function(id)
    TriggerClientEvent('xt-benhvien:client:SetBed', -1, id, false)
end)

RegisterNetEvent('xt-benhvien:server:SyncInjuries', function(data)
    local src = source
    PlayerInjuries[src] = data
end)

RegisterNetEvent('xt-benhvien:server:SetWeaponDamage', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		PlayerWeaponWounds[Player.PlayerData.source] = data
	end
end)

RegisterNetEvent('xt-benhvien:server:RestoreWeaponDamage', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	PlayerWeaponWounds[Player.PlayerData.source] = nil
end)

RegisterNetEvent('xt-benhvien:server:SetDeathStatus', function(isDead)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		Player.Functions.SetMetaData("isdead", isDead)
	end
end)

RegisterNetEvent('xt-benhvien:server:SetLaststandStatus', function(bool)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		Player.Functions.SetMetaData("inlaststand", bool)
	end
end)

RegisterNetEvent('xt-benhvien:server:SetArmor', function(PlayerArmor)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local newArmor = amount
        if newArmor <= 0 then
            newArmor = 0
        end
        Player.Functions.SetMetaData('armor', newArmor)
        Player.Functions.Save()
    end
end)

RegisterNetEvent('xt-benhvien:server:TreatWounds', function(playerId)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Patient = QBCore.Functions.GetPlayer(playerId)
	if Patient then
		if Player.PlayerData.job.name =="ambulance" then
			Player.Functions.RemoveItem('bandage', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bandage'], "remove")
			TriggerClientEvent("xt-benhvien:client:HealInjuries", Patient.PlayerData.source, "full")
		end
	end
end)

RegisterNetEvent('xt-benhvien:server:SetDoctor', function()
	local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
            amount = amount + 1
        end
	end
	TriggerClientEvent("xt-benhvien:client:SetDoctorCount", -1, amount)
end)

RegisterNetEvent('xt-benhvien:server:RevivePlayer', function(playerId, isOldMan)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Patient = QBCore.Functions.GetPlayer(playerId)
	local oldMan = isOldMan or false
	if Patient then
		if oldMan then
			if Player.Functions.RemoveMoney("cash", 5000, "revived-player") then
				Player.Functions.RemoveItem('firstaid', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['firstaid'], "remove")
				TriggerClientEvent('xt-benhvien:client:Revive', Patient.PlayerData.source)
			else
				TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không đủ <span style='color:#fc1100'>tiền mặt</span>!", 5000, 'error')
			end
		else
			Player.Functions.RemoveItem('firstaid', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['firstaid'], "remove")
			TriggerClientEvent('xt-benhvien:client:Revive', Patient.PlayerData.source)
		end
	end
end)

RegisterNetEvent('xt-benhvien:server:SendDoctorAlert', function()
    local players = QBCore.Functions.GetQBPlayers()
    for k ,v in pairs(players) do
        if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
			print(source)
			TriggerClientEvent('xt-notify:client:Alert', v.PlayerData.source, "THÔNG BÁO", "Có bệnh nhân cần được <span style='color:#ffd700'>chữa trị</span> tại bệnh viện!", 5000, 'warning')
		end
	end
end)

RegisterNetEvent('xt-benhvien:server:UseFirstAid', function(targetId)
	local src = source
	local Target = QBCore.Functions.GetPlayer(targetId)
	if Target then
		TriggerClientEvent('xt-benhvien:client:CanHelp', targetId, src)
	end
end)

RegisterNetEvent('xt-benhvien:server:CanHelp', function(helperId, canHelp)
	local src = source
	if canHelp then
		TriggerClientEvent('xt-benhvien:client:HelpPerson', helperId, src)
	else
		TriggerClientEvent('xt-notify:client:Alert', helperId,"THÔNG BÁO", "Bạn không thể <span style='color:#fc1100'>giúp</span> người này!", 5000, 'error')
	end
end)

-- Callbacks

QBCore.Functions.CreateCallback('hospital:GetDoctors', function(source, cb)
	local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
			amount = amount + 1
		end
	end
	cb(amount)
end)

QBCore.Functions.CreateCallback('hospital:GetPlayerStatus', function(source, cb, playerId)
	local Player = QBCore.Functions.GetPlayer(playerId)
	local injuries = {}
	injuries["WEAPONWOUNDS"] = {}
	if Player then
		if PlayerInjuries[Player.PlayerData.source] then
			if (PlayerInjuries[Player.PlayerData.source].isBleeding > 0) then
				injuries["BLEED"] = PlayerInjuries[Player.PlayerData.source].isBleeding
			end
			for k, v in pairs(PlayerInjuries[Player.PlayerData.source].limbs) do
				if PlayerInjuries[Player.PlayerData.source].limbs[k].isDamaged then
					injuries[k] = PlayerInjuries[Player.PlayerData.source].limbs[k]
				end
			end
		end
		if PlayerWeaponWounds[Player.PlayerData.source] then
			for k, v in pairs(PlayerWeaponWounds[Player.PlayerData.source]) do
				injuries["WEAPONWOUNDS"][k] = v
			end
		end
	end
    cb(injuries)
end)

QBCore.Functions.CreateCallback('hospital:GetPlayerBleeding', function(source, cb)
	local src = source
	if PlayerInjuries[src] and PlayerInjuries[src].isBleeding then
		cb(PlayerInjuries[src].isBleeding)
	else
		cb(nil)
	end
end)

-- Commands

QBCore.Commands.Add('911e', "Gọi cấp cứu", {{name = 'message', help = "Nội dung"}}, false, function(source, args)
	local src = source
	if args[1] then message = table.concat(args, " ") else message = "Người dân yêu cầu trợ giúp" end
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
            TriggerClientEvent('xt-benhvien:client:ambulanceAlert', v.PlayerData.source, coords, message)
        end
    end
end)

QBCore.Commands.Add("status", "Kiểm tra sức khoẻ", {}, false, function(source, args)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.name == "ambulance" then
		TriggerClientEvent("xt-benhvien:client:CheckStatus", src)
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không phải là <span style='color:#fc1100'>nhân viên y tế</span> người này!", 5000, 'error')
	end
end)

QBCore.Commands.Add("heal", "Chữa trị", {}, false, function(source, args)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.name == "ambulance" then
		TriggerClientEvent("xt-benhvien:client:TreatWounds", src)
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không phải là <span style='color:#fc1100'>nhân viên y tế</span> người này!", 5000, 'error')
	end
end)
QBCore.Commands.Add("hoisinh", "Hồi sinh bản thân(Giá x1000$)", {}, false, function(source, args)
	TriggerClientEvent('xt-benhvien:client:hoisinh', source)
end)
QBCore.Commands.Add("revivep", "Cứu sống", {}, false, function(source, args)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.name == "ambulance" then
		TriggerClientEvent("xt-benhvien:client:RevivePlayer", src)
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không phải là <span style='color:#fc1100'>nhân viên y tế</span> người này!", 5000, 'error')
	end
end)

QBCore.Commands.Add("revive", "Hồi sinh", {{name = "id", help = "ID của người chơi"}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('xt-benhvien:client:Revive', Player.PlayerData.source)
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Người chơi hiện tại không <span style='color:#fc1100'>online</span>!", 5000, 'error')
		end
	else
		TriggerClientEvent('xt-benhvien:client:Revive', src)
	end
end, "admin")

QBCore.Commands.Add("setpain", "Làm bị thương", {{name = "id", help = "ID của người chơi"}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('xt-benhvien:client:SetPain', Player.PlayerData.source)
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Người chơi hiện tại không <span style='color:#fc1100'>online</span>!", 5000, 'error')
		end
	else
		TriggerClientEvent('xt-benhvien:client:SetPain', src)
	end
end, "admin")

QBCore.Commands.Add("kill", "Giết người chơi", {{name = "id", help = "ID của người chơi"}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('xt-benhvien:client:KillPlayer', Player.PlayerData.source)
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Người chơi hiện tại không <span style='color:#fc1100'>online</span>!", 5000, 'error')
		end
	else
		TriggerClientEvent('xt-benhvien:client:KillPlayer', src)
	end
end, "admin")

QBCore.Commands.Add('aheal', "Chữa trị cho người chơi", {{name = 'id', help = "ID của người chơi"}}, false, function(source, args)
	local src = source
	if args[1] then
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player then
			TriggerClientEvent('xt-benhvien:client:adminHeal', Player.PlayerData.source)
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Người chơi hiện tại không <span style='color:#fc1100'>online</span>!", 5000, 'error')
		end
	else
		TriggerClientEvent('xt-benhvien:client:adminHeal', src)
	end
end, 'admin')

-- Items

QBCore.Functions.CreateUseableItem("ifaks", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("xt-benhvien:client:UseIfaks", src)
	end
end)

QBCore.Functions.CreateUseableItem("bandage", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("xt-benhvien:client:UseBandage", src)
	end
end)

QBCore.Functions.CreateUseableItem("painkillers", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("xt-benhvien:client:UsePainkillers", src)
	end
end)

QBCore.Functions.CreateUseableItem("firstaid", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("xt-benhvien:client:UseFirstAid", src)
	end
end)