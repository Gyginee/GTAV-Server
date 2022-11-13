
QBCore = exports['qb-core']:GetCoreObject()

local ispick = false
local ispacking = false
local getcoords = Config.getCoords
local packingcoords = Config.packingCoords
local closeTo = 0
local thaydocoords =  Config.Thaydo
local pedcoords =  Config.Ped
local dohc = false
local blip2

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    exports['qb-target']:AddCircleZone("haicam", vector3(pedcoords.x, pedcoords.y, pedcoords.z), 2.0, {
        name="haicam",
        debugPoly=false,
        useZ=true,
    }, {
        options = {
        {
            type = "client",
            event = "xt-haicam:client:thaydo",
            icon = "fa-solid fa-citrus-slice",
            label = "Nhận/Huỷ công việc",
        },
    },
    distance = 2.0
    })
end)

local nongdan
local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
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
local function addBlipHaicam()
    blip2 = AddBlipForCoord(packingcoords.x, packingcoords.y, packingcoords.z)
    SetBlipSprite(blip2, 478)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 0.6)
    SetBlipAsShortRange(blip2, true)
    SetBlipColour(blip2, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~o~[Hái cam]~s~ - Đóng gói cam")
    EndTextCommandSetBlipName(blip2)

end
CreateThread(function()
    local blip = AddBlipForCoord(getcoords.x, getcoords.y, getcoords.z)
    SetBlipSprite(blip, 478)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Thu hoạch cam")
    EndTextCommandSetBlipName(blip)
end)
RegisterNetEvent('xt-haicam:client:thaydo', function()
    local ped = PlayerPedId()
    if not dohc then
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
            dohc = true
            addBlipHaicam()
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
                dohc = false
                exports['xt-notify']:Alert("THÔNG BÁO", "Mai lại đến nhé!", 5000, 'success')
            end)
            RemoveBlip(blip2)
            SetPedMaxHealth(PlayerId(), maxhealth)
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
            SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
            Wait(3000) -- Safety Delay
            SetEntityHealth(ped, health)
    end
end)




CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        if dohc then
            for k, v in pairs(Config.pickingPositions) do
                if GetDistanceBetweenCoords(pos, v.coords, true) <= 5 then
                    closeTo = v
                    break
                end
            end
            if type(closeTo) == 'table' then
                while GetDistanceBetweenCoords(pos, closeTo.coords, true) <= 5 do
                    sleep = 200
                    if ispick == false then
                        DrawMarker(25, closeTo.coords.x, closeTo.coords.y, closeTo.coords.z-0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                        QBCore.Functions.DrawText3D(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z + 0.5,'[~g~E~w~] - Thu hoạch cam')
                        if IsControlJustPressed(1, 51) then
                            ispick = true
                            DisableControlAction(1, 51, true)
                            FreezeEntityPosition(PlayerPedId(), true)
                            CreateThread(function()
                                while true do
                                    Wait(5000)
                                    if ispick then
                                        LoadDict("amb@prop_human_movie_bulb@idle_a")
                                        TaskPlayAnim(ped, "amb@prop_human_movie_bulb@idle_a", "idle_a", 8.0, -8.0, -1, 1, 0, false, false, false,false, false, false)
                                        TriggerServerEvent('xt-haicam:getOrange')
                                    else
                                        break
                                    end
                                end
                            end)
                            QBCore.Functions.Progressbar("qg-getor", "Thu hoạch", (60000 * 5), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                                disableAll = true
                            }, {}, {}, {}, function() -- Done
                                ClearPedTasks(ped)
                                ispick = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end, function() -- Cancel
                                ClearPedTasks(ped)
                                ispick = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    local sleep
    while true do
        sleep = 1000
        if dohc then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = #(vector3(pos.x, pos.y, pos.z) - vector3(packingcoords.x, packingcoords.y, packingcoords.z))
            if dist <= 10 then
                sleep = 200
                if not ispacking then
                    DrawMarker(25, packingcoords.x, packingcoords.y, packingcoords.z-0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    DrawText3D(packingcoords.x, packingcoords.y, packingcoords.z + 0.5, '[~g~E~s~] - Đóng thùng')
                    if dist <= 2 then
                        if IsControlJustPressed(1, 51) then
                            ispacking = true
                            DisableControlAction(1, 51, true)
                            FreezeEntityPosition(ped, true)
                            CreateThread(function()
                                while true do
                                    Wait(5000)
                                    if ispacking then
                                        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                            if result then
                                                LoadDict("amb@prop_human_bum_bin@base")
                                                TaskPlayAnim(ped, "amb@prop_human_bum_bin@base", "base", 8.0, -8.0, -1, 1, 0,false, false, false)
                                                TriggerServerEvent('xt-haicam:getPackOrange')
                                            else
                                                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['orange'].label, 5000, 'error')
                                                ispacking = false
                                                DisableControlAction(1, 51, false)
                                                FreezeEntityPosition(ped, false)
                                                TriggerEvent('progressbar:client:cancel')
                                            end
                                        end, 'orange', 20)
                                    else
                                        break
                                    end
                                end
                            end)
                            QBCore.Functions.Progressbar("qg-packOrange", "Đóng thùng", (60000 * 5), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                                disableAll = true
                            }, {}, {}, {}, function() -- Done
                                ClearPedTasks(ped)
                                ispacking = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end, function() -- Cancel
                                ClearPedTasks(ped)
                                ispacking = false
                                DisableControlAction(1, 51, false)
                                FreezeEntityPosition(ped, false)
                            end)
                        end
                    end
                end
            else
                ispacking = false
                sleep = 2500
            end
        end
        Wait(sleep)
    end
end)


