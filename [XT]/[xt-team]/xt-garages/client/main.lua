local currentHouseGarage = nil
local hasGarageKey = nil
local OutsideVehicles = {}
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('xt-garage:client:setHouseGarage', function(house, hasKey)
    currentHouseGarage = house
    hasGarageKey = hasKey
end)

RegisterNetEvent('xt-garage:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
end)

RegisterNetEvent('xt-garage:client:addHouseGarage', function(house, garageInfo)
    HouseGarages[house] = garageInfo
end)
RegisterNetEvent('xt-garages:client:gara', function()
    local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inGarageRange = false
        for k, v in pairs(Garages) do
            local takeDist = #(pos - vector3(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z))
            if takeDist <= 15 then
                QBCore.Functions.TriggerCallback("xt-garage:server:GetUserVehicles", function(result)
                    if result == nil then
                        exports['xt-notify']:Alert("GARAGE", "Bạn không có phương tiện nào ở Gara này", 5000, 'error')
                    else
                        local vehicleMenu = {
                            {
                                header = Garages[k].label,
                                isMenuHeader = true
                            }
                        }
                        for z, x in pairs(result) do
                            local enginePercent = round(x.engine / 10, 0)
                            local bodyPercent = round(x.body / 10, 0)
                            local currentFuel = x.fuel
                            if x.state == 0 then
                                x.state = "Ngoài"
                            elseif x.state == 1 then
                                x.state = "Trong"
                            elseif x.state == 2 then
                                x.state = "Giam"
                            end
                            vehicleMenu[#vehicleMenu+1] = {
                                header = QBCore.Shared.Vehicles[x.vehicle]["name"],
                                txt = "Xăng:" ..currentFuel.. " | Động cơ: " ..enginePercent.. "| Thân vỏ:" ..bodyPercent.." <br>Trạng thái: " ..x.state.." | Biển số: " ..x.plate,
                                params = {
                                    event = "xt-garages:client:garalayxe",
                                    args = {
                                        name = x,
                                        garage = k
                                    }
                                }
                            }
                        end
                        vehicleMenu[#vehicleMenu+1] = {
                            header = "< Đóng",
                            txt = "",
                            params = {
                                event = "qb-menu:client:closeMenu"
                            }
                        }
                        exports['qb-menu']:openMenu(vehicleMenu)
                    end
                end, k)
            end
        end
end)

