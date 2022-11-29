QBCore = exports['qb-core']:GetCoreObject()

--local ModdedVehicles = {}
VehicleStatus = {}
local ClosestPlate = nil
local PlayerJob = {}
local onDuty = false
local effectTimer = 0

-- Exports

local function GetVehicleStatusList(plate)
    local retval = nil
    if VehicleStatus[plate] ~= nil then
        retval = VehicleStatus[plate]
    end
    return retval
end

local function GetVehicleStatus(plate, part)
    local retval = nil
    if VehicleStatus[plate] ~= nil then
        retval = VehicleStatus[plate][part]
    end
    return retval
end

local function SetVehicleStatus(plate, part, level)
    TriggerServerEvent("vehiclemod:server:updatePart", plate, part, level)
end

exports('GetVehicleStatusList', GetVehicleStatusList)
exports('GetVehicleStatus', GetVehicleStatus)
exports('SetVehicleStatus', SetVehicleStatus)

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function DrawText3Ds(x, y, z, text)
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

local function SetClosestPlate()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id,_ in pairs(Config.Plates) do
        if current ~= nil then
            if #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z)) < dist then
                current = id
                dist = #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z))
            end
        else
            dist = #(pos - vector3(Config.Plates[id].coords.x, Config.Plates[id].coords.y, Config.Plates[id].coords.z))
            current = id
        end
    end
    ClosestPlate = current
end

local function ScrapAnim(time)
    local time = time / 1000
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

local function ApplyEffects(vehicle)
    local plate = QBCore.Functions.GetPlate(vehicle)
    if GetVehicleClass(vehicle) ~= 13 and GetVehicleClass(vehicle) ~= 21 and GetVehicleClass(vehicle) ~= 16 and GetVehicleClass(vehicle) ~= 15 and GetVehicleClass(vehicle) ~= 14 then
        if VehicleStatus[plate] ~= nil then
            local chance = math.random(1, 100)
            if VehicleStatus[plate]["radiator"] <= 80 and (chance >= 1 and chance <= 20) then
                local engineHealth = GetVehicleEngineHealth(vehicle)
                if VehicleStatus[plate]["radiator"] <= 80 and VehicleStatus[plate]["radiator"] >= 60 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(10, 15))
                elseif VehicleStatus[plate]["radiator"] <= 59 and VehicleStatus[plate]["radiator"] >= 40 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(15, 20))
                elseif VehicleStatus[plate]["radiator"] <= 39 and VehicleStatus[plate]["radiator"] >= 20 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(20, 30))
                elseif VehicleStatus[plate]["radiator"] <= 19 and VehicleStatus[plate]["radiator"] >= 6 then
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(30, 40))
                else
                    SetVehicleEngineHealth(vehicle, engineHealth - math.random(40, 50))
                end
            end

            if VehicleStatus[plate]["axle"] <= 80 and (chance >= 21 and chance <= 40) then
                if VehicleStatus[plate]["axle"] <= 80 and VehicleStatus[plate]["axle"] >= 60 then
                    for i=0,360 do
                        SetVehicleSteeringScale(vehicle,i)
                        Wait(5)
                    end
                elseif VehicleStatus[plate]["axle"] <= 59 and VehicleStatus[plate]["axle"] >= 40 then
                    for i=0,360 do
                        Wait(10)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                elseif VehicleStatus[plate]["axle"] <= 39 and VehicleStatus[plate]["axle"] >= 20 then
                    for i=0,360 do
                        Wait(15)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                elseif VehicleStatus[plate]["axle"] <= 19 and VehicleStatus[plate]["axle"] >= 6 then
                    for i=0,360 do
                        Wait(20)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                else
                    for i=0,360 do
                        Wait(25)
                        SetVehicleSteeringScale(vehicle,i)
                    end
                end
            end

            if VehicleStatus[plate]["brakes"] <= 80 and (chance >= 41 and chance <= 60) then
                if VehicleStatus[plate]["brakes"] <= 80 and VehicleStatus[plate]["brakes"] >= 60 then
                    SetVehicleHandbrake(vehicle, true)
                    Wait(1000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["brakes"] <= 59 and VehicleStatus[plate]["brakes"] >= 40 then
                    SetVehicleHandbrake(vehicle, true)
                    Wait(3000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["brakes"] <= 39 and VehicleStatus[plate]["brakes"] >= 20 then
                    SetVehicleHandbrake(vehicle, true)
                    Wait(5000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["brakes"] <= 19 and VehicleStatus[plate]["brakes"] >= 6 then
                    SetVehicleHandbrake(vehicle, true)
                    Wait(7000)
                    SetVehicleHandbrake(vehicle, false)
                else
                    SetVehicleHandbrake(vehicle, true)
                    Wait(9000)
                    SetVehicleHandbrake(vehicle, false)
                end
            end

            if VehicleStatus[plate]["clutch"] <= 80 and (chance >= 61 and chance <= 80) then
                if VehicleStatus[plate]["clutch"] <= 80 and VehicleStatus[plate]["clutch"] >= 60 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Wait(50)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Wait(5)
                    end
                    Wait(500)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["clutch"] <= 59 and VehicleStatus[plate]["clutch"] >= 40 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Wait(100)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Wait(5)
                    end
                    Wait(750)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["clutch"] <= 39 and VehicleStatus[plate]["clutch"] >= 20 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Wait(150)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Wait(5)
                    end
                    Wait(1000)
                    SetVehicleHandbrake(vehicle, false)
                elseif VehicleStatus[plate]["clutch"] <= 19 and VehicleStatus[plate]["clutch"] >= 6 then
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Wait(200)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Wait(5)
                    end
                    Wait(1250)
                    SetVehicleHandbrake(vehicle, false)
                else
                    SetVehicleHandbrake(vehicle, true)
                    SetVehicleEngineOn(vehicle,0,0,1)
                    SetVehicleUndriveable(vehicle,true)
                    Wait(250)
                    SetVehicleEngineOn(vehicle,1,0,1)
                    SetVehicleUndriveable(vehicle,false)
                    for i=1,360 do
                        SetVehicleSteeringScale(vehicle, i)
                        Wait(5)
                    end
                    Wait(1500)
                    SetVehicleHandbrake(vehicle, false)
                end
            end

            if VehicleStatus[plate]["fuel"] <= 80 and (chance >= 81 and chance <= 100) then
                local fuel = exports['ps-fuel']:GetFuel(vehicle)
                if VehicleStatus[plate]["fuel"] <= 80 and VehicleStatus[plate]["fuel"] >= 60 then
                    exports['ps-fuel']:SetFuel(vehicle, fuel - 2.0)
                elseif VehicleStatus[plate]["fuel"] <= 59 and VehicleStatus[plate]["fuel"] >= 40 then
                    exports['ps-fuel']:SetFuel(vehicle, fuel - 4.0)
                elseif VehicleStatus[plate]["fuel"] <= 39 and VehicleStatus[plate]["fuel"] >= 20 then
                    exports['ps-fuel']:SetFuel(vehicle, fuel - 6.0)
                elseif VehicleStatus[plate]["fuel"] <= 19 and VehicleStatus[plate]["fuel"] >= 6 then
                    exports['ps-fuel']:SetFuel(vehicle, fuel - 8.0)
                else
                    exports['ps-fuel']:SetFuel(vehicle, fuel - 10.0)
                end
            end
        end
    end
end

local function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 1) .. "f", num))
end

