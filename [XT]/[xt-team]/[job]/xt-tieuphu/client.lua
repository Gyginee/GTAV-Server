-- REDESIGNED BY Q4D 

--------------------
-- QBCore Core Stuff --
--------------------
QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
local picking = false
local weaving = false
local sewing = false
local weavingcoords = Config.WeavingCoords
local pickingcoords = Config.PickingCoords
local sewingcoords = Config.SewingCoords
local thaydocoords =  Config.Thaydo
local pedcoords =  Config.Ped
local closeTo = 0
local thaydo =false
local blip, blip2, blip1

CreateThread(function()
	local StartJobBlip = AddBlipForCoord(thaydocoords.x, thaydocoords.y, thaydocoords.z)
	SetBlipSprite (StartJobBlip, 237)
	SetBlipDisplay(StartJobBlip, 4)
	SetBlipScale  (StartJobBlip, 0.8)
	SetBlipColour (StartJobBlip, 0)
	SetBlipAsShortRange(StartJobBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Rừng nguyên sinh')
	EndTextCommandSetBlipName(StartJobBlip)
end)
local tieuphu
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
local function addBlipTieuphu()
    blip1 = AddBlipForCoord(weavingcoords.x, weavingcoords.y, weavingcoords.z)
    SetBlipSprite(blip1, 237)
    SetBlipDisplay(blip1, 4)
    SetBlipScale(blip1, 0.6)
    SetBlipAsShortRange(blip1, true)
    SetBlipColour(blip1, 0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~g~[Tiều phu]~s~ - Xẻ gỗ")
    EndTextCommandSetBlipName(blip1)
    blip = AddBlipForCoord(pickingcoords.x, pickingcoords.y, pickingcoords.z)
	SetBlipSprite(blip, 237)
	SetBlipDisplay(blip, 4)
	    SetBlipScale(blip, 0.6)
	    SetBlipAsShortRange(blip, true)
	    SetBlipColour(blip, 0)
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentSubstringPlayerName("~g~[Tiều phu]~s~ - Chặt gỗ")
        EndTextCommandSetBlipName(blip)
    blip2 = AddBlipForCoord(sewingcoords.x, sewingcoords.y, sewingcoords.z)
	    SetBlipSprite(blip2, 237)
	    SetBlipDisplay(blip2, 4)
	    SetBlipScale(blip2, 0.6)
	    SetBlipAsShortRange(blip2, true)
	    SetBlipColour(blip2, 0)
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentSubstringPlayerName("~g~[Tiều phu]~s~- Ép gỗ")
        EndTextCommandSetBlipName(blip2)
end
CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local tieuphuped = "cs_old_man2"
        local dist = #(pos - vector3(pedcoords.x, pedcoords.y, pedcoords.z))
        if dist <= 25.0  then
            sleep = 5
            if not DoesEntityExist(tieuphu) then
                RequestModel(tieuphuped)
            while not HasModelLoaded(tieuphuped) do
                Wait(10)
            end
                tieuphu = CreatePed(26, tieuphuped, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.w, false, false)
                SetEntityHeading(tieuphu, pedcoords.w)
                FreezeEntityPosition(tieuphu, true)
                SetEntityInvincible(tieuphu, true)
                SetBlockingOfNonTemporaryEvents(tieuphu, true)
                TaskStartScenarioInPlace(tieuphu, "WORLD_HUMAN_CLIPBOARD", 0, false)
            end
        else
            sleep = 1500
        end
        if dist <= 5.0 then
            DrawText3D(pedcoords.x, pedcoords.y, pedcoords.z + 1.9, "~o~TIỀU PHU")
        end
    Wait(sleep)
	end
end)

RegisterNetEvent('xt-tieuphu:client:thaydo', function()
    local ped = PlayerPedId()
    if not thaydo then
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
            thaydo = true
            addBlipTieuphu()
            exports['xt-notify']:Alert("THÔNG BÁO", "Chặt gỗ thôi nào!", 5000, 'success')
        end)
    else
        local health = GetEntityHealth(ped)
        local maxhealth = GetEntityMaxHealth(ped)
        QBCore.Functions.Progressbar("thay-do", "Thay đồ", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("qb-clothes:loadPlayerSkin")
            thaydo = false
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
    exports['qb-target']:AddCircleZone("tieuphu", vector3(pedcoords.x, pedcoords.y, pedcoords.z), 2.0, {
        name="tieuphu",
        debugPoly=false,
        useZ=true,
        }, {
            options = {
                {
                    type = "client",
                    event = "xt-tieuphu:client:thaydo",
                    icon = "fa-solid fa-axe",
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
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        if thaydo then
            for k, v in pairs(Config.PickingPositions) do
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 5 then
                    closeTo = v
                    break
                end
            end
            if type(closeTo) == 'table' then
                while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 5  do
                    Wait(3)
                    if picking == false then
                        DrawMarker(27, closeTo.coords.x, closeTo.coords.y, closeTo.coords.z-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                        QBCore.Functions.DrawText3D(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z,'[~g~E~s~] - Chặt gỗ')
                        if IsControlJustPressed(1, 51) then
                            picking = true
                            DisableControlAction(1, 51, true)
                            FreezeEntityPosition(ped, true)
                            local axe = CreateObject(GetHashKey('w_me_hatchet'), pos.x, pos.y, pos.z, true, false, false)
                            CreateThread(function()
                                while true do
                                    Wait(5000)
                                    if picking then
                                        LoadDict("melee@hatchet@streamed_core_fps")
                                        AttachEntityToEntity(axe, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
                                        TaskPlayAnim(ped, "melee@hatchet@streamed_core_fps", "plyr_front_takedown",  8.0, 8.0, -1, 80, 0, false, false, false)
                                        TriggerServerEvent('xt-tieuphu:pickcotton')
                                    else
                                        break
                                    end
                                end
                            end)
                            QBCore.Functions.Progressbar("xt_pick", "Chặt gỗ", (60000 * 5), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                ClearPedTasks(ped)
                                DeleteObject(axe)
                                picking = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end, function() -- Cancel
                                ClearPedTasks(ped)
                                DeleteObject(axe)
                                picking = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
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
        if thaydo then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = #(vector3(pos.x, pos.y, pos.z)-vector3(weavingcoords.x,weavingcoords.y,weavingcoords.z))
            if dist <= 5 then
                if not weaving then
                    sleep = 5
                    DrawMarker(27, weavingcoords.x, weavingcoords.y, weavingcoords.z-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    DrawText3D(weavingcoords.x, weavingcoords.y,weavingcoords.z + 0.5, '[~g~E~s~] - Xẻ gỗ')
                    if dist <= 2 then
                        if IsControlJustPressed(1, 51) then
                            weaving = true
                            DisableControlAction(1, 51, true)
                            FreezeEntityPosition(ped, true)
                            CreateThread(function()
                                while true do
                                    Wait(5000)
                                    if weaving then
                                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                            if result then
                                                LoadDict("amb@prop_human_bum_bin@idle_a")
                                                TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0, -8.0, -1, 2, 0, false, false, false)
                                                TriggerServerEvent('xt-tieuphu:weaving')
                                            else
                                                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['wood'].label, 5000, 'error')
                                                weaving = false
                                                TriggerEvent('progressbar:client:cancel')
                                                DisableControlAction(1, 51, false)
                                                FreezeEntityPosition(ped,false)
                                            end
                                        end, 'wood', 5)
                                    else
                                        break
                                    end
                                end
                            end)
                            QBCore.Functions.Progressbar("xt_weaving", "Xẻ gỗ", (60000 * 5), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                ClearPedTasks(ped)
                                weaving = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end, function() -- Cancel
                                ClearPedTasks(ped)
                                weaving = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end)
                        end
                    end
                end
            else
                weaving = false
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
        if thaydo then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = #(vector3(pos.x, pos.y, pos.z)-vector3(sewingcoords.x,sewingcoords.y,sewingcoords.z))
            if dist <= 5 then
                sleep = 5
                if not sewing then
                    DrawMarker(27, sewingcoords.x, sewingcoords.y, sewingcoords.z-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    DrawText3D(sewingcoords.x, sewingcoords.y,sewingcoords.z + 0.5, '[~g~E~s~] - Ép gỗ')
                    if dist <= 2 then
                        if IsControlJustPressed(1, 51) then
                            sewing = true
                            DisableControlAction(1, 51, true)
                            FreezeEntityPosition(ped, true)
                            CreateThread(function()
                                while true do
                                    Wait(5000)
                                    if sewing then
                                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                            if result then
                                                LoadDict("amb@prop_human_bum_bin@idle_a")
                                                TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0, -8.0, -1, 2, 0, false, false, false)
                                                TriggerServerEvent('xt-tieuphu:sewing')
                                            else
                                                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['cutted_wood'].label, 5000, 'error')
                                                sewing = false
                                                TriggerEvent('progressbar:client:cancel')
                                                DisableControlAction(1, 51, false)
                                                FreezeEntityPosition(ped,false)
                                            end
                                        end, 'cutted_wood', 5)
                                    else
                                        break
                                    end
                                end
                            end)
                            QBCore.Functions.Progressbar("xt_sewing", "Ép gỗ", (60000 * 5), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                ClearPedTasks(ped)
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped,false)
                                sewing = false
                            end, function() -- Cancel
                                ClearPedTasks(ped)
                                sewing = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end)
                        end
                    end
                end
            else
                sewing = false
                sleep = 2500
            end
        end
        Wait(sleep)
    end
end)