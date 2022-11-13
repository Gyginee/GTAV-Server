local QBCore = exports['qb-core']:GetCoreObject()
local GangaccountGangs = {}

CreateThread(function()
	Wait(500)
	local gangmenu = MySQL.Sync.fetchAll('SELECT * FROM gangmenu', {})
	if not gangmenu then
		return
	end
	for k,v in pairs(gangmenu) do
		local k = tostring(v.job_name)
		local v = tonumber(v.amount)
		if k and v then
			GangaccountGangs[k] = v
		end
	end
end)

RegisterNetEvent("qb-gangmenu:server:withdrawMoney", function(amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local gang = xPlayer.PlayerData.gang.name

	if not GangaccountGangs[gang] then
		GangaccountGangs[gang] = 0
	end

	if GangaccountGangs[gang] >= amount and amount > 0 then
		GangaccountGangs[gang] = GangaccountGangs[gang] - amount
		xPlayer.Functions.AddMoney("cash", amount, 'Boss menu withdraw')
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Số dư không khả dụng", 5000, 'error')
		TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
		return
	end

	MySQL.Async.execute('UPDATE gangmenu SET amount = ? WHERE job_name = ?', { GangaccountGangs[gang], gang })
	TriggerEvent('qb-log:server:CreateLog', 'gangmenu', 'Rút tiền', 'yellow', xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname .. ' đã rút $' .. amount .. ' (' .. gang .. ')', false)
	TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã rút $"..amount, 5000, 'success')
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-gangmenu:server:depositMoney", function(amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local gang = xPlayer.PlayerData.gang.name

	if not GangaccountGangs[gang] then
		GangaccountGangs[gang] = 0
	end

	if xPlayer.Functions.RemoveMoney("cash", amount) then
		GangaccountGangs[gang] = GangaccountGangs[gang] + amount
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Số dư không khả dụng", 5000, 'error')
		TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
		return
	end

	MySQL.Async.execute('UPDATE gangmenu SET amount = ? WHERE job_name = ?', { GangaccountGangs[gang], gang })
	TriggerEvent('qb-log:server:CreateLog', 'gangmenu', 'Gửi tiền', 'yellow', xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname .. ' đã gửi $' .. amount .. ' (' .. gang .. ')', false)
	TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã gửi $"..amount, 5000, 'success')
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-gangmenu:server:addaccountGangMoney", function(accountGang, amount)
	if not GangaccountGangs[accountGang] then
		GangaccountGangs[accountGang] = 0
	end

	GangaccountGangs[accountGang] = GangaccountGangs[accountGang] + amount
	MySQL.Async.execute('UPDATE gangmenu SET amount = ? WHERE job_name = ?', { GangaccountGangs[accountGang], accountGang })
end)

RegisterNetEvent("qb-gangmenu:server:removeaccountGangMoney", function(accountGang, amount)
	if not GangaccountGangs[accountGang] then
		GangaccountGangs[accountGang] = 0
	end

	if GangaccountGangs[accountGang] >= amount then
		GangaccountGangs[accountGang] = GangaccountGangs[accountGang] - amount
	end

	MySQL.Async.execute('UPDATE gangmenu SET amount = ? WHERE job_name = ?', { GangaccountGangs[accountGang], accountGang })
end)

QBCore.Functions.CreateCallback('qb-gangmenu:server:GetAccount', function(source, cb, GangName)
	local gangmoney = GetaccountGang(GangName)
	cb(gangmoney)
end)

-- Export
function GetaccountGang(accountGang)
	return GangaccountGangs[accountGang] or 0
end

-- Get Employees
QBCore.Functions.CreateCallback('qb-gangmenu:server:GetEmployees', function(source, cb, gangname)
	local src = source
	local employees = {}
	if not GangaccountGangs[gangname] then
		GangaccountGangs[gangname] = 0
	end
	local players = MySQL.Sync.fetchAll("SELECT * FROM `players` WHERE `gang` LIKE '%".. gangname .."%'", {})
	if players[1] ~= nil then
		for key, value in pairs(players) do
			local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)

			if isOnline then
				employees[#employees+1] = {
				empSource = isOnline.PlayerData.citizenid,
				grade = isOnline.PlayerData.gang.grade,
				isboss = isOnline.PlayerData.gang.isboss,
				name = '🟢' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
				}
			else
				employees[#employees+1] = {
				empSource = value.citizenid,
				grade =  json.decode(value.gang).grade,
				isboss = json.decode(value.gang).isboss,
				name = '❌' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
				}
			end
		end
	end
	cb(employees)
end)