local function SendStatusMessage(statusList)
    if statusList ~= nil then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message normal"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>'.. Config.ValuesLabels["engine"] ..' (engine):</strong> {1} <br><strong>'.. Config.ValuesLabels["body"] ..' (body):</strong> {2} <br><strong>'.. Config.ValuesLabels["radiator"] ..' (radiator):</strong> {3} <br><strong>'.. Config.ValuesLabels["axle"] ..' (axle):</strong> {4}<br><strong>'.. Config.ValuesLabels["brakes"] ..' (brakes):</strong> {5}<br><strong>'.. Config.ValuesLabels["clutch"] ..' (clutch):</strong> {6}<br><strong>'.. Config.ValuesLabels["fuel"] ..' (fuel):</strong> {7}</div></div>',
            args = {'Tình trạng phương tiện', round(statusList["engine"]) .. "/" .. Config.MaxStatusValues["engine"] .. " ("..QBCore.Shared.Items["advancedrepairkit"]["label"]..")", round(statusList["body"]) .. "/" .. Config.MaxStatusValues["body"] .. " ("..QBCore.Shared.Items[Config.RepairCost["body"]]["label"]..")", round(statusList["radiator"]) .. "/" .. Config.MaxStatusValues["radiator"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["radiator"]]["label"]..")", round(statusList["axle"]) .. "/" .. Config.MaxStatusValues["axle"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["axle"]]["label"]..")", round(statusList["brakes"]) .. "/" .. Config.MaxStatusValues["brakes"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["brakes"]]["label"]..")", round(statusList["clutch"]) .. "/" .. Config.MaxStatusValues["clutch"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["clutch"]]["label"]..")", round(statusList["fuel"]) .. "/" .. Config.MaxStatusValues["fuel"] .. ".0 ("..QBCore.Shared.Items[Config.RepairCost["fuel"]]["label"]..")"}
        })
    end
