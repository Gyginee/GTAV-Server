-- Variables
local currentGarage = 0
local inFingerprint = false
local FingerPrintSessionId = nil

-- Functions
local function DrawText3D(x, y, z, text)
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

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

local function SetCarItemsInfo()
	local items = {}
	for k, item in pairs(Config.CarItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.CarItems = items
end

local function doCarDamage(currentVehicle, veh)
	local smash = false
	local damageOutside = false
	local damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0

	if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
	if body < 150.0 then body = 150.0 end
	if body < 950.0 then smash = true end
	if body < 920.0 then damageOutside = true end
	if body < 920.0 then damageOutside2 = true end
    Citizen.Wait(100)
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

function TakeOutImpound(vehicle)
    local coords = Config.Locations["impound"][currentGarage]
    if coords then
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('xt-garage:server:GetVehicleProperties', function(properties)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                print(vehicle.plate)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, coords.w)
                exports['ps-fuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('police:server:TakeOutImpound',vehicle.plate)
                closeMenuFull()
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, coords, true)
    end
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    if coords then
        QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
            SetCarItemsInfo()
            SetVehicleNumberPlateText(veh, "CASA"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['ps-fuel']:SetFuel(veh, 100.0)
            closeMenuFull()
            if Config.VehicleSettings[vehicleInfo] ~= nil then
                QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
            end
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
            TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
            SetVehicleEngineOn(veh, true, true)
        end, coords, true)
    end
end

local function IsArmoryWhitelist() -- being removed
    local retval = false

    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        retval = true
    end
    return retval
end

local function SetWeaponSeries()
    for k, v in pairs(Config.Items.items) do
        if k < 6 then
            Config.Items.items[k].info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
    end
end

function MenuGarage(currentSelection)
    local vehicleMenu = {
        {
            header = "Gara Cảnh sát",
            isMenuHeader = true
        }
    }
    local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "police:client:TakeOutVehicle",
                args = {
                    vehicle = veh,
                    currentSelection = currentSelection
                }
            }
        }
    end

    if IsArmoryWhitelist() then
        for veh, label in pairs(Config.WhitelistedVehicles) do
            vehicleMenu[#vehicleMenu+1] = {
                header = label,
                txt = "",
                params = {
                    event = "police:client:TakeOutVehicle",
                    args = {
                        vehicle = veh,
                        currentSelection = currentSelection
                    }
                }
            }
        end
    end

    vehicleMenu[#vehicleMenu+1] = {
        header = "Đóng",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

function MenuImpound(currentSelection)
    local impoundMenu = {
        {
            header = "Menu Giam giữ",
            isMenuHeader = true
        }
    }
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            exports['xt-notify']:Alert("THÔNG BÁO", "Không có phương tiện được giam giữ", 5000, 'error')
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = QBCore.Shared.Round(v.engine / 10, 0)
                local bodyPercent = QBCore.Shared.Round(v.body / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name
                impoundMenu[#impoundMenu+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt = "Động cơ: "..enginePercent.."Thân vỏ: "..bodyPercent.." Xăng: "..currentFuel,
                    params = {
                        event = "police:client:TakeOutImpound",
                        args = {
                            vehicle = v,
                            currentSelection = currentSelection
                        }
                    }
                }
            end
        end


        if shouldContinue then
            impoundMenu[#impoundMenu+1] = {
                header = "Đóng",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            exports['qb-menu']:openMenu(impoundMenu)
        end
    end)

end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

--NUI Callbacks
RegisterNUICallback('closeFingerprint', function()
    SetNuiFocus(false, false)
    inFingerprint = false
end)

--Events
RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(data)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
end)

RegisterNetEvent('police:client:SendEmergencyMessage', function(coords, message)
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        while isCalling do
            Citizen.Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:ImpoundVehicle', function(fullImpound, price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['ps-fuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            local plate = QBCore.Functions.GetPlate(vehicle)
            TriggerServerEvent("police:server:Impound", plate, fullImpound, price, bodyDamage, engineDamage, totalFuel)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
    end
end)

RegisterNetEvent('police:client:CheckStatus', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result then
                        for k, v in pairs(result) do
                            exports['xt-notify']:Alert("THÔNG BÁO", v, 5000, 'info')
                        end
                    end
                end, playerId)
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Không có người nào ở gần bạn", 5000, 'error')
            end
        end
    end)
end)

