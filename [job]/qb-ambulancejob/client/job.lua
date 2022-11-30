local statusCheckPed = nil
local PlayerJob = {}
local onDuty = false
local currentGarage = 1

-- Functions

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
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
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        if Config.VehicleSettings[vehicleInfo] ~= nil then
            QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
        end
        exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = 'XE CẤP CỨU',
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "ambulance:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = '⬅ ĐÓNG MENU',
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

-- Events

RegisterNetEvent('ambulance:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    TriggerServerEvent("xt-benhvien:server:SetDoctor")
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports.spawnmanager:setAutoSpawn(false)
    local ped = PlayerPedId()
    local player = PlayerId()
    TriggerServerEvent("xt-benhvien:server:SetDoctor")
    CreateThread(function()
        Wait(5000)
        -- SetEntityMaxHealth(ped, 200)
        -- SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
        SetPlayerHealthRechargeLimit(player, 0.0)
    end)
    CreateThread(function()
        Wait(1000)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            SetEntityHealth(PlayerPedId(), PlayerData.metadata["health"])
            SetPedArmour(PlayerPedId(), PlayerData.metadata["armor"])
            if (not PlayerData.metadata["inlaststand"] and PlayerData.metadata["isdead"]) then
                deathTime = Laststand.ReviveInterval
                OnDeath()
                DeathTimer()
            elseif (PlayerData.metadata["inlaststand"] and not PlayerData.metadata["isdead"]) then
                SetLaststand(true, true)
            else
                TriggerServerEvent("xt-benhvien:server:SetDeathStatus", false)
                TriggerServerEvent("xt-benhvien:server:SetLaststandStatus", false)
            end
        end)
    end)
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
    TriggerServerEvent("xt-benhvien:server:SetDoctor")
end)

RegisterNetEvent('xt-benhvien:client:CheckStatus', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 5.0 then
        local playerId = GetPlayerServerId(player)
        statusCheckPed = GetPlayerPed(player)
        QBCore.Functions.TriggerCallback('hospital:GetPlayerStatus', function(result)
            if result then
                for k, v in pairs(result) do
                    if k ~= "BLEED" and k ~= "WEAPONWOUNDS" then
                        statusChecks[#statusChecks+1] = {bone = Config.BoneIndexes[k], label = v.label .." (".. Config.WoundStates[v.severity] ..")"}
                    elseif result["WEAPONWOUNDS"] then
                        for k, v in pairs(result["WEAPONWOUNDS"]) do
                            TriggerEvent('chat:addMessage', {
                                color = { 255, 0, 0},
                                multiline = false,
                                args = {"Tình trạng", WeaponDamageList[v]}
                            })
                        end
                    elseif result["BLEED"] > 0 then
                        TriggerEvent('chat:addMessage', {
                            color = { 255, 0, 0},
                            multiline = false,
                            args = {"Tình trạng", "là :"..Config.BleedingStates[v].label}
                        })
                    else
                        exports['xt-notify']:Alert("THÔNG BÁO", "Bệnh nhân hoàn toàn khoẻ mạnh", 5000, 'success')
                    end
                end
                isStatusChecking = true
                statusCheckTime = Config.CheckTime
            end
        end, playerId)
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Không có ai ở bên cạnh", 5000, 'error')
    end
end)

RegisterNetEvent('xt-benhvien:client:RevivePlayer', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                QBCore.Functions.Progressbar("hospital_revive", "Chữa trị", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã cứu sống bệnh nhân", 5000, 'success')
                    TriggerServerEvent("xt-benhvien:server:RevivePlayer", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ bỏ", 5000, 'error')
                end)
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Không có ai ở bên cạnh bạn", 5000, 'error')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không có "..QBCore.Shared.Items['firstaid'].label, 5000, 'error')
        end
    end, 'firstaid')
end)

RegisterNetEvent('xt-benhvien:client:TreatWounds', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                QBCore.Functions.Progressbar("hospital_healwounds", "Băng bó", 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 16,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã cầm máu cho bệnh nhân", 5000, 'success')
                    TriggerServerEvent("xt-benhvien:server:TreatWounds", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ bỏ", 5000, 'error')
                end)
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Không có ai ở bên cạnh bạn", 5000, 'error')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không có "..QBCore.Shared.Items['bandage'].label, 5000, 'error')
        end
    end, 'bandage')
end)
RegisterNetEvent('xt-benhvien:client:duty', function()
    if PlayerJob.name =="ambulance" then
        onDuty = not onDuty
        TriggerServerEvent("QBCore:ToggleDuty")
        TriggerServerEvent("police:server:UpdateBlips")
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không phải <span style='color:#fc1100'>nhân viên y tế</span>", 5000, 'error')
    end
end)


RegisterNetEvent('xt-benhvien:client:tdcn', function()
    if PlayerJob.name =="ambulance" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "ambulancestash_"..QBCore.Functions.GetPlayerData().citizenid)
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không phải <span style='color:#fc1100'>nhân viên y tế</span>", 5000, 'error')
    end
end)
RegisterNetEvent('xt-benhvien:client:tuthuoc', function()
    if PlayerJob.name =="ambulance" then
        if onDuty then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không trong <span style='color:#fc1100'>ca làm</span>", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không phải <span style='color:#fc1100'>nhân viên y tế</span>", 5000, 'error')
    end