end

local function OpenMenu()
    local OpenMenu = {
        {
            header = "Tình trạng phương tiện",
            isMenuHeader = true
        },
        {
            header = "Hạ xe",
            txt = "Hạ phương tiện xuống",
            params = {
                event = "qb-mechanicjob:client:UnattachVehicle",
            }
        },
        {
            header = "Kiểm tra",
            txt = "Kiểm tra tình trạng của phương tiện",
            params = {
                event = "qb-mechanicjob:client:CheckStatus",
                args = {
                    number = 1,
                }
            }
        },
        {
            header = "Bộ phận",
            txt = "Sửa các bộ phận",
            params = {
                event = "qb-mechanicjob:client:PartsMenu",
                args = {
                    number = 1,
                }
            }
        },
        {
            header = "⬅ Đóng",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    }

    exports['qb-menu']:openMenu(OpenMenu)
end

local function PartsMenu()
    local plate = QBCore.Functions.GetPlate(Config.Plates[ClosestPlate].AttachedVehicle)
    if VehicleStatus[plate] ~= nil then
        local vehicleMenu = {
            {
                header = "Tình trạng",
                isMenuHeader = true
            }
        }
        for k,v in pairs(Config.ValuesLabels) do
            if math.ceil(VehicleStatus[plate][k]) ~= Config.MaxStatusValues[k] then
                local percentage = math.ceil(VehicleStatus[plate][k])
                if percentage > 100 then
                    percentage = math.ceil(VehicleStatus[plate][k]) / 10
                end
                vehicleMenu[#vehicleMenu+1] = {
                    header = v,
                    txt = "Tình trạng: " .. percentage .. ".0% / 100.0%",
                    params = {
                        event = "qb-mechanicjob:client:PartMenu",
                        args = {
                            name = v,
                            parts = k
                        }
                    }
                }
            else
                local percentage = math.ceil(Config.MaxStatusValues[k])
                if percentage > 100 then
                    percentage = math.ceil(Config.MaxStatusValues[k]) / 10
                end
                vehicleMenu[#vehicleMenu+1] = {
                    header = v,
                    txt = "Tình trạng: " .. percentage .. ".0% / 100.0%",
                    params = {
                        event = "qb-mechanicjob:client:NoDamage",
                    }
                }
            end                               
        end
        vehicleMenu[#vehicleMenu+1] = {
            header = "⬅ Đóng",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
    
        }
        exports['qb-menu']:openMenu(vehicleMenu)
    end

end

local function PartMenu(data)
    local partName = data.name
    local part = data.parts
    local TestMenu1 = {
        {
            header = "Bộ phận",
            isMenuHeader = true
        },
        {
            header = ""..partName.."",
            txt = "Sửa chữa : "..QBCore.Shared.Items[Config.RepairCostAmount[part].item]["label"].." "..Config.RepairCostAmount[part].costs.."x", 
            params = {
                event = "qb-mechanicjob:client:RepairPart",
                args = {
                    part = part,
                }
            }
        },
        {
            header = "⬅ Quay lại",
            txt = "Back to parts menu",
            params = {
                event = "qb-mechanicjob:client:PartsMenu",
            }
        },
        {
            header = "⬅ Đóng",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
        
    }

    exports['qb-menu']:openMenu(TestMenu1)
end

local function NoDamage()
    local NoDamage = {
        {
            header = "Không hư hại",
            isMenuHeader = true
        },
        {
            header = "Quay lại",
            txt = "Bộ phận này không bị hư hại!",
            params = {
                event = "qb-mechanicjob:client:PartsMenu",
            }
        },
        {
            header = "⬅ Đóng",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(NoDamage)
end

local function UnattachVehicle()
    local coords = Config.Locations["exit"]
    DoScreenFadeOut(150)
    Wait(150)
    FreezeEntityPosition(Config.Plates[ClosestPlate].AttachedVehicle, false)
    SetEntityCoords(Config.Plates[ClosestPlate].AttachedVehicle, Config.Plates[ClosestPlate].coords.x, Config.Plates[ClosestPlate].coords.y, Config.Plates[ClosestPlate].coords.z)
    SetEntityHeading(Config.Plates[ClosestPlate].AttachedVehicle, Config.Plates[ClosestPlate].coords.w)
    TaskWarpPedIntoVehicle(PlayerPedId(), Config.Plates[ClosestPlate].AttachedVehicle, -1)
    Wait(500)
    DoScreenFadeIn(250)
    Config.Plates[ClosestPlate].AttachedVehicle = nil
    TriggerServerEvent('qb-vehicletuning:server:SetAttachedVehicle', false, ClosestPlate)
end

local function SpawnListVehicle(model)
    local coords = {
        x = Config.Locations["vehicle"].x,
        y = Config.Locations["vehicle"].y,
        z = Config.Locations["vehicle"].z,
        w = Config.Locations["vehicle"].w,
    }

    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetVehicleNumberPlateText(veh, "SUXE"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true, true)
end

local function VehicleList()
    local vehicleMenu = {
        {
            header = "Danh sách phương tiện",
            isMenuHeader = true
        }
    }
    for k,v in pairs(Config.Vehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = v,
            txt = "Phương tiện: "..v.."",
            params = {
                event = "qb-mechanicjob:client:SpawnListVehicle",
                args = {
                    headername = v,
                    spawnName = k
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = "⬅ Đóng",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

local function CheckStatus()
    local plate = QBCore.Functions.GetPlate(Config.Plates[ClosestPlate].AttachedVehicle)
    SendStatusMessage(VehicleStatus[plate])
end

local function RepairPart(part)
    local PartData = Config.RepairCostAmount[part]
    local hasitem = false
    local indx = 0
    local countitem = 0
    QBCore.Functions.TriggerCallback('qb-inventory:server:GetStashItems', function(StashItems)
        for k,v in pairs(StashItems) do
            if v.name == PartData.item then
                hasitem = true
                if v.amount >= PartData.costs then
                    countitem = v.amount
                    indx = k
                end
            end
        end
        if hasitem and countitem >= PartData.costs then
            TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
            QBCore.Functions.Progressbar("repair_part", "Sửa " ..Config.ValuesLabels[part], math.random(5000, 10000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                if (countitem - PartData.costs) <= 0 then
                    StashItems[indx] = nil
                else
                    countitem = (countitem - PartData.costs)
                    StashItems[indx].amount = countitem
                end
                TriggerEvent('qb-vehicletuning:client:RepaireeePart', part)
                TriggerServerEvent('qb-inventory:server:SaveStashItems', "boss_mechanic", StashItems)
                SetTimeout(250, function()
                    PartsMenu()
                end)
            end, function()       
                exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ bỏ", 5000, 'error')
            end)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ nguyên liệu", 5000, 'error')
        end
    end, "boss_mechanic")
end



-- Events
RegisterNetEvent("qb-mechanicjob:client:UnattachVehicle",function(data)
    UnattachVehicle()
end)

RegisterNetEvent("qb-mechanicjob:client:PartsMenu",function(data)
    PartsMenu()
end)

RegisterNetEvent("qb-mechanicjob:client:PartMenu",function(data)
    PartMenu(data)
end)

RegisterNetEvent("qb-mechanicjob:client:NoDamage",function(data)
    NoDamage()
end)

RegisterNetEvent("qb-mechanicjob:client:CheckStatus",function(data)
    CheckStatus()
end)

RegisterNetEvent("qb-mechanicjob:client:SpawnListVehicle",function(data)
    local vehicleSpawnName=data.spawnName
    SpawnListVehicle(vehicleSpawnName)
end)

RegisterNetEvent("qb-mechanicjob:client:RepairPart",function(data)
    local partData = data.part
    RepairPart(partData)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "mechanic" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
    QBCore.Functions.TriggerCallback('qb-vehicletuning:server:GetAttachedVehicle', function(plates)
        for k, v in pairs(plates) do
            Config.Plates[k].AttachedVehicle = v.AttachedVehicle
        end
    end)

    QBCore.Functions.TriggerCallback('qb-vehicletuning:server:GetDrivingDistances', function(retval)
        DrivingDistance = retval
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('qb-vehicletuning:client:SetAttachedVehicle', function(veh, key)
    if veh ~= false then
        Config.Plates[key].AttachedVehicle = veh
    else
        Config.Plates[key].AttachedVehicle = nil
    end
end)

RegisterNetEvent('qb-vehicletuning:client:RepaireeePart', function(part)
    local veh = Config.Plates[ClosestPlate].AttachedVehicle
    local plate = QBCore.Functions.GetPlate(veh)
    if part == "engine" then
        SetVehicleEngineHealth(veh, Config.MaxStatusValues[part])
        TriggerServerEvent("vehiclemod:server:updatePart", plate, "engine", Config.MaxStatusValues[part])
    elseif part == "body" then
        local enhealth = GetVehicleEngineHealth(veh)
        SetVehicleBodyHealth(veh, Config.MaxStatusValues[part])
        TriggerServerEvent("vehiclemod:server:updatePart", plate, "body", Config.MaxStatusValues[part])
        SetVehicleFixed(veh)
        SetVehicleEngineHealth(veh, enhealth)
    else
        TriggerServerEvent("vehiclemod:server:updatePart", plate, part, Config.MaxStatusValues[part])
    end
    exports['xt-notify']:Alert("THÔNG BÁO", Config.ValuesLabels[part].." đã được sửa chữa", 5000, 'success')
end)

RegisterNetEvent('vehiclemod:client:setVehicleStatus', function(plate, status)
    VehicleStatus[plate] = status
end)

RegisterNetEvent('vehiclemod:client:getVehicleStatus', function(plate, status)
    if not (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(), true)
        if veh ~= nil and veh ~= 0 then
            local vehpos = GetEntityCoords(veh)
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - vehpos) < 5.0 then
                if not IsThisModelABicycle(GetEntityModel(veh)) then
                    local plate = QBCore.Functions.GetPlate(veh)
                    if VehicleStatus[plate] ~= nil then
                        SendStatusMessage(VehicleStatus[plate])
                    else
                        exports['xt-notify']:Alert("THÔNG BÁO", "Không tìm thấy tình trạng", 5000, 'error')
                    end
                else
                    exports['xt-notify']:Alert("THÔNG BÁO", "Không thể kiểm tra phương tiện này", 5000, 'error')
                end
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn quá xa phương tiện", 5000, 'error')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải trong phương tiện", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ở bên ngoài phương tiện", 5000, 'error')
    end
end)

RegisterNetEvent('vehiclemod:client:fixEverything', function()
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            local plate = QBCore.Functions.GetPlate(veh)
            TriggerServerEvent("vehiclemod:server:fixEverything", plate)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ngồi ở vị trí lái", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải trong phương tiện", 5000, 'error')
    end
end)

RegisterNetEvent('vehiclemod:client:setPartLevel', function(part, level)
    if (IsPedInAnyVehicle(PlayerPedId(), false)) then
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            local plate = QBCore.Functions.GetPlate(veh)
            if part == "engine" then
                SetVehicleEngineHealth(veh, level)
                TriggerServerEvent("vehiclemod:server:updatePart", plate, "engine", GetVehicleEngineHealth(veh))
            elseif part == "body" then
                SetVehicleBodyHealth(veh, level)
                TriggerServerEvent("vehiclemod:server:updatePart", plate, "body", GetVehicleBodyHealth(veh))
            else
                TriggerServerEvent("vehiclemod:server:updatePart", plate, part, level)
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ngồi ở vị trí lái", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ngồi ở vị trí lái", 5000, 'error')
    end
end)
local openingDoor = false

RegisterNetEvent('vehiclemod:client:repairPart', function(part, level, needAmount)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsIn(PlayerPedId(), true)
        if veh ~= nil and veh ~= 0 then
            local vehpos = GetEntityCoords(veh)
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - vehpos) < 5.0 then
                if not IsThisModelABicycle(GetEntityModel(veh)) then
                    local plate = QBCore.Functions.GetPlate(veh)
                    if VehicleStatus[plate] ~= nil and VehicleStatus[plate][part] ~= nil then
                        local lockpickTime = (1000 * level)
                        if part == "body" then
                            lockpickTime = lockpickTime / 10
                        end
                        ScrapAnim(lockpickTime)
                        QBCore.Functions.Progressbar("repair_advanced", "Sửa", lockpickTime, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "mp_car_bomb",
                            anim = "car_bomb_mechanic",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            openingDoor = false
                            ClearPedTasks(PlayerPedId())
                            if part == "body" then
                                local enhealth = GetVehicleEngineHealth(veh)
                                SetVehicleBodyHealth(veh, GetVehicleBodyHealth(veh) + level)
                                SetVehicleFixed(veh)
                                SetVehicleEngineHealth(veh, enhealth)
                                TriggerServerEvent("vehiclemod:server:updatePart", plate, part, GetVehicleBodyHealth(veh))
                                TriggerServerEvent("QBCore:Server:RemoveItem", Config.RepairCost[part], needAmount)
                                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.RepairCost[part]], "remove")
                            elseif part ~= "engine" then
                                TriggerServerEvent("vehiclemod:server:updatePart", plate, part, GetVehicleStatus(plate, part) + level)
                                TriggerServerEvent("QBCore:Server:RemoveItem", Config.RepairCost[part], level)
                                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[Config.RepairCost[part]], "remove")
                            end
                        end, function() -- Cancel
                            openingDoor = false
                            ClearPedTasks(PlayerPedId())
                            exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ", 5000, 'error')
                        end)
                    else
                        exports['xt-notify']:Alert("THÔNG BÁO", "Không xác định", 5000, 'error')
                    end
                else
                    exports['xt-notify']:Alert("THÔNG BÁO", "Không xác định", 5000, 'error')
                end
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn quá xa phương tiện", 5000, 'error')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải trong phương tiện", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải trong phương tiện", 5000, 'error')
    end
end)
RegisterNetEvent('qb-mechanic:client:duty',function()
    if PlayerJob.name == "mechanic" then
        TriggerServerEvent("QBCore:ToggleDuty")
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không phải Thợ sửa chữa", 5000, 'error')
    end
end)

RegisterNetEvent('qb-mechanic:client:khodo', function()
    if PlayerJob.name == "mechanic" and PlayerJob.grade.level > 0 then
        if onDuty then
            TriggerEvent("inventory:client:SetCurrentStash", "mechanicstash")
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "mechanicstash", {
                maxweight = 40000000,
                slots = 1000,
            })
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn chưa trong ca làm việc", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không phải Thợ sửa chữa", 5000, 'error')
    end

end)
-- Threads

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            SetClosestPlate()
        end
        Wait(1000)
    end
end)