RegisterNetEvent('xt-garages:client:garalayxe', function(data)
    local vehicle = data.name
    local garage = data.garage
    if vehicle.state == "Trong" then
        enginePercent = round(vehicle.engine / 10, 1)
        bodyPercent = round(vehicle.body / 10, 1)
        currentFuel = vehicle.fuel
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('xt-garage:server:GetVehicleProperties', function(properties)
                FreezeEntityPosition(PlayerPedId(), true)
                TriggerServerEvent("xt-garage:server:removeOldVehicle", vehicle.plate)
                exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đang được chuẩn bị, vui lòng chờ", 5000, 'warning')
                Wait(3000)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                TriggerEvent('persistent-vehicles/register-vehicle', veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, Garages[garage].spawnPoint.w)
                exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                SetEntityAsMissionEntity(veh, true, true)
                TriggerServerEvent('xt-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                FreezeEntityPosition(PlayerPedId(), false)
                exports['xt-notify']:Alert("GARAGE", "Phương tiện:Động cơ " .. enginePercent .. "% Thân vỏ: " .. bodyPercent.. "% Nhiên liệu: "..currentFuel.. "%", 7000, 'info')
                exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, Garages[garage].spawnPoint, true)
    elseif vehicle.state == "Ngoài" then
        exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đang ở Bãi tạm giữ", 5000, 'error')
    elseif vehicle.state == "Giam" then
        exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đang bị giam bởi Cảnh sát", 5000, 'error')
    end
end)

RegisterNetEvent('xt-garages:client:depot', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for k, v in pairs(Depots) do
        local takeDist = #(pos - vector3(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z))
        if takeDist <= 15 then
            QBCore.Functions.TriggerCallback("xt-garage:server:GetDepotVehicles", function(result)
                if result == nil then
                    exports['xt-notify']:Alert("GARAGE", "Không có phương tiện nào bị tạm giữ", 5000, 'error')
                else
                    local vehicleMenu = {
                        {
                            header = "Bãi giữ xe",
                            isMenuHeader = true
                        }
                    }
                    for z, x in pairs(result) do
                        local enginePercent = round(x.engine / 10, 0)
                        local bodyPercent = round(x.body / 10, 0)
                        local currentFuel = x.fuel
                        if x.state == 0 then
                            x.state = "Ngoài"
                        end
                        vehicleMenu[#vehicleMenu+1] = {
                            header = QBCore.Shared.Vehicles[x.vehicle]["name"],
                            txt = "Xăng: " ..currentFuel.. " | Động cơ: " ..enginePercent.. "| Thân vỏ:" ..bodyPercent.."<br>Trạng thái: " ..x.state.." | Biển số: " ..x.plate,
                            params = {
                                event = "xt-garages:client:depotlayxe",
                                args = {
                                    name = x,
                                    garage = k
                                }
                            }
                        }
                    end
                    vehicleMenu[#vehicleMenu+1] = {
                        header = "< Đóng",
                        txt = "",
                        params = {
                            event = "qb-menu:client:closeMenu"
                        }
                    }
                    exports['qb-menu']:openMenu(vehicleMenu)
                end
            end)
        end
    end
end)

RegisterNetEvent('xt-garages:client:depotlayxe', function(data)
    local vehicle = data.name
    local currentGarage = data.garage
    if vehicle.state == "Ngoài" then
        TriggerServerEvent("xt-garage:server:PayDepotPrice", vehicle, currentGarage)
        Wait(1000)
    end
end)

RegisterNetEvent('xt-garage:client:takeOutDepot', function(vehicle, garage)
    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
        QBCore.Functions.TriggerCallback('xt-garage:server:GetVehicleProperties', function(properties)
            QBCore.Functions.SetVehicleProperties(veh, properties)
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerServerEvent("xt-garage:server:removeOldVehicle", vehicle.plate)
            exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đang được chuẩn bị, vui lòng chờ", 7000, 'warning')
            Wait(5000)
            enginePercent = round(vehicle.engine / 10, 0)
            bodyPercent = round(vehicle.body / 10, 0)
            currentFuel = vehicle.fuel
            TriggerEvent('persistent-vehicles/register-vehicle', veh, properties)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetEntityHeading(veh, Depots[garage].takeVehicle.w)
            exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
            SetEntityAsMissionEntity(veh, true, true)
            doCarDamage(veh, vehicle)
            TriggerServerEvent('xt-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            Wait(3000)
            SetVehicleBodyHealth(veh, 0.2)
            Wait(250)
            SetVehicleEngineHealth(veh, 0.2)
            FreezeEntityPosition(PlayerPedId(), false)
            exports['xt-notify']:Alert("GARAGE", "Phương tiện: Động cơ: " .. enginePercent .. "% Thân vỏ: " .. bodyPercent.. "% Nhiên liệu: "..currentFuel.. "%", 7000, 'info')
            exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
            SetVehicleEngineOn(veh, true, true)
        end, vehicle.plate)
    end, Depots[garage].takeVehicle, true)
end)

RegisterNetEvent('xt-garages:client:house', function(data)
    local house = data
    TriggerEvent('nh-context:sendMenu', {
    {
        id = 1,
        header = "Gara",
        txt = ""
    },
    {
    id = 2,
    header = HouseGarages[house].label,
    txt = "",
    params = {
    event = "xt-garages:client:housemenu",
    args = {house = house,
            }
                        }
                },
                {
                id = 3,
                header = "Đóng",
                txt = "",
                params = {
                    event = "nh-context:closeMenu",
                }
                },
    })
end)
RegisterNetEvent('xt-garages:client:housemenu', function(data)
    local house = data.house
    QBCore.Functions.TriggerCallback("xt-garage:server:GetHouseVehicles", function(result)
        if result == nil then
            exports['xt-notify']:Alert("GARAGE", "Bạn không có phương tiện nào ở Gara này", 5000, 'error')
        else
            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel
                curGarage = HouseGarages[house].label
                if v.state == 0 then
                    v.state = "Ngoài"
                elseif v.state == 1 then
                    v.state = "Trong"
                elseif v.state == 2 then
                    v.state = "Giam"
                end
                if k == 1 then
                    TriggerEvent('nh-context:sendMenu', {
                        {
                        id = 0,
                        header = "Quay lại",
                        txt = "",
                        params = {
                            event = "xt-garages:client:house",
                            }
                        }
                    })
                end
                    TriggerEvent('nh-context:sendMenu', {
                    {
                        id = k,
                        header = QBCore.Shared.Vehicles[v.vehicle]["name"],
                        txt = "Xăng:" ..currentFuel.. " | Động cơ: " ..enginePercent.. "| Thân vỏ:" ..bodyPercent.."<br>Trạng thái: " ..v.state.." | Biển số: " ..v.plate,
                        params = {
                            event = "xt-garages:client:houselayxe",
                            args = {
                                name = v,
                                garage = house
                            }
                        }
                    },
                })
            end
        end
    end)
end)
RegisterNetEvent('xt-garages:client:houselayxe', function(data)
    local vehicle = data.name
    local garage = data.garage
    if vehicle.state == "Trong" then
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('xt-garage:server:GetVehicleProperties', function(properties)
                FreezeEntityPosition(PlayerPedId(), true)
                TriggerServerEvent("xt-garage:server:removeOldVehicle", vehicle.plate)
                Wait(3000)
                exports['xt-notify']:Alert("Hệ thống", "Phương tiện của bạn đang được chuẩn bị, vui lòng chờ", 5000, 'warning')
                QBCore.Functions.SetVehicleProperties(veh, properties)
                TriggerEvent('persistent-vehicles/register-vehicle', veh, properties)
                enginePercent = round(vehicle.engine / 10, 1)
                bodyPercent = round(vehicle.body / 10, 1)
                currentFuel = vehicle.fuel
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, HouseGarages[garage].takeVehicle.w)
                exports['lj-fuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('xt-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                FreezeEntityPosition(PlayerPedId(), false)
                exports['xt-notify']:Alert("GARAGE", "Phương tiện:Động cơ " .. enginePercent .. "% Thân vỏ: " .. bodyPercent.. "% Nhiên liệu: "..currentFuel.. "%", 7000, 'info')
                exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, HouseGarages[garage].takeVehicle, true)
    elseif vehicle.state == "Ngoài" then
        exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đang ở Bãi tạm giữ", 5000, 'error')
    elseif vehicle.state == "Giam" then
        exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đang bị giam bởi Cảnh sát", 5000, 'error')
    end
end)

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    for k, v in pairs(Garages) do
        if v.showBlip then
            local Garage = AddBlipForCoord(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z)
            SetBlipSprite (Garage, 357)
            SetBlipDisplay(Garage, 4)
            SetBlipScale  (Garage, 0.65)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Garages[k].label)
            EndTextCommandSetBlipName(Garage)
        end
    end
    for k, v in pairs(Depots) do
        if v.showBlip then
            local Depot = AddBlipForCoord(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z)
            SetBlipSprite (Depot, 68)
            SetBlipDisplay(Depot, 4)
            SetBlipScale  (Depot, 0.7)
            SetBlipAsShortRange(Depot, true)
            SetBlipColour(Depot, 5)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Depots[k].label)
            EndTextCommandSetBlipName(Depot)
        end
    end
