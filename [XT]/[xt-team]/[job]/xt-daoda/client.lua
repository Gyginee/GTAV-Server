-- REDESIGNED BY Q4D 

--------------------
-- QBCore Core Stuff --
--------------------
QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
local mining = false
local iswashing = false
local ismelt = false
local washcoords = Config.WashCoords
local miningcoords = Config.MiningCoords
local meltcoords = Config.MeltCoords
local thaydocoords =  Config.Thaydo
local pedcoords =  Config.Ped
local closeTo = 0
local dolm = false
local blip1, blip2, blip

CreateThread(function()
	local StartJobBlip = AddBlipForCoord(thaydocoords.x, thaydocoords.y, thaydocoords.z)
	SetBlipSprite (StartJobBlip, 478)
	SetBlipDisplay(StartJobBlip, 4)
	SetBlipScale  (StartJobBlip, 0.8)
	SetBlipColour (StartJobBlip, 5)
	SetBlipAsShortRange(StartJobBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Bãi đá')
	EndTextCommandSetBlipName(StartJobBlip)
end)
local thomo

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

local function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end
    CreateThread(function()
        while true do
            local sleep = 1000
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local thomoped = "s_m_m_dockwork_01"
                    local dist = #(pos - vector3(pedcoords.x, pedcoords.y, pedcoords.z))
                    if dist <= 25.0  then
                        sleep = 5
                        if not DoesEntityExist(thomo) then
                            RequestModel(thomoped)
                        while not HasModelLoaded(thomoped) do
                            Wait(10)
                        end
                        thomo = CreatePed(26, thomoped, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.w, false, false)
                        SetEntityHeading(thomo, pedcoords.w)
                        FreezeEntityPosition(thomo, true)
                        SetEntityInvincible(thomo, true)
                        SetBlockingOfNonTemporaryEvents(thomo, true)
                        TaskStartScenarioInPlace(thomo, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        end
                    else
                        sleep = 1500
                    end
                    if dist <= 5.0 then
                        DrawText3D(pedcoords.x, pedcoords.y, pedcoords.z + 1.9, "~o~THỢ MỎ")
                    end
        Wait(sleep)
        end
    end)
local function addBlipLammo()
    blip1 = AddBlipForCoord(washcoords.x, washcoords.y, washcoords.z)
    SetBlipSprite(blip1, 478)
    SetBlipDisplay(blip1, 4)
    SetBlipScale(blip1, 0.6)
    SetBlipAsShortRange(blip1, true)
    SetBlipColour(blip1, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~o~[Thợ mỏ]~s~ - Rửa đá")
    EndTextCommandSetBlipName(blip1)
    blip = AddBlipForCoord(miningcoords.x, miningcoords.y, miningcoords.z)
    SetBlipSprite(blip, 478)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~o~[Thợ mỏ]~s~ - Đào đá")
    EndTextCommandSetBlipName(blip)
    blip2 = AddBlipForCoord(meltcoords.x, meltcoords.y, meltcoords.z)
    SetBlipSprite(blip2, 478)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 0.6)
    SetBlipAsShortRange(blip2, true)
    SetBlipColour(blip2, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~o~[Thợ mỏ]~s~ - Nung đá")
    EndTextCommandSetBlipName(blip2)
end

RegisterNetEvent('xt-daoda:client:thaydo', function()
    local ped = PlayerPedId()
    if not dolm then
        sleep = 5
        local PlayerData = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Progressbar("thay-dp", "Thay đồng phục", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            if PlayerData.charinfo.gender == 0 then
                SetPedComponentVariation(ped, 3, Config.Clothes.male['arms'], 0, 0) --tay
                SetPedComponentVariation(ped, 8, Config.Clothes.male['tshirt_1'], Config.Clothes.male['tshirt_2'], 0) --áo trong
                SetPedComponentVariation(ped, 11, Config.Clothes.male['torso_1'], Config.Clothes.male['torso_2'], 0) --áo ngoài
                SetPedComponentVariation(ped, 4, Config.Clothes.male['pants_1'], Config.Clothes.male['pants_2'], 0) -- quần
                SetPedComponentVariation(ped, 6, Config.Clothes.male['shoes_1'], Config.Clothes.male['shoes_2'], 0) --giày
            else
                SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
                SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0)
                SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0)
                SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0)
                SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0)
            end
            dolm = true
            addBlipLammo()
            exports['xt-notify']:Alert("THÔNG BÁO", "Khai thác mỏ thôi nào!", 5000, 'success')
        end)
    else
        sleep = 5
        local health = GetEntityHealth(ped)
        local maxhealth = GetEntityMaxHealth(ped)
        QBCore.Functions.Progressbar("thay-do", "Thay đồ", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("qb-clothes:loadPlayerSkin")
            dolm = false
            exports['xt-notify']:Alert("THÔNG BÁO", "Mai lại đến nhé!", 5000, 'success')
        end)
        RemoveBlip(blip1)
        RemoveBlip(blip2)
        RemoveBlip(blip)
        SetPedMaxHealth(PlayerId(), maxhealth)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
        Wait(3000) -- Safety Delay
        SetEntityHealth(ped, health)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    exports['qb-target']:AddCircleZone("daoda", vector3(pedcoords.x, pedcoords.y, pedcoords.z), 2.0, {
        name="daoda",
        debugPoly=false,
        useZ=true,
        }, {
        options = {
        {
        type = "client",
        event = "xt-daoda:client:thaydo",
        icon = "fa-solid fa-gem",
        label = "Nhận/Huỷ công việc",
        },
    },
    distance = 2.0
    })
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