CreateThread(function()
    local c = Config.Locations["exit"]
    local Blip = AddBlipForCoord(c.x, c.y, c.z)
    SetBlipSprite (Blip, 446)
    SetBlipDisplay(Blip, 4)
    SetBlipScale  (Blip, 0.7)
    SetBlipAsShortRange(Blip, true)
    SetBlipColour(Blip, 0)
    SetBlipAlpha(Blip, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Xưởng sửa chữa")
    EndTextCommandSetBlipName(Blip)
end)

CreateThread(function()
    while true do
        sleep = 1000
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            if PlayerJob.name == "mechanic" then

                local dist = #(pos - vector3(Config.Locations["duty"].x, Config.Locations["duty"].y, Config.Locations["duty"].z))
                local dist1 = #(pos - vector3(Config.Locations["stash"].x, Config.Locations["stash"].y, Config.Locations["stash"].z))
                    if dist < 2.5 then
                        exports['qb-target']:AddCircleZone("vaocasx", vector3(Config.Locations["duty"].x, Config.Locations["duty"].y, Config.Locations["duty"].z), 2.0, {
                            name="vaocasx",
                            debugPoly= false,
                            useZ=true,
                            }, {
                                options = {
                                    {
                                        type = "client",
                                        event = "qb-mechanic:client:duty",
                                        icon = "fa-solid fa-user-check",
                                        label = "Vào/Tan ca",
                                    },
                                    },
                                distance = 2.0
                            })
                    end
                    if dist1 < 2.5 then
                        exports['qb-target']:AddCircleZone("sxkhodo", vector3(Config.Locations["stash"].x, Config.Locations["stash"].y, Config.Locations["stash"].z), 2.0, {
                            name="sxkhodo",
                            debugPoly= false,
                            useZ=true,
                            }, {
                                options = {
                                    {
                                        type = "client",
                                        event = "qb-mechanic:client:khodo",
                                        icon = "fa-solid fa-box",
                                        label = "Kho đồ cứu hộ",
                                    },
                                    },
                                distance = 2.0
                            })
                    end
            end
        end
        Wait(sleep)
    end
end)




CreateThread(function()
    while true do
        local inRange = false
        if LocalPlayer.state.isLoggedIn then
            if PlayerJob.name == "mechanic" then
                local pos = GetEntityCoords(PlayerPedId())
                local VehicleDistance = #(pos - vector3(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z))


                if onDuty then
                    if VehicleDistance < 20 then
                        inRange = true
                        DrawMarker(2, Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 210, 50, 9, 255, false, false, false, true, false, false, false)
                        if VehicleDistance < 1 then
                            local InVehicle = IsPedInAnyVehicle(PlayerPedId())

                            if InVehicle then
                                DrawText3Ds(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, 'Nhấn [~r~E~s~] Cất phương tiện')
                                if IsControlJustPressed(0, 38) then
                                    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                end
                            else
                                DrawText3Ds(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, 'Nhấn [~g~E~s~] Lấy phương tiện')
                                if IsControlJustPressed(0, 38) then
                                    if IsControlJustPressed(0, 38) then
                                        VehicleList()
                                    end
                                end
                            end
                        end
                    end
                end

                if onDuty then
                    for k, v in pairs(Config.Plates) do
                        if v.AttachedVehicle == nil then
                            local PlateDistance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if PlateDistance < 20 then
                                inRange = true
                                DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                                if PlateDistance < 2 then
                                    local veh = GetVehiclePedIsIn(PlayerPedId())
                                    if IsPedInAnyVehicle(PlayerPedId()) then
                                        if not IsThisModelABicycle(GetEntityModel(veh)) then
                                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.3, "Nhấn [~g~E~s~] Nâng phương tiện")
                                            if IsControlJustPressed(0, 38) then
                                                DoScreenFadeOut(150)
                                                Wait(150)
                                                Config.Plates[ClosestPlate].AttachedVehicle = veh
                                                SetEntityCoords(veh, v.coords)
                                                SetEntityHeading(veh, v.coords.w)
                                                FreezeEntityPosition(veh, true)
                                                Wait(500)
                                                DoScreenFadeIn(250)
                                                TriggerServerEvent('qb-vehicletuning:server:SetAttachedVehicle', veh, k)
                                            end
                                        else
                                            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không thể nâng một chiếc xe đạp lên", 5000, 'error')
                                        end
                                    end
                                end
                            end
                        else
                            local PlateDistance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if PlateDistance < 3 then
                                inRange = true
                                DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "Nhấn [~g~E~s~] Mở menu")
                                if IsControlJustPressed(0, 38) then
                                    OpenMenu()
                                end
                            end
                        end
                    end
                end

                if not inRange then
                    Wait(1500)
                end
            else
                Wait(1500)
            end
        else
            Wait(1500)
        end

        Wait(3)
    end
