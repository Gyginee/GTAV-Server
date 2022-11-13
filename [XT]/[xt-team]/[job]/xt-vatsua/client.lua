QBCore = exports['qb-core']:GetCoreObject()

local thaydocoords =  Config.Thaydo
local pedcoords =  Config.Ped
isMilk = true
local dovs = false
local c1 = vector3(2441.06, 4755.95, 33.35)
local c2 = vector3(2443.96, 4764.95, 33.35)
local c3 = vector3(2434.76, 4764.95, 33.35)
local c4 = vector3(2430.76, 4773.95, 33.45)
local blip

local nongdan
local ttcoords = Config.ttcoords

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
            exports['qb-target']:AddCircleZone("vatsua", vector3(pedcoords.x, pedcoords.y, pedcoords.z), 2.0, {
                name="vatsua",
                debugPoly=false,
                useZ=true,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "xt-vatsua:client:thaydo",
                            icon = "fa-solid fa-bucket",
                            label = "Nhận/Huỷ công việc",
                        },
                        },
                    distance = 2.0
                })
end)
local function loadAnimDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end

local function DrawText3D(x, y, z, text)
	SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
end
local function addBlipSuabo()
    local blip = AddBlipForCoord( ttcoords.x, ttcoords.y, ttcoords.z)
    SetBlipSprite(blip, 266)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 35)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~b~[Vắt sữa]~s~ Tiệt trùng sữa")
    EndTextCommandSetBlipName(blip)
end
CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local nongdanped = "a_m_m_farmer_01"
        local dist = #(pos - vector3(pedcoords.x, pedcoords.y, pedcoords.z))
        if dist <= 25.0  then
            sleep = 5
            if not DoesEntityExist(nongdan) then
                RequestModel(nongdanped)
                while not HasModelLoaded(nongdanped) do
                    Wait(10)
                end
                nongdan = CreatePed(26, nongdanped, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.w, false, false)
                SetEntityHeading(nongdan, pedcoords.w)
                FreezeEntityPosition(nongdan, true)
                SetEntityInvincible(nongdan, true)
                SetBlockingOfNonTemporaryEvents(nongdan, true)
                TaskStartScenarioInPlace(nongdan, "WORLD_HUMAN_CLIPBOARD", 0, false)
            end
        else
            sleep = 1500
        end
        if dist <= 5.0 then
            DrawText3D(pedcoords.x, pedcoords.y, pedcoords.z + 1.9, "~o~NÔNG DÂN")
        end
    Wait(sleep)
    end
end)

CreateThread(function()
    local cowcoords = Config.cowcoords
    local blip2 = AddBlipForCoord(cowcoords.x, cowcoords.y, cowcoords.z)
    SetBlipSprite(blip2, 141)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 0.6)
    SetBlipAsShortRange(blip2, true)
    SetBlipColour(blip2, 53)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Trang trại bò sữa")
    EndTextCommandSetBlipName(blip2)
end)
RegisterNetEvent('xt-vatsua:client:thaydo',function()
    local ped = PlayerPedId()
    if not dovs then
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
                SetPedPropIndex(ped, 0, Config.Clothes.male['hat_1'], Config.Clothes.male['hat_2'], true) -- mũ
            else
                SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
                SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0)
                SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0)
                SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0)
                SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0)
                SetPedPropIndex(ped, 0, Config.Clothes.female['hat_1'], Config.Clothes.female['hat_2'], true) -- mũ
            end
            dovs = true
            addBlipSuabo()
            exports['xt-notify']:Alert("THÔNG BÁO", "Bắt đầu nào!", 5000, 'success')
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
            dovs = false
            exports['xt-notify']:Alert("THÔNG BÁO", "Mai lại đến nhé!", 5000, 'success')
        end)
        RemoveBlip(blip)
        SetPedMaxHealth(PlayerId(), maxhealth)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
        Wait(3000) -- Safety Delay
        SetEntityHealth(PlayerPedId(), health)
    end
