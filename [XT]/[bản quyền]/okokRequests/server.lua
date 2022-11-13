QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('okokRequests:ShowMenuData', function(id, time, title, message, trigger, side, parameters, parametersNum)
	TriggerClientEvent('okokRequests:ShowMenu', id, source, time, title, message, trigger, side, parameters, parametersNum)
end)

RegisterNetEvent('okokRequests:ExecuteClient', function(id, trigger, parameters, parametersNum)
	if parametersNum == 0 or parameters == nil or parametersNum == nil then
		TriggerClientEvent(trigger, id)
	elseif parametersNum == 1 then
		TriggerClientEvent(trigger, id, parameters)
	elseif parametersNum == 2 then
		local param1, param2 = parameters:match("([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2)
	elseif parametersNum == 3 then
		local param1, param2, param3 = parameters:match("([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3)
	elseif parametersNum == 4 then
		local param1, param2, param3, param4 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3, param4)
	elseif parametersNum == 5 then
		local param1, param2, param3, param4, param5 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3, param4, param5)
	end
end)

RegisterNetEvent('okokRequests:AcceptedMessage', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('xt-notify:client:Alert', id, "HỆ THỐNG", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." đồng ý!", 5000, 'success')
end)

RegisterNetEvent('okokRequests:DeniedMessage', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('xt-notify:client:Alert', id, "HỆ THỐNG", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." từ chối!", 5000, 'error')
end)

RegisterNetEvent('okokRequests:ExpiredMessage', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('xt-notify:client:Alert', id, "HỆ THỐNG", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." không phản hồi!", 5000, 'warning')
end)

RegisterNetEvent('okokRequests:BlockedMessage', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('xt-notify:client:Alert', id, "HỆ THỐNG", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." khoá yêu cầu!", 5000, 'warning')
end)

RegisterNetEvent('okokRequests:SomeoneTriedMessage', function(id)
	local src = source
	local Player = QBCore.Functions.GetPlayer(id)
	TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.." đã gửi yêu cầu cho bạn! Dùng '/yeucau' để mở khoá", 5000, 'info')
end)