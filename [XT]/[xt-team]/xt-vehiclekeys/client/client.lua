QBCore = exports['qb-core']:GetCoreObject()
local LastVehicle = nil
local isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SetTimeout(1250, function()
        Wait(100)
        QBCore.Functions.TriggerCallback("xt-vehiclekeys:server:get:key:config", function(config)
            Config = config
        end)
        isLoggedIn = true
    end)
end)

local function RequestAnimationDict(AnimDict)
    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Wait(1)
    end
end
function SetVehicleKey(Plate, bool)
    TriggerServerEvent('xt-vehiclekeys:server:set:keys', Plate, bool)
end

local function ToggleLocks()
    local Vehicle, VehDistance = QBCore.Functions.GetClosestVehicle()
    if Vehicle ~= nil and Vehicle ~= 0 then
       local VehicleLocks = GetVehicleDoorLockStatus(Vehicle)
       local Plate = GetVehicleNumberPlateText(Vehicle)
       local ped = PlayerPedId()
       if VehDistance <= 2.2 then
           QBCore.Functions.TriggerCallback("xt-vehiclekeys:server:has:keys", function(HasKey)
            if HasKey then
               RequestAnimationDict("anim@mp_player_intmenu@key_fob@")
               TaskPlayAnim(ped, 'anim@mp_player_intmenu@key_fob@', 'fob_click' ,3.0, 3.0, -1, 49, 0, false, false, false)
               if VehicleLocks == 1 then
                   Wait(450)
                   SetVehicleDoorsLocked(Vehicle, 2)
                   ClearPedTasks(ped)
                   TriggerEvent('xt-vehiclekeys:client:blink:lights', Vehicle)
                   exports['xt-notify']:Alert("THÔNG BÁO", "Đã <span style='color:#fc1100'><b>khóa<b></span> xe", 5000, 'error')
                   TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "lock", 0.3)
               else
                   Wait(450)
                   SetVehicleDoorsLocked(Vehicle, 1)
                   ClearPedTasks(ped)
                   TriggerEvent('xt-vehiclekeys:client:blink:lights', Vehicle)
                   exports['xt-notify']:Alert("THÔNG BÁO", "Đã <span style='color:#30ff00'><b>mở khóa<b></span> xe", 5000, 'success')
                   TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "unlock", 0.3)
               end
            else
               exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không có <span style='color:#fc1100'><b>chìa khóa<b></span> của chiếc xe này", 5000, 'error')
           end
       end, Plate)
       end
    end
   end
-- Code

-- // Loops \\ --
CreateThread(function()
    while true do
        Wait(5)
        if isLoggedIn then
        local ped = PlayerPedId()
        local Vehicle = GetVehiclePedIsIn(ped, false)
        local Plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true))
        if IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, true), -1) == ped then
            if LastVehicle ~= Vehicle then
            QBCore.Functions.TriggerCallback("xt-vehiclekeys:server:has:keys", function(HasKey)
                if HasKey then
                    HasCurrentKey = true
                    SetVehicleEngineOn(Vehicle, true, false, true)
                else
                    HasCurrentKey = false
                    SetVehicleEngineOn(Vehicle, false, false, true)
                end
                LastVehicle = Vehicle
            end, Plate)
            else
            Wait(750)
          end
        else
            Wait(750)
        end
        if not HasCurrentKey and IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped then
            SetVehicleEngineOn(Vehicle, false, false, true)
        end
     end
    end
end)

CreateThread(function()
    while true do
        Wait(5)
        if isLoggedIn then
            if IsControlJustReleased(1, Config.Keys["L"]) then
                ToggleLocks()
            end
        end
    end
end)

-- // Events \\ --

RegisterNetEvent('xt-vehiclekeys:client:toggle:engine', function()
    local ped = PlayerPedId()
    local EngineOn = IsVehicleEngineOn(GetVehiclePedIsIn(ped))
    local Vehicle = GetVehiclePedIsIn(ped, false)
    local Plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(ped, true))
    QBCore.Functions.TriggerCallback("xt-vehiclekeys:server:has:keys", function(HasKey)
        if HasKey then
            if EngineOn then
                SetVehicleEngineOn(Vehicle, false, false, true)
            else
                SetVehicleEngineOn(Vehicle, true, false, true)
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không có <span style='color:#fc1100'><b>chìa khóa<b></span> của chiếc xe này", 5000, 'error')
        end
    end, Plate)