end)

-- CreateThread(function() -- Not event sure what this is even for
--     while true do
--         Wait(1)
--         if (IsPedInAnyVehicle(PlayerPedId(), false)) then
--             local veh = GetVehiclePedIsIn(PlayerPedId(),false)
--             if ModdedVehicles[tostring(veh)] == nil and not IsThisModelABicycle(GetEntityModel(veh)) then
--                 --[[local fSteeringLock = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock')
--                 fSteeringLock = math.ceil((fSteeringLock * 0.6)) + 0.1

--                 SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)
--                 SetVehicleHandlingField(veh, 'CHandlingData', 'fSteeringLock', fSteeringLock)]]--

--                 local fInitialDriveMaxFlatVel = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel')

--                 if IsThisModelABike(GetEntityModel(veh)) then
--                     local fTractionCurveMin = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMin')

--                     fTractionCurveMin = fTractionCurveMin * 0.6
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMin', fTractionCurveMin)
--                     SetVehicleHandlingField(veh, 'CHandlingData', 'fTractionCurveMin', fTractionCurveMin)

--                     -- local fTractionCurveMax = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMax')
--                     -- fTractionCurveMax = fTractionCurveMax * 0.6
--                     -- SetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionCurveMax', fTractionCurveMax)
--                     -- SetVehicleHandlingField(veh, 'CHandlingData', 'fTractionCurveMax', fTractionCurveMax)