end)



CreateThread(function()
    while true do
        local sleep = 2000
        if dovs then
            local coords = GetEntityCoords(GetPlayerPed(-1))
                if (GetDistanceBetweenCoords(coords, c1.x, c1.y, c1.z, true) < 1.5) then
                    sleep = 0
                    DrawMarker(25, c1.x, c1.y, c1.z, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    QBCore.Functions.DrawText3D(c1.x, c1.y, c1.z + 1.75, '~b~Bò sữa')
                    isMilk = false 
                    Config.CanMilk = true
                elseif (GetDistanceBetweenCoords(coords, c2.x, c2.y, c2.z, true) < 1.5) then
                    sleep = 0
                    DrawMarker(25, c2.x, c2.y, c2.z, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    QBCore.Functions.DrawText3D(c2.x, c2.y, c2.z + 1.75, '~b~Bò sữa')
                    isMilk = false
                    Config.CanMilk = true
                elseif (GetDistanceBetweenCoords(coords, c3.x, c3.y, c3.z, true) < 1.5) then
                    sleep = 0
                    DrawMarker(25, c3.x, c3.y, c3.z, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    QBCore.Functions.DrawText3D(c3.x, c3.y, c3.z + 1.75, '~b~Bò sữa')
                    isMilk = false 
                    Config.CanMilk = true
                elseif (GetDistanceBetweenCoords(coords, c4.x, c4.y, c4.z, true) < 1.5) then
                    sleep = 0
                    DrawMarker(25, c4.x, c4.y, c4.z, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    QBCore.Functions.DrawText3D(c4.x, c4.y, c4.z + 1.75, '~b~Bò sữa')
                    isMilk = false
                    Config.CanMilk = true
                else
                    isMilk = true 
                    Config.CanMilk = false
                end
            end
        Wait(sleep)
    end
end)

RegisterNetEvent('xt-vatsua:client:use:bucket', function()
    if Config.CanMilk then
        if isMilk == false then

                        local PedCoords = GetEntityCoords(GetPlayerPed())
                        local bucket = CreateObjectNoOffset(GetHashKey('prop_bucket_02a'), PedCoords.x, PedCoords.y, PedCoords.z,
                            true, false, false)
                        AttachEntityToEntity(bucket, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.09,
                            -0.3, -0.02, 0.0, 0.0, 0.0, false, true, true, true, 0, true)
                        loadAnimDict("amb@prop_human_bum_bin@base")
                        TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, -8.0, Config.Timepick, 1, 0,
                            false, false, false)
                        TriggerEvent('inventory:client:set:busy', true)
                        QBCore.Functions.Progressbar("xt-vatsua", "Vắt sữa", Config.Timepick, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                            disableAll = true
                        }, {}, {}, {}, function() -- Done
                            exports['xt-doben']:UpdateToolQuality(1)
                            TriggerEvent('inventory:client:set:busy', false)
                            ClearPedTasks(PlayerPedId())
                            DeleteObject(bucket)
                            TriggerServerEvent('xt-vatsua:getMilk')
                            isMilk = false
                        end, function() -- Cancel
                            TriggerEvent('inventory:client:set:busy', false)
                            ClearPedTasks(PlayerPedId())
                            DeleteObject(bucket)
                            exports['xt-notify']:Alert("THÔNG BÁO", "Vắt sữa thất bại", 5000, 'error')
                            isMilk = false
                        end)
                    
            Wait(500)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Sống chậm thôi!", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Không thể vắt sữa!", 5000, 'error')
    end
end)

ttcoords = Config.ttcoords
CreateThread(function()
    local sleep
    while true do
        sleep = 5
        if dovs then
                local player = PlayerPedId()
                local playercoords = GetEntityCoords(player)
                local dist = #(vector3(playercoords.x, playercoords.y, playercoords.z) -
                                vector3(ttcoords.x, ttcoords.y, ttcoords.z))
                if dist <= 10 and not isTiettrung then
                    sleep = 5
                    DrawMarker(25, ttcoords.x, ttcoords.y, ttcoords.z-0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    DrawText3D(ttcoords.x, ttcoords.y, ttcoords.z + 0.5, '[~g~E~s~] - Tiệt trùng sữa')
                    if dist <= 2 and not isTiettrung then
                        if IsControlJustPressed(1, 51) then
                            isTiettrung = true            
                                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                        if result then
                                            TriggerEvent('inventory:client:set:busy', true)
                                            loadAnimDict("amb@prop_human_bum_bin@idle_a")
                                            TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0,
                                                -8.0, -1, 2, 0, false, false, false)
                                            QBCore.Functions.Progressbar("qg-wash", "Tiệt trùng", 5000, false,
                                                true, {
                                                    disableMovement = true,
                                                    disableCarMovement = true,
                                                    disableMouse = false,
                                                    disableCombat = true,
                                                    disableAll = true
                                                }, {}, {}, {}, function() -- Done
                                                    TriggerEvent('inventory:client:set:busy', false)
                                                    ClearPedTasks(PlayerPedId())
                                                    TriggerServerEvent('xt-vatsua:getfreshMilk')
                                                    isTiettrung = false
                                                end, function() -- Cancel
                                                    TriggerEvent('inventory:client:set:busy', false)
                                                    ClearPedTasks(PlayerPedId())
                                                    exports['xt-notify']:Alert("THÔNG BÁO",
                                                        "Tiệt trùng sữa thất bại", 5000, 'error')
                                                    isTiettrung = false
                                                end)
                                            Wait(500)
                                        else
                                            isTiettrung = false
                                            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['milk_bottle'].label, 5000,
                                                'error')
                                        end
                                    end, 'milk_bottle')
                        end
                    end
                else
                    isTiettrung = false
                    sleep = 2500
                end
            end
        Wait(sleep)
    end