end)


function doCarDamage(currentVehicle, veh)
	smash = false
	damageOutside = false
	damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
	if engine < 200.0 then
		engine = 200.0
    end
    if engine > 1000.0 then
        engine = 1000.0
    end
	if body < 150.0 then
		body = 150.0
	end
	if body < 900.0 then
		smash = true
	end
	if body < 800.0 then
		damageOutside = true
	end
	if body < 500.0 then
		damageOutside2 = true
	end
    Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)
	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

CreateThread(function()
    Wait(1000)
    while true do
        Wait(5)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inGarageRange = false
        for k, v in pairs(Garages) do
            local putDist = #(pos - vector3(Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z))
            if putDist <= 25 and IsPedInAnyVehicle(ped) then
                inGarageRange = true
                DrawMarker(2, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)
                if putDist <= 1.5 then
                    DrawText3Ds(Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z + 0.5, '~g~[E]~w~ - Đỗ Phương tiện')
                    if IsControlJustPressed(0, 38) then
                        local curVeh = GetVehiclePedIsIn(ped)
                        local plate = GetVehicleNumberPlateText(curVeh)
                        QBCore.Functions.TriggerCallback('xt-garage:server:checkVehicleOwner', function(owned)
                            if owned then
                                if GetVehicleEngineHealth(curVeh) > 500 or GetVehicleBodyHealth(curVeh) > 300 then
                                    local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                                    local engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
                                    local totalFuel = exports['lj-fuel']:GetFuel(curVeh)
                                    local vehProperties = QBCore.Functions.GetVehicleProperties(curVeh)
                                    CheckPlayers(curVeh)
                                    TriggerServerEvent('xt-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, k)
                                    TriggerServerEvent('xt-garage:server:updateVehicleState', 1, plate, k)
                                    TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', vehProperties)
                                    exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đã được đỗ tại " ..Garages[k].label, 5000, 'success')
                                else
                                    exports['xt-notify']:Alert("GARAGE", "Phương tiện này đã bị hỏng", 5000, 'error')
                                end
                            else
                                exports['xt-notify']:Alert("GARAGE", "Phương tiện này không của ai cả", 5000, 'error')
                            end
                        end, plate)
                    end
                end
            end
        end
        if not inGarageRange then
            Wait(1000)
        end
    end
end)

function CheckPlayers(vehicle)
    for i = -1, 5,1 do
        seat = GetPedInVehicleSeat(vehicle,i)
        if seat ~= 0 then
            TaskLeaveVehicle(seat,vehicle,0)
            SetVehicleDoorsLocked(vehicle)
            Wait(1500)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
   end
end

CreateThread(function()
    while true do
        sleep = 1000
        if LocalPlayer.state['isLoggedIn'] then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            inGarageRange = false
            if HouseGarages and currentHouseGarage then
                if hasGarageKey and HouseGarages[currentHouseGarage] and HouseGarages[currentHouseGarage].takeVehicle and HouseGarages[currentHouseGarage].takeVehicle.x then
                    local takeDist = #(pos - vector3(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z))
                    if takeDist <= 15 then
                        sleep = 5
                        inGarageRange = true
                        DrawMarker(2, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if takeDist < 2.0 then
                            if not IsPedInAnyVehicle(ped) then
                                DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                                if IsControlJustPressed(1, 177) and not Menu.hidden then
                                    close()
                                    PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                                end
                                if IsControlJustPressed(0, 38) then
                                    MenuHouseGarage(currentHouseGarage)
                                    Menu.hidden = not Menu.hidden
                                end
                            elseif IsPedInAnyVehicle(ped) then
                                DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - To Park')
                                if IsControlJustPressed(0, 38) then
                                    local curVeh = GetVehiclePedIsIn(ped)
                                    local plate = GetVehicleNumberPlateText(curVeh)
                                    QBCore.Functions.TriggerCallback('qb-garage:server:checkVehicleHouseOwner', function(owned)
                                        if owned then
                                            local bodyDamage = round(GetVehicleBodyHealth(curVeh), 1)
                                            local engineDamage = round(GetVehicleEngineHealth(curVeh), 1)
                                            local totalFuel = exports['lj-fuel']:GetFuel(curVeh)
                                            local vehProperties = QBCore.Functions.GetVehicleProperties(curVeh)
                                                CheckPlayers(curVeh)
                                            if DoesEntityExist(curVeh) then
                                                exports['xt-notify']:Alert("GARAGE", "Có ai đó đang ở trong xe", 5000, 'error')
                                            else
                                                TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, currentHouseGarage)
                                                TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, currentHouseGarage)
                                                TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', vehProperties)
                                                QBCore.Functions.DeleteVehicle(curVeh)
                                                if plate ~= nil then
                                                    OutsideVehicles[plate] = veh
                                                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                                end
                                                exports['xt-notify']:Alert("GARAGE", "Phương tiện của bạn đã đỗ tại "..HouseGarages[currentHouseGarage], 5000, 'success')
                                            end
                                        else
                                            exports['xt-notify']:Alert("GARAGE", "Phương tiện này không của ai cả", 5000, 'error')
                                        end
                                    end, plate, currentHouseGarage)
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)
function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
