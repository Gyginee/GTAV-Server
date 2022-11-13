local QBCore = exports['qb-core']:GetCoreObject()
local Accounts = {}

CreateThread(function()
	Wait(500)
	local bossmenu = MySQL.Sync.fetchAll('SELECT * FROM bossmenu', {})
	if not bossmenu then
		return
	end
	for k,v in pairs(bossmenu) do
		local k = tostring(v.job_name)
		local v = tonumber(v.amount)
		if k and v then
			Accounts[k] = v
		end
	end
end)

RegisterNetEvent("qb-bossmenu:server:withdrawMoney", function(amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local job = xPlayer.PlayerData.job.name
	if not Accounts[job] then
		Accounts[job] = 0
	end

	if Accounts[job] >= amount and amount > 0 then
		Accounts[job] = Accounts[job] - amount
		xPlayer.Functions.AddMoney("cash", amount)
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Số dư không khả dụng", 5000, 'error')
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
		return
	end
	MySQL.Async.execute('UPDATE bossmenu SET amount = ? WHERE job_name = ?', { Accounts[job], job})
	TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Rút quỹ', "blue", xPlayer.PlayerData.name.." đã rút $" .. amount .. ' (' .. job .. ')', true)
	TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã rút: $"..amount.." vào quỹ", 5000, 'success')
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qb-bossmenu:server:depositMoney", function(amount)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local job = xPlayer.PlayerData.job.name
	if not Accounts[job] then
		Accounts[job] = 0
	end

	if xPlayer.Functions.RemoveMoney("cash", amount) then
		Accounts[job] = Accounts[job] + amount
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Số dư không khả dụng", 5000, 'error')
		TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
		return
	end

	MySQL.Async.execute('UPDATE bossmenu SET amount = ? WHERE job_name = ?', { Accounts[job], job })
	TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Gửi tiền', "blue", xPlayer.PlayerData.name.. "đã gửi $" .. amount .. ' (' .. job .. ')', true)
	TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã gửi: $"..amount.." vào quỹ", 5000, 'success')
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)
RegisterServerEvent("qb-bossmenu:server:okokBillingDeposit", function(job, amount)
    local src = source
    if not Accounts[job] then
        Accounts[job] = 0
    end
    Accounts[job] = Accounts[job] + amount
    MySQL.Async.execute('UPDATE bossmenu SET amount = ? WHERE job_name = ?', { Accounts[job], job })
	TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Thanh toán hoá đơn', "blue", "Đã thanh toán "..amount.." ("..job..")")
end)

RegisterNetEvent("qb-bossmenu:server:addAccountMoney", function(account, amount)
	if not Accounts[account] then
		Accounts[account] = 0
	end

	Accounts[account] = Accounts[account] + amount
	MySQL.Async.execute('UPDATE bossmenu SET amount = ? WHERE job_name = ?', { Accounts[account], account })
end)

RegisterNetEvent("qb-bossmenu:server:removeAccountMoney", function(account, amount)
	if not Accounts[account] then
		Accounts[account] = 0
	end

	if Accounts[account] >= amount then
		Accounts[account] = Accounts[account] - amount
	end

	MySQL.Async.execute('UPDATE bossmenu SET amount = ? WHERE job_name = ?', { Accounts[account], account })
end)

QBCore.Functions.CreateCallback('qb-bossmenu:server:GetAccount', function(source, cb, jobname)
	local result = GetAccount(jobname)
	cb(result)
end)

-- Export
function GetAccount(account)
	print(Accounts[account])
	return Accounts[account] or 0
end

-- Get Employees
QBCore.Functions.CreateCallback('qb-bossmenu:server:GetEmployees', function(source, cb, jobname)
	local src = source
	local employees = {}
	if not Accounts[jobname] then
		Accounts[jobname] = 0
	end
	local players = MySQL.Sync.fetchAll("SELECT * FROM `players` WHERE `job` LIKE '%".. jobname .."%'", {})
	if players[1] ~= nil then
		for key, value in pairs(players) do
			local isOnline = QBCore.Functions.GetPlayerByCitizenId(value.citizenid)

			if isOnline then
				employees[#employees+1] = {
				empSource = isOnline.PlayerData.citizenid, 
				grade = isOnline.PlayerData.job.grade,
				isboss = isOnline.PlayerData.job.isboss,
				name = '🤴 ' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
				}
			else
				employees[#employees+1] = {
				empSource = value.citizenid, 
				grade =  json.decode(value.job).grade,
				isboss = json.decode(value.job).isboss,
				name = '❌ ' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
				}
			end
		end
		table.sort(employees, function(a, b)
            return a.grade.level > b.grade.level
        end)
	end
	cb(employees)
end)

-- Grade Change
RegisterNetEvent('qb-bossmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.Functions.SetJob(Player.PlayerData.job.name, data.grado) then
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Thăng chức thành công", 5000, 'success')
			TriggerClientEvent('xt-notify:client:Alert', Employee.PlayerData.source,"THÔNG BÁO", "Bạn đã được thăng chức thành "..data.nomegrado, 5000, 'success')
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Chức vụ không tồn tại", 5000, 'error')
		end
	else
		TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Công dân không trong thành phố", 5000, 'error')
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Fire Employee
RegisterNetEvent('qb-bossmenu:server:FireEmployee', function(target)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Employee = QBCore.Functions.GetPlayerByCitizenId(target)
	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.Functions.SetJob("unemployed", '0') then
				TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Đuổi việc", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' đã đuổi việc ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.job.name .. ")", false)
				TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Sa thải thành công", 5000, 'success')
				TriggerClientEvent('xt-notify:client:Alert', Employee.PlayerData.source,"THÔNG BÁO", "Bạn đã bị sa thải", 5000, 'error')
			else
				TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Thất bại", 5000, 'error')
			end
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không thể sa thải chính mình", 5000, 'error')
		end
	else
		local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { target })
		if player[1] ~= nil then
			Employee = player[1]
			local job = {}
			job.name = "unemployed"
			job.label = "Thất nghiệp"
			job.payment = 500
			job.onduty = true
			job.isboss = false
			job.grade = {}
			job.grade.name = nil
			job.grade.level = 0
			MySQL.Async.execute('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(job), target })
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Đuổi việc thành công", 5000, 'success')
			TriggerEvent("qb-log:server:CreateLog", "bossmenu", "Đuổi việc", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' đã đuổi ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.job.name .. ")", false)
		else
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Công dân không trong thành phố", 5000, 'error')
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qb-bossmenu:server:HireEmployee', function(recruit)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local Target = QBCore.Functions.GetPlayer(recruit)
	if Player.PlayerData.job.isboss == true then
		if Target and Target.Functions.SetJob(Player.PlayerData.job.name, 0) then
			TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã thuê ".. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " với tư cách " .. Player.PlayerData.job.label, 5000, 'success')
			TriggerClientEvent('xt-notify:client:Alert', Target.PlayerData.source,"THÔNG BÁO", "Bạn đã được thuê bởi " .. Player.PlayerData.job.label, 5000, 'success')
			TriggerEvent('qb-log:server:CreateLog', 'bossmenu', 'Thuê', "lightgreen", (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname).. " đã thuê " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. ' (' .. Player.PlayerData.job.name .. ')', true)
		end
	end
	TriggerClientEvent('qb-bossmenu:client:OpenMenu', src)
end)



-- Get closest player sv
QBCore.Functions.CreateCallback('qb-bossmenu:getplayers', function(source, cb)
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