end)

RegisterNetEvent('xt-vehiclekeys:client:set:keys' , function(Plate, CitizenId, bool)
    Config.VehicleKeys[Plate] = {['CitizenId'] = CitizenId, ['HasKey'] = bool}
    LastVehicle = nil
end)

RegisterNetEvent('xt-vehiclekeys:client:give:key', function()
    local Vehicle, VehDistance = QBCore.Functions.GetClosestVehicle()
    local Player, Distance = QBCore.Functions.GetClosestPlayer()
    local Plate = GetVehicleNumberPlateText(Vehicle)
    QBCore.Functions.TriggerCallback("xt-vehiclekeys:server:has:keys", function(HasKey)
        if HasKey then
            if Player ~= -1 and Player ~= 0 and Distance < 2.3 then
                 exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã đưa chìa khóa cho chiếc xe có biển số: <span style='color:#30ff00'><b>"..Plate.."<b></span>", 5000, 'success')
                 TriggerServerEvent('xt-vehiclekeys:server:give:keys', GetPlayerServerId(Player), Plate, true)
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Không có ai ở <span style='color:#fc1100'><b>gần<b></span> bạn", 5000, 'error')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không có <span style='color:#fc1100'><b>chìa khóa<b></span> của chiếc xe này", 5000, 'error')
        end
    end, Plate)
end)

local usingAdvanced

local function lockpickFinish(success)
    local ped = PlayerPedId()
    local Vehicle, VehDistance = QBCore.Functions.GetClosestVehicle()
    local Plate = GetVehicleNumberPlateText(Vehicle)
    StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
    if success then
        SetVehicleKey(Plate, true)
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã nhận được chìa khoá của phương tiện <span style='color:#30ff00'><b>" ..Plate.."<b></span>", 5000, 'success')
    else
        if usingAdvanced then
            if math.random(10,40) > 30 then
                TriggerServerEvent("QBCore:Server:RemoveItem", 'advancedlockpick', 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['advancedlockpick'], "remove")
            end
        else
            if math.random(0,1) > 0 then
                TriggerServerEvent("QBCore:Server:RemoveItem", 'lockpick', 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['lockpick'], "remove")
            end
        end
    end
end

RegisterNetEvent('lockpicks:UseLockpick', function(IsAdvanced)
    local ped = PlayerPedId()
    local Vehicle, VehDistance = QBCore.Functions.GetClosestVehicle()
    local Plate = GetVehicleNumberPlateText(Vehicle)
    usingAdvanced = IsAdvanced
    if VehDistance <= 4.5 then
        QBCore.Functions.TriggerCallback("xt-vehiclekeys:server:has:keys", function(HasKey)
            if not HasKey then
                if IsPedInAnyVehicle(ped, false) then
                    RequestAnimationDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                    TaskPlayAnim(ped, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer' ,3.0, 3.0, -1, 16, 0, false, false, false)
                    if usingAdvanced then
                        TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
                    else
                        TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
                    end
                end
            end
        end, Plate)
    end
end)
-- // Functions \\ --

RegisterNetEvent('xt-vehiclekeys:client:blink:lights', function(Vehicle)
    SetVehicleLights(Vehicle, 2)
    SetVehicleBrakeLights(Vehicle, true)
    SetVehicleInteriorlight(Vehicle, true)
    SetVehicleIndicatorLights(Vehicle, 0, true)
    SetVehicleIndicatorLights(Vehicle, 1, true)
    Wait(450)
    SetVehicleIndicatorLights(Vehicle, 0, false)
    SetVehicleIndicatorLights(Vehicle, 1, false)
    Wait(450)
    SetVehicleInteriorlight(Vehicle, true)
    SetVehicleIndicatorLights(Vehicle, 0, true)
    SetVehicleIndicatorLights(Vehicle, 1, true)
    Wait(450)
    SetVehicleLights(Vehicle, 0)
    SetVehicleBrakeLights(Vehicle, false)
    SetVehicleInteriorlight(Vehicle, false)
    SetVehicleIndicatorLights(Vehicle, 0, false)
    SetVehicleIndicatorLights(Vehicle, 1, false)
end)
