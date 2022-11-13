QBCore = exports['qb-core']:GetCoreObject()

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

RegisterNetEvent('xt-cardealer:server:muaxe',function(vehmodel, gia)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bankMoney = Player.PlayerData.money.bank
    local model = vehmodel:lower()
    if bankMoney > gia then
        Player.Functions.RemoveMoney('bank', gia)
        TriggerClientEvent('xt-notify:client:Alert', src, "Bạn vừa nhận được một chiếc xe mới", 5000, 'success')
        local newplate = GeneratePlate()
        newplate = newplate:gsub("%s+", "")
        TriggerClientEvent('xt-cardealer:client:setOwner', src, newplate)
        TriggerEvent('qb-log:server:CreateLog', 'vehicleshop', 'BÁN XE', "blue", Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname.."đã mua \nXe: "..model.."")
            MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                Player.PlayerData.citizenid,
                model,
                GetHashKey(model),
                '{}',
                newplate,
                'pillboxgarage',
                0
            })
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", 'Bạn không đủ tiền', 5000, 'error')
    end
end)

QBCore.Commands.Add("muaxe", "Mua phương tiện này", {} , false, function(source,args)
    local src = source
    TriggerClientEvent('xt-cardealer:client:banxe', src)
end)

QBCore.Commands.Add("laithu", "Lái thử phương tiện này", {} , false, function(source,args)
    local src = source
    TriggerClientEvent("xt-cardealer:client:TestDrive", src)
end)

function GeneratePlate()
    local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate}, function(result)
        while (result[1] ~= nil) do
            plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
        end
        return plate
    end)
    return plate:upper()
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