--                     local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--                     fInitialDriveForce = fInitialDriveForce * 2.4
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)

--                     local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
--                     fBrakeForce = fBrakeForce * 1.4
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionReboundDamp', 5.000000)
--                     SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionReboundDamp', 5.000000)

--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionCompDamp', 5.000000)
--                     SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionCompDamp', 5.000000)

--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fSuspensionForce', 22.000000)
--                     SetVehicleHandlingField(veh, 'CHandlingData', 'fSuspensionForce', 22.000000)

--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fCollisionDamageMult', 2.500000)
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fEngineDamageMult', 0.120000)
--                 else
--                     local fBrakeForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce')
--                     fBrakeForce = fBrakeForce * 0.5
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce', fBrakeForce)

--                     local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
--                     if fInitialDriveForce < 0.289 then
--                         fInitialDriveForce = fInitialDriveForce * 1.2
--                         SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
--                     else
--                         fInitialDriveForce = fInitialDriveForce * 0.9
--                         SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', fInitialDriveForce)
--                     end

--                     local fInitialDragCoeff = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDragCoeff')
--                     fInitialDragCoeff = fInitialDragCoeff * 0.3
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDragCoeff', fInitialDragCoeff)

--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fEngineDamageMult', 0.100000)
--                     SetVehicleHandlingFloat(veh, 'CHandlingData', 'fCollisionDamageMult', 2.900000)

