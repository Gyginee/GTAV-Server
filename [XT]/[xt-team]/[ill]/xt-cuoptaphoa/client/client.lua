local CurrentSafe, NearSafe = nil, false
local CurrentRegister, NearRegister = nil, false
local CurrentCops = 0
local isLoggedIn = false
local onDuty
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  SetTimeout(1250, function()
      QBCore.Functions.TriggerCallback("xt-cuoptaphoa:server:get:config", function(ConfigData)
        Config = ConfigData
      end)
      isLoggedIn = true
      PlayerJob = QBCore.Functions.GetPlayerData().job
      onDuty = true
  end)
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)
RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

-- Function
local lockpick = false
local function RequestAnimationDict(AnimDict)
    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Wait(1)
    end
end
local function TakeAnimation()
    local ped = PlayerPedId()
    RequestAnimationDict("amb@prop_human_bum_bin@idle_b")
    local den = math.random(1, 2)
    if den > 1 then
        TriggerServerEvent('hud:server:RelieveStress', 1)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(1500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end
local function IsWearingHandshoes()
    local ped = PlayerPedId()
    local armIndex = GetPedDrawableVariation(ped, 3)
    local model = GetEntityModel(ped)
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
  end

local function DrawText3Ds(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
end
local function GetNearbyPed()
    local retval = nil
    local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
    if not IsEntityDead(closestPed) and closestDistance < 50.0 then
        retval = closestPed
    end
    return retval
end
local function PoliceCall()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local chance = 100
    if GetClockHours() >= 1 and GetClockHours() <= 6 then
        chance = 50
    end
    if math.random(1, 100) <= chance then
        local closestPed = GetNearbyPed()
        local StreetLabel = QBCore.Functions.GetStreetLabel()
        if closestPed ~= nil then
            local gender = "người đàn ông"
            if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
                gender = "người phụ nữ"
            end
            local msg = "Có một " .. gender .." đang cố gắng cạy máy quầy thu ngân tại " .. StreetLabel
            TriggerServerEvent("police:server:StoreRobberyCall", pos, msg, StreetLabel)
        end
    end
end

local function CrackSafe(SafeId, IsAdvanced)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    PoliceCall()
    if not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    FreezeEntityPosition(ped, true)
    TriggerServerEvent('xt-cuoptaphoa:server:safe:busy', SafeId, true)
    exports['minigame-safecrack']:StartSafeCrack(8, function(OutCome)
        if OutCome == true then
            TriggerServerEvent("xt-cuoptaphoa:server:safe:reward", SafeId)
            TriggerServerEvent('xt-cuoptaphoa:server:safe:busy', SafeId, false)
            TriggerServerEvent("xt-cuoptaphoa:server:safe:robbed", SafeId, true)
            FreezeEntityPosition(ped, false)
            TakeAnimation()
        elseif OutCome == false and OutCome ~= 'Escaped' then
            if IsAdvanced then
                if math.random(1,100) <= 35 then
                --  TriggerServerEvent('evidence:server:CreateBloodDrop', pos)
                  TriggerServerEvent('QBCore:Server:RemoveItem', 'advancedlockpick', 1)
                  TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['advancedlockpick'], "remove")
                end
            else
                if math.random(1,100) <= 50 then
                --  TriggerServerEvent('evidence:server:CreateBloodDrop', pos)
                  TriggerServerEvent('QBCore:Server:RemoveItem', 'lockpick', 1)
                  TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['lockpick'], "remove")
                end
            end
            exports['xt-notify']:Alert("THÔNG BÁO", "Thất bại", 5000, 'error')
            TriggerServerEvent('xt-cuoptaphoa:server:safe:busy', SafeId, false)
            FreezeEntityPosition(ped, false)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Thất bại", 5000, 'error')
            TriggerServerEvent('xt-cuoptaphoa:server:safe:busy', SafeId, false)
            FreezeEntityPosition(ped, false)
        end
    end)
end
local function LockpickDoorAnim()
    lockpick = true
    local ped = PlayerPedId()
    CreateThread(function()
        while true do
            if lockpick then
                local den = math.random(1, 2)
                if den > 1 then
                    TriggerServerEvent('hud:server:RelieveStress', 5)
                end
                RequestAnimationDict("veh@break_in@0h@p_m_one@")
                TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)

            else
                StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                break
            end
            Wait(5000)
        end
    end)
end