CreateThread(function()
    while true do
        Wait(4)
            if dolm then
                for k, v in pairs(Config.MiningPositions) do
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 5 then
                        closeTo = v
                        break
                    end
                end
                if type(closeTo) == 'table' then
                    while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 5  do
                        Wait(3)
                        if mining == false then
                            DrawMarker(25, closeTo.coords.x, closeTo.coords.y, closeTo.coords.z - 0.9, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                            QBCore.Functions.DrawText3D(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z + 0.5,'[~g~E~s~] - Đào đá')
                            if IsControlJustPressed(1, 51) then
                                mining = true
                                local ped = PlayerPedId()
                                local PedCoords = GetEntityCoords(ped)
                                local axe = CreateObject(GetHashKey('prop_tool_jackham'), PedCoords.x, PedCoords.y,PedCoords.z, true, false, false)
                                DisableControlAction(1, 51, true)
                                CreateThread(function()
                                    while true do
                                        Wait(5000)
                                        if mining == true then
                                            TriggerServerEvent('xt-daoda:client:getstone')
                                            AttachEntityToEntity(axe, ped, GetPedBoneIndex(ped, 60309), 0.09, 0.03, -0.02, 0.0, 0.0, 0.0, false, true, true, true, 0, true)
                                            LoadDict("amb@world_human_const_drill@male@drill@base")
                                            TaskPlayAnim(ped, "amb@world_human_const_drill@male@drill@base", "base", 8.0, -8.0, 20000, 2, 0, false, false, false)
                                        else
                                            break
                                        end
                                    end
                                end)
                                QBCore.Functions.Progressbar("xt-daoda", "Đào đá", (60000 * 5), false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    ClearPedTasks(ped)
                                    DeleteObject(axe)
                                    mining = false
                                    DisableControlAction(1, 51, false)
                                end, function() -- Cancel
                                    ClearPedTasks(ped)
                                    DeleteObject(axe)
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ", 5000, 'error')
                                    mining = false
                                    DisableControlAction(1, 51, false)
                                end)
                            end
                        end
                    end
                end
            end
            Wait(300)
    end
end)

CreateThread(function()
    local sleep
    while true do
        sleep = 5
        if dolm then
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(washcoords.x,washcoords.y,washcoords.z))
                if dist <= 10 then
                    sleep = 3
                    if iswashing == false then
                    DrawText3D(washcoords.x, washcoords.y,washcoords.z + 0.5, '[~g~E~s~] - Rửa đá')
                    DrawMarker(25, washcoords.x, washcoords.y, washcoords.z - 0.4, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                        if dist <= 2 then
                            if IsControlJustPressed(1, 51) then
                                iswashing = true
                                CreateThread(function()
                                    while true do
                                        Wait(5000)
                                        if iswashing == true then
                                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                                if result then
                                                    TriggerServerEvent('xt-daoda:washStone')
                                                    LoadDict("amb@prop_human_bum_bin@idle_a")
                                                    TaskPlayAnim(player, "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0, -8.0, 20000, 2, 0, false, false, false)
                                                else
                                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['stone'].label, 5000, 'error')
                                                    iswashing = false
                                                    DisableControlAction(1, 51, false)
                                                    TriggerEvent('progressbar:client:cancel')
                                                end
                                            end, 'stone', 5)
                                        else
                                            break
                                        end                
                                    end
                                end)
                                QBCore.Functions.Progressbar("qg-wash", "Rửa đá", (60000 * 5), false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                    disableAll = true,
                                }, {}, {}, {}, function() -- Done
                                    ClearPedTasks(player)
                                    iswashing = false
                                    DisableControlAction(1, 51, false)
                                end, function() -- Cancel
                                    ClearPedTasks(player)
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ", 5000, 'error')
                                    iswashing = false
                                    DisableControlAction(1, 51, false)
                                end)
                            end
                        end
                    end
                else
                    iswashing = false
                    sleep = 2500
                end
        end
        Wait(sleep)
    end
end)
CreateThread(function()
    local sleep
    while true do
        sleep = 5
        if dolm then
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(meltcoords.x,meltcoords.y,meltcoords.z))
                if dist <= 10 then
                    sleep = 5
                    if ismelt == false then
                    DrawMarker(25, meltcoords.x, meltcoords.y, meltcoords.z - 0.9, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    DrawText3D(meltcoords.x, meltcoords.y,meltcoords.z + 0.5, '[~g~E~s~] - Nung đá')
                    if dist <= 3 then
                        if IsControlJustPressed(1, 51) then
                            ismelt = true
                            DisableControlAction(1, 51, true) -- disable attack
                            CreateThread(function()
                                while true do
                                    Wait(5000)
                                    if ismelt == true then
                                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                            if result then
                                                TriggerServerEvent('xt-daoda:meltStone')
                                                LoadDict("amb@prop_human_bum_bin@idle_a")
                                                TaskPlayAnim(player, "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0, -8.0, 20000, 2, 0, false, false, false)
                                            else
                                                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['washedstone'].label, 5000, 'error')
                                                ismelt = false
                                                DisableControlAction(1, 51, false)
                                                TriggerEvent('progressbar:client:cancel')
                                            end
                                        end, 'washedstone', 5)
                                    else
                                        break
                                    end                           
                                end
                            end)
                            QBCore.Functions.Progressbar("qg-melt", "Nung đá", (60000 * 5), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                ClearPedTasks(player)
                                ismelt = false
                                DisableControlAction(1, 51, false)
                            end, function() -- Cancel
                                ClearPedTasks(player)
                                ismelt = false
                                DisableControlAction(1, 51, false)
                            end)
                        end
                    end
                end
                else
                    ismelt = false
                    sleep = 2500
                end
        end
        Wait(sleep)
    end
end)