RegisterNetEvent("police:client:VehicleMenuHeader", function (data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local takeDist = Config.Locations['vehicle'][data]
    takeDist = vector3(takeDist.x, takeDist.y,  takeDist.z)
    if #(pos - takeDist) <= 15 then
        MenuGarage(data)
        currentGarage = data
    end
end)


RegisterNetEvent("police:client:ImpoundMenuHeader", function (data)
    local pos = GetEntityCoords(PlayerPedId())
    local takeDist = Config.Locations['impound'][data]
    takeDist = vector3(takeDist.x, takeDist.y,  takeDist.z)
    if #(pos - takeDist) <= 15 then
        MenuImpound(data)
        currentGarage = data
    end
end)

RegisterNetEvent('police:client:TakeOutImpound', function(data)
    local pos = GetEntityCoords(PlayerPedId())
    local takeDist = Config.Locations['impound'][data.currentSelection]
    takeDist = vector3(takeDist.x, takeDist.y,  takeDist.z)
    if #(pos - takeDist) <= 15 then
        local vehicle = data.vehicle
        print('event')
        TakeOutImpound(vehicle)
    end
end)

RegisterNetEvent('police:client:TakeOutVehicle', function(data)
    local pos = GetEntityCoords(PlayerPedId())
    local takeDist = Config.Locations['vehicle'][data.currentSelection]
    takeDist = vector3(takeDist.x, takeDist.y,  takeDist.z)
    if #(pos - takeDist) <= 15 then
        local vehicle = data.vehicle
        TakeOutVehicle(vehicle)
    end
end)

RegisterNetEvent('police:client:EvidenceStashDrawer', function(data)
    local currentEvidence = data
    local pos = GetEntityCoords(PlayerPedId())
        local drawer = exports['qb-input']:ShowInput({
            header = "Kho vật chứng: "..currentEvidence,
            submitText = "Mở",
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'slot',
                    text = "Ô trống"
                }
            }
        })
        if drawer then
            print("Ô"..currentEvidence)
            if not drawer.slot then return end
            print("kho"..drawer.slot)
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "Ô: "..currentEvidence.." | Ngăn: "..drawer.slot, {
                maxweight = 4000000,
                slots = 500,
            })
            TriggerEvent("inventory:client:SetCurrentStash", "Ô: "..currentEvidence.." | Ngăn: "..drawer.slot)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Kho đồ không tồn tại", 5000, 'error')
        end
end)

-- Toggle Duty in an event.
RegisterNetEvent('qb-policejob:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("police:server:UpdateBlips")
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent('qb-policejob:client:duty',function()
    if PlayerJob.name == "police" then
        onDuty = not onDuty
        TriggerServerEvent("police:server:UpdateCurrentCops")
        TriggerServerEvent("QBCore:ToggleDuty")
        TriggerServerEvent("police:server:UpdateBlips")
    end
end)

RegisterNetEvent('qb-policejob:client:edvstash',function()
    if onDuty and PlayerJob.name == "police" then
        local drawer = exports['qb-input']:ShowInput({
            header = "Kho vật chứng",
            submitText = "Mở",
            inputs = {
                {
                    type = 'number',
                    isRequired = true,
                    name = 'slot',
                    text = "Kho vật chứng số:"
                }
            }
        })
        if drawer then
            if not drawer.slot then return end
           TriggerEvent('police:client:EvidenceStashDrawer', drawer.slot)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Kho đồ không tồn tại", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải là Cảnh sát trong ca làm", 5000, 'error')
    end
end)
RegisterNetEvent('qb-policejob:client:perstash',function()
    if onDuty and PlayerJob.name == "police" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải là Cảnh sát trong ca làm", 5000, 'error')
    end
end)
RegisterNetEvent('qb-policejob:client:thungrac',function()
    if onDuty and PlayerJob.name == "police" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
            maxweight = 4000000,
            slots = 300,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải là Cảnh sát trong ca làm", 5000, 'error')
    end
end)

RegisterNetEvent('qb-policejob:client:vantay',function()
    if onDuty and PlayerJob.name == "police" then
        local player, distance = GetClosestPlayer()
        if player ~= -1 and distance < 2.5 then
            local playerId = GetPlayerServerId(player)
            TriggerServerEvent("police:server:showFingerprint", playerId)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Không có người nào ở gần bạn", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải là Cảnh sát trong ca làm", 5000, 'error')
    end
end)

RegisterNetEvent('qb-policejob:client:vukhi',function()
    if onDuty and PlayerJob.name == "police" then
        local authorizedItems = {
            label = "Kho vũ khí",
            slots = 60,
            items = {}
        }
        local index = 1
        for _, armoryItem in pairs(Config.Items.items) do
            for i=1, #armoryItem.authorizedJobGrades do
                if armoryItem.authorizedJobGrades[i] == PlayerJob.grade.level then
                    authorizedItems.items[index] = armoryItem
                    authorizedItems.items[index].slot = index
                    index = index + 1
                end
            end
        end
        SetWeaponSeries()
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", authorizedItems)
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải là Cảnh sát trong ca làm", 5000, 'error')
    end
end)
-- Threads