end)



CreateThread(function()
    RequestModel(GetHashKey("a_c_cow"))
    while not HasModelLoaded(GetHashKey("a_c_cow")) do
        Wait(155)
    end
    local ped = CreatePed(4, GetHashKey("a_c_cow"), 2441.06, 4755.95, 33.35, -149.404, false, true)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    while true do
        Wait(10000)
        TaskPedSlideToCoord(ped, 2441.76, 4755.95, 33.45, -149.404, 10)
    end
end)

CreateThread(function()
    RequestModel(GetHashKey("a_c_cow"))
    while not HasModelLoaded(GetHashKey("a_c_cow")) do
        Wait(155)
    end 

    local ped = CreatePed(4, GetHashKey("a_c_cow"), 2443.96, 4764.95, 33.35, -349.404, false, true)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    while true do
        Wait(10000)
        TaskPedSlideToCoord(ped, 2443.76, 4764.95, 33.45, -349.404, 10)
    end
end)
CreateThread(function()
    RequestModel(GetHashKey("a_c_cow"))
    while not HasModelLoaded(GetHashKey("a_c_cow")) do
        Wait(155)
    end

    local ped = CreatePed(4, GetHashKey("a_c_cow"), 2434.76, 4764.95, 33.35, 149.404, false, true)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    while true do
        Wait(10000)
        TaskPedSlideToCoord(ped, 2434.76, 4764.95, 33.45, 749.404, 10)
    end
end)
CreateThread(function()
    RequestModel(GetHashKey("a_c_cow"))
    while not HasModelLoaded(GetHashKey("a_c_cow")) do
        Wait(155)
    end
    local ped = CreatePed(4, GetHashKey("a_c_cow"), 2430.76, 4773.95, 33.45, 749.404, false, true)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    while true do
        Wait(10000)
        TaskPedSlideToCoord(ped, 2430.76, 4773.95, 33.45, 749.404, 10)
    end
end)
