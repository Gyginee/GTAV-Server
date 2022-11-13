local OutsideVehicles = {}
local QBCore = exports['qb-core']:GetCoreObject()
-- code

QBCore.Functions.CreateCallback("xt-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',
        {plate, pData.PlayerData.citizenid}, function(result)
            if result[1] ~= nil then
                cb(true)
            else
                cb(false)
            end
        end)
end)

QBCore.Functions.CreateCallback("xt-garage:server:GetOutsideVehicles", function(source, cb)
    local Ply = QBCore.Functions.GetPlayer(source)
    local CitizenId = Ply.PlayerData.citizenid
    if OutsideVehicles[CitizenId] ~= nil and next(OutsideVehicles[CitizenId]) ~= nil then
        cb(OutsideVehicles[CitizenId])
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback("xt-garage:server:GetUserVehicles", function(source, cb, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ? AND garage = ?',
    {pData.PlayerData.citizenid, garage}, function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("xt-garage:server:GetVehicleProperties", function(source, cb, plate)
    local src = source
    local properties = {}
    local result = MySQL.Sync.fetchAll('SELECT mods FROM player_vehicles WHERE plate = ?', {plate})
    if result[1] then
        properties = json.decode(result[1].mods)
    end
    cb(properties)
end)

QBCore.Functions.CreateCallback("xt-garage:server:GetDepotVehicles", function(source, cb)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ? AND state = ?',
        {pData.PlayerData.citizenid, 0}, function(result)
            if result[1] ~= nil then
                cb(result)
            else
                cb(nil)
            end
        end)
end)

QBCore.Functions.CreateCallback("xt-garage:server:GetHouseVehicles", function(source, cb, house)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE garage = ?', {house}, function(result)
        if result[1] ~= nil then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("xt-garage:server:checkVehicleHouseOwner", function(source, cb, plate, house)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate}, function(result)
        if result[1] ~= nil then
            local hasHouseKey = exports['qg-houses']:hasKey(result[1].license, result[1].citizenid, house)
            if hasHouseKey then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('xt-garage:server:PayDepotPrice', function(vehicle, garage)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bankBalance = Player.PlayerData.money["bank"]
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {vehicle.plate}, function(result)
        if result[1] ~= nil then
            if bankBalance >= result[1].depotprice then
                Player.Functions.RemoveMoney("bank", result[1].depotprice, "paid-depot")
                TriggerClientEvent("xt-garage:client:takeOutDepot", src, vehicle, garage)
            else
                TriggerClientEvent('xt-notify:client:Alert', src, "GARAGE", "Bạn không đủ tiền", 5000, 'error')
            end
        end
    end)
end)

RegisterServerEvent('xt-garage:server:updateVehicleState', function(state, plate, garage)
    MySQL.Async.execute('UPDATE player_vehicles SET state = ?, garage = ?, depotprice = ? WHERE plate = ?',
        {state, garage, 500, plate})
end)

RegisterServerEvent('xt-garage:server:updateVehicleStatus', function(fuel, engine, body, plate, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    if engine > 1000 then
        engine = engine / 1000
    end
    if body > 1000 then
        body = body / 1000
    end
    MySQL.Async.execute(
        'UPDATE player_vehicles SET fuel = ?, engine = ?, body = ? WHERE plate = ? AND citizenid = ? AND garage = ?',
        {fuel, engine, body, plate, pData.PlayerData.citizenid, garage})
end)

RegisterServerEvent('xt-garage:server:updateVehicle', function(fuel, engine, body, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    if engine > 1000 then
        engine = engine / 1000
    end
    if body > 1000 then
        body = body / 1000
    end
    MySQL.Async.fetchAll(
        'UPDATE player_vehicles SET fuel = ?, engine = ?, body = ? WHERE plate = ? AND citizenid = ?',
        {fuel, engine, body, plate, pData.PlayerData.citizenid})
end)
QBCore.Functions.CreateCallback('xt-garage:server:GetPlayerVehicles', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Vehicles = {}
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ?', {Player.PlayerData.citizenid}, function(result)
        if result[1] then
            for k, v in pairs(result) do
                local VehicleData = QBCore.Shared.Vehicles[v.vehicle]
                local VehicleGarage = "Trống"
                if v.garage ~= nil then
                    if Garages[v.garage] ~= nil then
                        VehicleGarage = Garages[v.garage].label
                    else
                        VehicleGarage = "Gara cá nhân"         -- HouseGarages[v.garage].label
                    end
                end
                if v.state == 0 then
                    v.state = "Ngoài"
                elseif v.state == 1 then
                    v.state = "Trong"
                elseif v.state == 2 then
                    v.state = "Player.Functions.GetItemByName(name)"
                end
                local fullname 
                if VehicleData["brand"] ~= nil then
                    fullname = VehicleData["brand"] .. " " .. VehicleData["name"]
                else
                    fullname = VehicleData["name"]
                end
                Vehicles[#Vehicles+1] = {
                    fullname = fullname,
                    brand = VehicleData["brand"],
                    model = VehicleData["name"],
                    plate = v.plate,
                    garage = VehicleGarage,
                    state = v.state,
                    fuel = v.fuel,
                    engine = v.engine,
                    body = v.body
                }
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)
RegisterNetEvent("xt-garage:server:removeOldVehicle", function(plate)
    plate = plate
    local vehicles = GetAllVehicles()
    for k, v in pairs(vehicles) do
        local p = GetVehicleNumberPlateText(v)
        if plate == p then 
            DeleteEntity(v)
        end
    end
end)