-- Tạo NPC
local tieptan, baove
CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local tieptanped = "s_f_y_cop_01"
        local baoveped = "csb_prolsec"
        if LocalPlayer.state.isLoggedIn then
            for k, v in pairs(Config.Locations["tieptan"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z))
                if dist <= 25.0  then
                    sleep = 5
                    if not DoesEntityExist(tieptan) then
                        RequestModel(tieptanped)
                    while not HasModelLoaded(tieptanped) do
                        Wait(10)
                    end
                    tieptan = CreatePed(26, tieptanped, v.x, v.y, v.z, v.w, false, false)
                    SetEntityHeading(tieptan, v.w)
                    FreezeEntityPosition(tieptan, true)
                    SetEntityInvincible(tieptan, true)
                    SetBlockingOfNonTemporaryEvents(tieptan, true)
                    TaskStartScenarioInPlace(tieptan, "WORLD_HUMAN_GUARD_STAND", 0, false)
                    end
                else
                    sleep = 1500
                end
                if dist <= 5.0 then
                    DrawText3D(v.x, v.y, v.z + 1.9, "~y~Cảnh sát")
                end
            end
            for k, v in pairs(Config.Locations["baove"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z))
                if dist <= 25.0  then
                    sleep = 5
                    if not DoesEntityExist(baove) then
                    RequestModel(baoveped)
                    while not HasModelLoaded(baoveped) do
                        Wait(10)
                    end
                    baove = CreatePed(26, baoveped, v.x, v.y, v.z, v.w, false, false)
                    SetEntityHeading(baove, v.w)
                    FreezeEntityPosition(baove, true)
                    SetEntityInvincible(baove, true)
                    SetBlockingOfNonTemporaryEvents(baove, true)
                    TaskStartScenarioInPlace(baove, "WORLD_HUMAN_COP_IDLES", 0, false)
                    end
                else
                    sleep = 1500
                end
                if dist <= 5.0 then
                    DrawText3D(v.x, v.y, v.z + 1.9, "~y~Bảo vệ")
                end
            end
        end
        Wait(sleep)
	end
end)

-- tạo target

CreateThread(function()
    while true do
        sleep = 1000
        if LocalPlayer.state.isLoggedIn and PlayerJob.name == "police" then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k, v in pairs(Config.Locations["helicopter"]) do
                if #(pos - vector3(v.x, v.y, v.z)) < 7.5 then
                    if onDuty then
                        sleep = 5
                        DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if #(pos - vector3(v.x, v.y, v.z)) < 1.5 then
                            if IsPedInAnyVehicle(ped, false) then
                                DrawText3D(v.x, v.y, v.z, "[~r~E~s~] - Cất trực thăng")
                            else
                                DrawText3D(v.x, v.y, v.z, "[~g~E~s~] - Lấy trực thăng")
                            end
                            if IsControlJustReleased(0, 38) then
                                if IsPedInAnyVehicle(ped, false) then
                                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                                else
                                    local coords = Config.Locations["helicopter"][k]
                                    QBCore.Functions.SpawnVehicle(Config.PoliceHelicopter, function(veh)
                                        SetVehicleLivery(veh , 0)
                                        SetVehicleMod(veh, 0, 48)
                                        SetVehicleNumberPlateText(veh, "HELI"..tostring(math.random(1000, 9999)))
                                        SetEntityHeading(veh, coords.w)
                                        exports['ps-fuel']:SetFuel(veh, 100.0)
                                        closeMenuFull()
                                        TaskWarpPedIntoVehicle(ped, veh, -1)
                                        exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
                                        SetVehicleEngineOn(veh, true, true)
                                    end, coords, true)
                                end
                            end
                        end
                    end
                end
            end
            for k, v in pairs(Config.Locations["duty"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("dutycs", vector3(v.x, v.y, v.z), 2.0, {
                        name="dutycs",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "qb-policejob:client:duty",
                                    icon = "fa-solid fa-user-check",
                                    label = "Vào/Kết thúc ca làm",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["fingerprint"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("vantay", vector3(v.x, v.y, v.z), 2.0, {
                        name="vantay",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "qb-policejob:client:vantay",
                                    icon = "fa-solid fa-fingerprint",
                                    label = "Lấy vân tay",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["armory"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("vukhi", vector3(v.x, v.y, v.z), 2.0, {
                        name="vukhi",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "qb-policejob:client:vukhi",
                                    icon = "fa-solid fa-gun",
                                    label = "Kho vũ khí",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["baove"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("csveh", vector3(v.x, v.y, v.z), 2.0, {
                        name="csveh",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    action = function(entity)
                                        TriggerEvent('police:client:VehicleMenuHeader', k)
                                    end,
                                    icon = "fa-solid fa-car",
                                    label = "Gara Cảnh sát(Xe công vụ)",
                                },
                                {
                                    type = "client",
                                    action = function(entity)
                                        TriggerEvent('police:client:ImpoundMenuHeader', k)
                                    end,
                                    icon = "fa-solid fa-car-burst",
                                    label = "Phương tiện bị giam giữ",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["stash"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("cstudo", vector3(v.x, v.y, v.z), 2.0, {
                        name="cstudo",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "qb-policejob:client:edvstash",
                                    icon = "fa-solid fa-box-archive",
                                    label = "Kho đựng chứng cứ",
                                },
                                {
                                    type = "client",
                                    event = "qb-policejob:client:perstash",
                                    icon = "fa-solid fa-box",
                                    label = "Kho đồ cá nhân",
                                },
                                {
                                    type = "client",
                                    event = "qb-policejob:client:thungrac",
                                    icon = "<fa-solid fa-dumpster",
                                    label = "Thùng rác",
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