local usingAdvanced
local function lockpickFinish(success)
    if success then
        TriggerServerEvent('xt-cuoptaphoa:server:set:register:robbed', CurrentRegister, true)
        TriggerServerEvent('xt-cuoptaphoa:server:set:register:busy', CurrentRegister, false)
        CreateThread(function()
            while true do
                Wait(5000)
                if lockpick then
                    TriggerServerEvent('xt-cuoptaphoa:server:rob:register', CurrentRegister, false)
                else
                    break
                end
            end
        end)
        QBCore.Functions.Progressbar("search_register", "Cướp máy tính tiền", math.random(10000, 15000), false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            lockpick = false
            TriggerServerEvent('xt-cuoptaphoa:server:rob:register', CurrentRegister, true)
        end)
    else
        lockpick = false
        if usingAdvanced then
            if math.random(26,40) > 25 then
                TriggerServerEvent("QBCore:Server:RemoveItem", 'advancedlockpick', 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['advancedlockpick'], "remove")
            end
        else
            if math.random(0,1) >= 0 then
                TriggerServerEvent("QBCore:Server:RemoveItem", 'lockpick', 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['lockpick'], "remove")
            end
        end
        exports['xt-notify']:Alert("THÔNG BÁO", "Thất bại", 5000, 'error')
        TriggerServerEvent('xt-cuoptaphoa:server:set:register:busy', CurrentRegister, false)
    end
end




-- Code

CreateThread(function()
    while true do
        Wait(4)
        if isLoggedIn then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            NearRegister = false
            for k, v in pairs(Config.Registers) do
                local dist = #(pos - Config.Registers[k][1].xyz)
                if dist < 1.2 then
                  NearRegister = true
                  CurrentRegister = k
                  if Config.Registers[k].robbed then
                    DrawText3Ds(Config.Registers[k][1].xyz, '~r~Máy tính tiền trống')
                  else
                    DrawText3Ds(Config.Registers[k][1].xyz, '~o~Trộm')
                  end
               end
            end
            if not NearRegister then
                Wait(1500)
                CurrentRegister = nil
            end
        else
            Wait(1500)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(4)
        if isLoggedIn then
            local pos = GetEntityCoords(PlayerPedId())
            NearSafe = false
            for safe,_ in pairs(Config.Safes) do
                local dist1 = #(pos - Config.Safes[safe][1].xyz)
                if dist1 < 1.5 then
                    NearSafe = true
                    CurrentSafe = safe
                    if Config.Safes[safe].robbed then
                        DrawText3Ds(Config.Safes[safe][1].xyz, '~r~Két sắt trống')
                    else
                        DrawText3Ds(Config.Safes[safe][1].xyz, '~o~Cướp hòm tiền')
                    end
                end
            end
             if not NearSafe then
                 Wait(1500)
                 CurrentSafe = nil
             end
        else
           Wait(1500)
        end
    end
end)

-- // Events \\ --

RegisterNetEvent('xt-cuoptaphoa:client:set:register:robbed', function(RegisterId, bool)
    Config.Registers[RegisterId].robbed = bool
end)

RegisterNetEvent('xt-cuoptaphoa:client:set:register:busy', function(RegisterId, bool)
    Config.Registers[RegisterId].busy = bool
end)

RegisterNetEvent('xt-cuoptaphoa:client:safe:busy', function(SafeId, bool)
    Config.Safes[SafeId].busy = bool
end)

RegisterNetEvent('xt-cuoptaphoa:client:safe:robbed', function(SafeId, bool)
    Config.Safes[SafeId].robbed = bool
end)

RegisterNetEvent('lockpicks:UseLockpick', function(IsAdvanced)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    usingAdvanced = IsAdvanced
    if NearRegister then
        local dist = #(pos - Config.Registers[CurrentRegister][1].xyz)
        if dist < 1.3 and not Config.Registers[CurrentRegister].robbed then
            if CurrentCops >= Config.PoliceNeeded then
                if usingAdvanced then
                    PoliceCall()
                    LockpickDoorAnim()
                    TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
                    if not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                    end
                    TriggerServerEvent('xt-cuoptaphoa:server:set:register:busy', CurrentRegister, true)
                else
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                        if result then
                            PoliceCall()
                            LockpickDoorAnim()
                            if not IsWearingHandshoes() then
                                TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                            end
                            TriggerServerEvent('xt-cuoptaphoa:server:set:register:busy', CurrentRegister, true)
                            TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
                        else
                            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn cần "..QBCore.Shared.Items['screwdriverset'].label, 5000, 'error')
                        end
                    end, "screwdriverset")
                end
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ cảnh sát hiện hữu, yêu cầu "..Config.PoliceNeeded.." cảnh sát", 5000, 'error')
            end
        end
    elseif NearSafe then
        local dist1 = #(pos - Config.Safes[CurrentSafe][1].xyz)
        if dist1 < 1.3 and not Config.Safes[CurrentSafe].robbed then
            if CurrentCops >= Config.PoliceNeeded then
                if IsAdvanced then
                    CrackSafe(CurrentSafe, IsAdvanced)
                else
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                        if result then
                            CrackSafe(CurrentSafe, IsAdvanced)
                        else
                            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn cần "..QBCore.Shared.Items['screwdriverset'].label, 5000, 'error')
                        end
                    end, "screwdriverset")
                end
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ cảnh sát hiện hữu, yêu cầu "..Config.PoliceNeeded.." cảnh sát", 5000, 'error') 
            end
        end
    end
end)

