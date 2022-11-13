
QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
local ispick = false
local ispacking = false
local getcoords = Config.getCoords
local packingcoords = Config.packingCoords
local matchacoords = Config.matchaCoords
local thaydocoords =  Config.Thaydo
local pedcoords =  Config.Ped
local closeTo = 0
local dohc = false
local blip2, blip3
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
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    exports['qb-target']:AddCircleZone("haiche", vector3(pedcoords.x, pedcoords.y, pedcoords.z), 2.0, {
        name="haiche",
        debugPoly=false,
        useZ=true,
        }, {
                    options = {
                        {
                            type = "client",
                            event = "xt-haiche:client:thaydo",
                            icon = "fa-solid fa-mug-tea",
                            label = "Nhận/Huỷ công việc",
                        },
                        },
                    distance = 2.0
                })
end)
CreateThread(function()
	local StartJobBlip = AddBlipForCoord(thaydocoords.x, thaydocoords.y, thaydocoords.z)
	SetBlipSprite (StartJobBlip, 469)
	SetBlipDisplay(StartJobBlip, 4)
	SetBlipScale  (StartJobBlip, 0.8)
	SetBlipColour (StartJobBlip, 5)
	SetBlipAsShortRange(StartJobBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Đồi chè')
	EndTextCommandSetBlipName(StartJobBlip)
end)
CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local tieuphuped = "a_m_m_indian_01"
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
            DrawText3D(pedcoords.x, pedcoords.y, pedcoords.z + 1.9, "~o~NÔNG DÂN")
        end
    Wait(sleep)
	end
end)
local function addBlipHaiche()
    blip2 = AddBlipForCoord(packingcoords.x, packingcoords.y, packingcoords.z)
    SetBlipSprite(blip2, 469)
    SetBlipDisplay(blip2, 4)
    SetBlipScale(blip2, 0.8)
    SetBlipAsShortRange(blip2, true)
    SetBlipColour(blip2, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~g~[Hái chè]~s~ - Sấy khô")
    EndTextCommandSetBlipName(blip2)
    blip3 = AddBlipForCoord(matchacoords.x, matchacoords.y, matchacoords.z)
    SetBlipSprite(blip3, 469)
    SetBlipDisplay(blip3, 4)
    SetBlipScale(blip3, 0.8)
    SetBlipAsShortRange(blip3, true)
    SetBlipColour(blip3, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("~g~[Hái chè]~s~ - Nghiền matcha")
    EndTextCommandSetBlipName(blip3)
end


local function LoadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

RegisterNetEvent('xt-haiche:client:thaydo', function()
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
            else
                SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
                SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) 
                SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0)
                SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0)
                SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0)
            end
            dohc = true
            addBlipHaiche()
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
        RemoveBlip(blip3)
        SetPedMaxHealth(PlayerId(), maxhealth)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
        Wait(3000) -- Safety Delay
        SetEntityHealth(PlayerPedId(), health)
    end
end)

CreateThread(function()
    local sleep
    while true do
        sleep = 2000
        Config.CanPick = false
        if dohc then
            for k, v in pairs(Config.pickingPositions) do
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 5 then
                    closeTo = v
                    break
                end
            end
            if type(closeTo) == 'table' then
                while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 5 do
                        DrawMarker(27, closeTo.coords.x, closeTo.coords.y, closeTo.coords.z-0.75, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                            Wait(3)
                            sleep = 0
                        if ispick == false then
                            QBCore.Functions.DrawText3D(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z + 0.5,'[~b~E~w~] - Hái trà')
                            Config.CanPick = true
                            if IsControlJustPressed(1, 51) then
                                    ispick = true
                                    LoadDict("amb@prop_human_movie_bulb@idle_a")
                                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_movie_bulb@idle_a", "idle_a", 8.0, -8.0, Config.Timepick, 1, 0, false, false, false,
                                        false, false, false)
                                    QBCore.Functions.Progressbar("qg-gettea", "Thu hoạch", Config.Timepick, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableAll = true
                                    }, {}, {}, {}, function() -- Done
                                        ispick = false
                                        TriggerServerEvent('xt-haiche:getTea')
                                        ClearPedTasks(PlayerPedId())
                                    end, function() -- Cancel
                                        ClearPedTasks(PlayerPedId())
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Thu hoạch thất bại", 5000, 'error')
                                        ispick = false
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
        sleep = 2000
        if dohc then
                local player = PlayerPedId()
                local playercoords = GetEntityCoords(player)
                local dist = #(vector3(playercoords.x, playercoords.y, playercoords.z) -
                                vector3(packingcoords.x, packingcoords.y, packingcoords.z))
                if dist <= 5 and not ispacking then
                    sleep = 0
                    DrawMarker(25, packingcoords.x, packingcoords.y, packingcoords.z-0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    DrawText3D(packingcoords.x, packingcoords.y, packingcoords.z + 0.5, '[~g~E~w~] - Sấy khô')
                    if dist <= 2 and not ispacking then
                        if IsControlJustPressed(1, 51) then      
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then
                                    ispacking = true
                                    LoadDict("amb@prop_human_bum_bin@base")
                                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, -8.0, -1, 2, 0,false, false, false)
                                    QBCore.Functions.Progressbar("qg-dryTea", "Sấy khô", 5000, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableAll = true
                                    }, {}, {}, {}, function() -- Done
                                        ClearPedTasks(PlayerPedId())
                                        TriggerServerEvent('xt-haiche:getDryTea')
                                        ispacking = false
                                    end, function() -- Cancel
                                        ClearPedTasks(PlayerPedId())
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Sấy khô trà thất bại", 5000, 'error')
                                        ispacking = false
                                    end)
                                    Wait(500)
                                else
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['tea'].label, 5000, 'error')
                                    ispacking = false
                                end
                            end, 'tea')
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


CreateThread(function()
    local sleep
    while true do
        sleep = 2000
        if dohc then
                local player = PlayerPedId()
                local playercoords = GetEntityCoords(player)
                local dist = #(vector3(playercoords.x, playercoords.y, playercoords.z) -
                                vector3(matchacoords.x, matchacoords.y, matchacoords.z))
                if dist <= 5 and not ispacking then
                    sleep = 0
                    DrawMarker(25, matchacoords.x, matchacoords.y, matchacoords.z-0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                    DrawText3D(matchacoords.x, matchacoords.y, matchacoords.z + 0.5, '[~g~E~w~] - Nghiền bột')
                    if dist <= 2 and not ispacking then
                        if IsControlJustPressed(1, 51) then
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then
                                    ispacking = true
                                    LoadDict("amb@prop_human_bum_bin@base")
                                    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@base", "base", 8.0, -8.0, -1, 2, 0,false, false, false)
                                    QBCore.Functions.Progressbar("qg-matcha", "Nghiền", 5000, false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                        disableAll = true
                                    }, {}, {}, {}, function() -- Done
                                        ClearPedTasks(PlayerPedId())
                                        TriggerServerEvent('xt-haiche:getMatcha')
                                        ispacking = false
                                    end, function() -- Cancel
                                        ClearPedTasks(PlayerPedId())
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Nghiền trà thất bại", 5000, 'error')
                                        ispacking = false
                                    end)
                                    Wait(500)
                                else 
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ "..QBCore.Shared.Items['drytea'].label, 5000, 'error')
                                    ispacking = false
                                end
                            end, 'drytea')
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