--                 end
--                 SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDeformationDamageMult', 1.000000)
--                 SetVehicleHasBeenOwnedByPlayer(veh,true)
--                 ModdedVehicles[tostring(veh)] = {
--                     ["fInitialDriveMaxFlatVel"] = fInitialDriveMaxFlatVel,
--                     ["fSteeringLock"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock'),
--                     ["fTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fTractionLossMult'),
--                     ["fLowSpeedTractionLossMult"] = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fLowSpeedTractionLossMult')
--                 }
--             else
--                 Wait(1000)
--             end
--         else
--             Wait(2000)
--         end
--     end
-- end)

CreateThread(function()
    while true do
        Wait(1000)
        if (IsPedInAnyVehicle(PlayerPedId(), false)) then
            local veh = GetVehiclePedIsIn(PlayerPedId(),false)
            if not IsThisModelABicycle(GetEntityModel(veh)) and GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
                local engineHealth = GetVehicleEngineHealth(veh)
                local bodyHealth = GetVehicleBodyHealth(veh)
                local plate = QBCore.Functions.GetPlate(veh)
                if VehicleStatus[plate] == nil then
                    TriggerServerEvent("vehiclemod:server:setupVehicleStatus", plate, engineHealth, bodyHealth)
                else
                    TriggerServerEvent("vehiclemod:server:updatePart", plate, "engine", engineHealth)
                    TriggerServerEvent("vehiclemod:server:updatePart", plate, "body", bodyHealth)
                    effectTimer = effectTimer + 1
                    if effectTimer >= math.random(10, 15) then
                        ApplyEffects(veh)
                        effectTimer = 0
                    end
                end
            else
                effectTimer = 0
                Wait(1000)
            end
        else
            effectTimer = 0
            Wait(2000)
        end
    end
end)


local function IsVehicleValid(TowVehicle)
    if GetEntityModel(TowVehicle) == GetHashKey('flatbedm2') then
        return true
    else
        return false
    end
end


RegisterNetEvent('qb-mechanic:client:hook:car', function()
    local ped = PlayerPedId()
    local TowVehicle = GetVehiclePedIsIn(ped, true)
    if IsVehicleValid(TowVehicle) then
        local Vehicle, Distance = QBCore.Functions.GetClosestVehicle()
        if Config.CurrentTowedVehicle == nil then
            if Distance <= 4.0 then
                if Vehicle ~= TowVehicle then
                        QBCore.Functions.Progressbar("towing-vehicle", "Nâng phương tiện", 5000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "mini@repair",
                            anim = "fixing_a_ped",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            Config.CurrentTowedVehicle = Vehicle
                            StopAnimTask(ped, "mini@repair", "fixing_a_ped", 1.0)
                            AttachEntityToEntity(Vehicle, TowVehicle, GetEntityBoneIndexByName(TowVehicle, 'bodyshell'), 0.0, -1.5 + -0.85, 0.0 + 1.15, 0, 0, 0.4, 1, 1, 0, 1, 0, 1)
                            Citizen.Wait(150)
                            FreezeEntityPosition(Vehicle, true)
                            exports['xt-notify']:Alert("SỬA XE", "Chiếc xe đã được cẩu thành công!", 5000, 'success')
                        end, function() -- Cancel
                            Config.CurrentTowedVehicle = nil
                            StopAnimTask(ped, "mini@repair", "fixing_a_ped", 1.0)
                            exports['xt-notify']:Alert("SỬA XE", "Thất bại!", 5000, 'error')
                        end)
                else
                    exports['xt-notify']:Alert("SỬA XE", "Bạn không thể cẩu chiếc xe lên!", 5000, 'error')
                end
            else
                exports['xt-notify']:Alert("SỬA XE", "Không có xe nào ở gần!", 5000, 'error')
            end
        else
            QBCore.Functions.Progressbar("untowing_vehicle", "Hạ phương tiện", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(ped, "mini@repair", "fixing_a_ped", 1.0)
                FreezeEntityPosition(Config.CurrentTowedVehicle, false)
                Citizen.Wait(250)
                AttachEntityToEntity(Config.CurrentTowedVehicle, TowVehicle, 20, -0.0, -15.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
                DetachEntity(Config.CurrentTowedVehicle, true, true)
                Config.CurrentTowedVehicle = nil
                exports['xt-notify']:Alert("SỬA XE", "Phương tiện đã được hạ xuống!", 5000, 'error')
            end, function() -- Cancel
                StopAnimTask(ped, "mini@repair", "fixing_a_ped", 1.0)
                exports['xt-notify']:Alert("SỬA XE", "Thất bại!", 5000, 'error')
            end)
        end
    else
        exports['xt-notify']:Alert("SỬA XE", "Bạn không có xe cẩu nào", 5000, 'error')
    end
end)