end)
RegisterNetEvent('xt-benhvien:client:lentang', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    local coords = Config.Locations["roof"]
    SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
    SetEntityHeading(ped, coords.w)
    Wait(100)
    DoScreenFadeIn(1000)
end)
RegisterNetEvent('xt-benhvien:client:xuongtang', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    local coords = Config.Locations["sanhchinh"]
    SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
    SetEntityHeading(ped, coords.w)
    Wait(100)
    DoScreenFadeIn(1000)
end)
-- Threads

CreateThread(function()
    while true do
        Wait(10)
        if isStatusChecking then
            for k, v in pairs(statusChecks) do
                local x,y,z = table.unpack(GetPedBoneCoords(statusCheckPed, v.bone))
                DrawText3D(x, y, z, v.label)
            end
        end
        if isHealingPerson then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, healAnimDict, healAnim, 3) then
                loadAnimDict(healAnimDict)
                TaskPlayAnim(ped, healAnimDict, healAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end
end)

RegisterNetEvent("xt-benhvien:client:VehicleMenuHeader", function (data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local takeDist = Config.Locations['vehicle'][data]
    takeDist = vector3(takeDist.x, takeDist.y,  takeDist.z)
    if #(pos - takeDist) <= 15 then
        MenuGarage(data)
        currentGarage = data
    end
end)

CreateThread(function()
    while true do
        sleep = 1000
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            if PlayerJob.name =="ambulance" then

                for k, v in pairs(Config.Locations["helicopter"]) do
                    local dist = #(pos - vector3(v.x, v.y, v.z))
                    if dist < 7.5 then
                        if onDuty then
                            sleep = 5
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if dist < 1.5 then
                                if IsPedInAnyVehicle(ped, false) then
                                    DrawText3D(v.x, v.y, v.z, "Nhấn [~g~E~s~] - Cất máy bay")
                                else
                                    DrawText3D(v.x, v.y, v.z, "Nhấn [~g~E~s~] - Lấy máy bay")
                                end
                                if IsControlJustReleased(0, 38) then
                                    if IsPedInAnyVehicle(ped, false) then
                                        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                                    else
                                        local coords = Config.Locations["helicopter"][k]
                                        QBCore.Functions.SpawnVehicle(Config.Helicopter, function(veh)
                                            SetVehicleNumberPlateText(veh, "HELI"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.w)
                                            SetVehicleLivery(veh, 1) -- Ambulance Livery
                                            exports['ps-fuel']:SetFuel(veh, 100.0)
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
                
            end

            local currentHospital = 1

            for k, v in pairs(Config.Locations["baove"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("bsveh", vector3(v.x, v.y, v.z), 2.0, {
                        name="bsveh",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    action = function(entity)
                                        TriggerEvent('xt-benhvien:client:VehicleMenuHeader', k)
                                    end,
                                    icon = "fa-solid fa-car",
                                    label = "Gara bệnh viện (Xe công vụ)",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["checking"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z))
                if dist < 1.5 then
                  
                    exports['qb-target']:AddCircleZone("nhapvien", vector3(v.x, v.y, v.z), 2.0, {
                        name="nhapvien",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "xt-benhvien:client:dangky",
                                    icon = "fa-solid fa-file-invoice-dollar",
                                    label = "Đăng kí chữa bệnh",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["duty"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("duty", vector3(v.x, v.y, v.z), 2.0, {
                        name="duty",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "xt-benhvien:client:duty",
                                    icon = "fa-solid fa-user-check",
                                    label = "Vào/Kết thúc ca làm",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["tang2"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("tang2", vector3(v.x, v.y, v.z), 2.0, {
                        name="tang2",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "xt-benhvien:client:xuongtang",
                                    icon = "fa-solid fa-elevator",
                                    label = "Xuống sảnh chính",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["tang1"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("tang1", vector3(v.x, v.y, v.z), 2.0, {
                        name="tang1",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "xt-benhvien:client:lentang",
                                    icon = "fa-solid fa-elevator",
                                    label = "Đi lên tầng thượng",
                                },
                                },
                            distance = 2.0
                        })
                end
            end
            for k, v in pairs(Config.Locations["tudo"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z + 1))
                if dist < 1.5 then
                    exports['qb-target']:AddCircleZone("tudo", vector3(v.x, v.y, v.z), 2.0, {
                        name="tudo",
                        debugPoly=false,
                        useZ=true,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "xt-benhvien:client:tdcn",
                                    icon = "fa-solid fa-box",
                                    label = "Tủ đồ cá nhân",
                                },
                                {
                                    type = "client",
                                    event = "xt-benhvien:client:tuthuoc",
                                    icon = "fa-solid fa-pills",
                                    label = "Tủ thuốc",
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
local yta, baove

CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local ytaped = "s_f_y_scrubs_01"
        local baoveped = "csb_prolsec"
        if LocalPlayer.state.isLoggedIn then
            for k, v in pairs(Config.Locations["yta"]) do
                local dist = #(pos - vector3(v.x, v.y, v.z))
                if dist <= 25.0  then
                    sleep = 5
                    if not DoesEntityExist(yta) then
                    RequestModel(ytaped)
                    while not HasModelLoaded(ytaped) do
                        Wait(10)
                    end
                    yta = CreatePed(26, ytaped, v.x, v.y, v.z, v.w, false, false)
                    SetEntityHeading(yta, v.w)
                    FreezeEntityPosition(yta, true)
                    SetEntityInvincible(yta, true)
                    SetBlockingOfNonTemporaryEvents(yta, true)
                    TaskStartScenarioInPlace(yta, "WORLD_HUMAN_GUARD_STAND", 0, false)
                    end
                else
                    sleep = 1500
                end
                if dist <= 5.0 then
                    DrawText3D(v.x, v.y, v.z + 1.9, "~y~Y Tá")
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