-- Grade Change
RegisterNetEvent('qb-gangmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.Functions.SetGang(Player.PlayerData.gang.name, data.grado) then
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Thăng chức thành công", 5000, 'success')
			TriggerClientEvent('xt-notify:client:Alert', Employee.PlayerData.source,"THÔNG BÁO", "Bạn đã được thăng chức thành "..data.nomegrado, 5000, 'success')
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Chức vụ không tồn tại", 5000, 'error')
		end
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Công dân không trong thành phố", 5000, 'error')
	end
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Fire Member
RegisterNetEvent('qb-gangmenu:server:FireMember', function(target)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(target)
	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.Functions.SetGang("none", '0') then
				TriggerEvent("qb-log:server:CreateLog", "gangmenu", "Đuổi", "orange", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' đã đuổi ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
				TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Thành viên đã bị đuổi", 5000, 'success')
				TriggerClientEvent('xt-notify:client:Alert', Employee.PlayerData.source,"THÔNG BÁO", "Bạn đã bị đuổi khỏi Băng đảng", 5000, 'error')
			else
				TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Thất bại", 5000, 'error')
			end
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không thể đuổi chính mình", 5000, 'error')
		end
	else
		local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', {target})
		if player[1] ~= nil then
			Employee = player[1]
			local gang = {}
			gang.name = "none"
			gang.label = "No Affiliation"
			gang.payment = 0
			gang.onduty = true
			gang.isboss = false
			gang.grade = {}
			gang.grade.name = nil
			gang.grade.level = 0
			MySQL.Async.execute('UPDATE players SET gang = ? WHERE citizenid = ?', {json.encode(gang), target})
			TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Thành viên đã bị đuổi", 5000, 'success')
			TriggerEvent("qb-log:server:CreateLog", "gangmenu", "Đuổi", "orange", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' đã đuổi ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Công dân không trong thành phố", 5000, 'error')
		end
	end
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-gangmenu:server:HireMember', function(recruit)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Target = QBCore.Functions.GetPlayer(recruit)
	if Player.PlayerData.gang.isboss == true then
		if Target and Target.Functions.SetGang(Player.PlayerData.gang.name, 0) then
			TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn đã mời ".. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .." với tư cách ".. Player.PlayerData.gang.label, 5000, 'success')
			TriggerClientEvent('QBCore:Notify', Target.PlayerData.source , "You have been hired as " .. Player.PlayerData.gang.label .. "", "success")
			TriggerClientEvent('xt-notify:client:Alert', Target.PlayerData.source, "THÔNG BÁO", "Bạn đã được mời với tư cách ".. Player.PlayerData.gang.label, 5000, 'success')
			TriggerEvent('qb-log:server:CreateLog', 'gangmenu', 'Mời', 'yellow', (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname).. ' đã mời ' .. Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.gang.name .. ')', false)
		end
	end
	TriggerClientEvent('qb-gangmenu:client:OpenMenu', src)
end)

-- Get closest player sv
QBCore.Functions.CreateCallback('qb-gangmenu:getplayers', function(source, cb)
	local src = source
	local players = {}
	local PlayerPed = GetPlayerPed(src)
	local pCoords = GetEntityCoords(PlayerPed)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local targetped = GetPlayerPed(v)
		local tCoords = GetEntityCoords(targetped)
		local dist = #(pCoords - tCoords)
		if PlayerPed ~= targetped and dist < 10 then
			local ped = QBCore.Functions.GetPlayer(v)
			players[#players+1] = {
			id = v,
			coords = GetEntityCoords(targetped),
			name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
			citizenid = ped.PlayerData.citizenid,
			sources = GetPlayerPed(ped.PlayerData.source),
			sourceplayer = ped.PlayerData.source
			}
		end
	end
		table.sort(players, function(a, b)
			return a.name < b.name
		end)
	cb(players)
end)
