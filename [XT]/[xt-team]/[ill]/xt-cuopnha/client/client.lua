local HouseData, OffSets = nil, nil
local InsideHouse = false
local ShowingItems = false
local CurrentEvent = {}
local CurrentCops = 0
local CurrentHouse = nil
local LoggedIn = false
local Codo, AddedProp = false, false
local NearRobHouse = false
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    SetTimeout(450, function()
        QBCore.Functions.TriggerCallback("xt-cuopnha:server:get:config", function(ConfigData)
            Config = ConfigData
        end)
        LoggedIn = true
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    LoggedIn = false
end)

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)
local function RequestAnimationDict(AnimDict)
    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Wait(1)
    end
  end
  local AllProps = {}
local HasProp = false
local function RequestModelHash(Model)
    RequestModel(Model)
      while not HasModelLoaded(Model) do
          Wait(1)
      end
  end
local function AddProp(Name)
    if Config.PropList[Name] ~= nil then
      if not HasProp then
        HasProp = true
        RequestModelHash(Config.PropList[Name]['prop'])
        local CurrentProp = CreateObject(Config.PropList[Name]['hash'], 0, 0, 0, true, true, true)
        AttachEntityToEntity(CurrentProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), Config.PropList[Name]['bone-index']['bone']), Config.PropList[Name]['bone-index']['X'], Config.PropList[Name]['bone-index']['Y'], Config.PropList[Name]['bone-index']['Z'], Config.PropList[Name]['bone-index']['XR'], Config.PropList[Name]['bone-index']['YR'], Config.PropList[Name]['bone-index']['ZR'], true, true, false, true, 1, true)
        table.insert(AllProps, CurrentProp)
      end
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
end

local function RemoveProp()
  for k, v in pairs(AllProps) do
     NetworkRequestControlOfEntity(v)
     SetEntityAsMissionEntity(v, true, true)
     DetachEntity(v, 1, 1)
     DeleteEntity(v)
     DeleteObject(v)
  end
    AllProps = {}
    HasProp = false
end

local function AddPropToHands(PropName)
    Codo = true
    AddProp(PropName)
    if PropName ~= 'Duffel' then
        while Codo do
            Wait(4)
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
                RequestAnimationDict("anim@heists@box_carry@")
                TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
            else
                Wait(100)
            end
        end
    end
end

local function RemovePropFromHands()
    Codo = false
    RemoveProp()
    local ped = PlayerPedId()
    StopAnimTask(ped, 'anim@heists@box_carry@', 'idle', 1.0)
end
local function OpenDoorAnim()
    local ped = PlayerPedId()
    RequestAnimationDict('anim@heists@keycard@')
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Wait(400)
    ClearPedTasks(ped)
   end
local function EnterHouseRobbery()
    local HouseInterior = {}
    local ped = PlayerPedId()
    local CoordsTable = {x = Config.HouseLocations[CurrentHouse]['Coords']['X'], y = Config.HouseLocations[CurrentHouse]['Coords']['Y'], z = Config.HouseLocations[CurrentHouse]['Coords']['Z'] - Config.ZOffSet}
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    OpenDoorAnim()
    InsideHouse = true
    Wait(350)
    if Config.HouseLocations[CurrentHouse]['Tier'] == 1 then
        HouseInterior = exports['qb-interior']:CreateTier1HouseFurnished(CoordsTable)
    elseif Config.HouseLocations[CurrentHouse]['Tier'] == 2 then
        HouseInterior = exports['qb-interior']:CreateTier1HouseFurnished(CoordsTable)
    else
        HouseInterior = exports['qb-interior']:HouseRobTierThree(CoordsTable)
    end
    TriggerEvent('qb-weathersync:client:DisableSync')
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.25)
    HouseData, OffSets = HouseInterior[1], HouseInterior[2]
    if Config.HouseLocations[CurrentHouse]['HasDog'] ~= nil and Config.HouseLocations[CurrentHouse]['HasDog'] then
        RequestModelHash("A_C_Rottweiler")
        local SupriseEvent = CreatePed(GetPedType(GetHashKey("A_C_Rottweiler")), GetHashKey("A_C_Rottweiler"), Config.HouseLocations[CurrentHouse]['Dog']['X'], Config.HouseLocations[CurrentHouse]['Dog']['Y'], Config.HouseLocations[CurrentHouse]['Dog']['Z'], 90, 1, 0)
        TaskCombatPed(SupriseEvent, ped, 0, 16)
    --    SetPedKeepTask(SupriseEvent, true)
     --   SetEntityAsNoLongerNeeded(SupriseEvent)
        table.insert(CurrentEvent, SupriseEvent)
    end
end
local function LeaveHouseRobbery()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    OpenDoorAnim()
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    exports['qb-interior']:DespawnInterior(HouseData, function()
      SetEntityCoords(PlayerPedId(), Config.HouseLocations[CurrentHouse]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Coords']['Z'])
      TriggerEvent('qb-weathersync:client:EnableSync')
      DoScreenFadeIn(1000)
      CurrentHouse = nil
      HouseData, OffSets = nil, nil
      InsideHouse = false
      TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.25)
      if CurrentEvent ~= nil then
        for k, v in pairs(CurrentEvent) do
            DeleteEntity(v)
        end
        CurrentEvent = {}
      end
    end)
end
local function StealPropItem(Id)
    local StealObject = GetClosestObjectOfType(Config.HouseLocations[CurrentHouse]['Extras'][Id]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Extras'][Id]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Extras'][Id]['Coords']['Z'], 5.0, GetHashKey(Config.HouseLocations[CurrentHouse]['Extras'][Id]['PropName']), false, false, false)
    NetworkRequestControlOfEntity(StealObject)
    DeleteEntity(StealObject)
    TriggerServerEvent('xt-cuopnha:server:recieve:extra', CurrentHouse, Id)
 end
local function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
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
 local function LockpickAnim(time)
    time = time / 1000
    local ped = PlayerPedId()
    RequestAnimationDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    OpeningSomething = true
    CreateThread(function()
        while OpeningSomething do
            TriggerServerEvent('hud:server:RelieveStress', 3)
            TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            if time <= 0 then
                OpeningSomething = false
                StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
  end
local function OpenLocker(LockerId)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Time = math.random(15000, 18000)
    if not IsWearingHandshoes() then
      TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    LockpickAnim(Time)
    TriggerServerEvent('xt-cuopnha:server:set:locker:state', CurrentHouse, LockerId, 'Busy', true)
    QBCore.Functions.Progressbar("lockpick-locker", "Tìm kiếm", Time, false, true, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
      }, {}, {}, {}, function() -- Done
        TriggerServerEvent('xt-cuopnha:server:locker:reward', math.random(1,3))
        TriggerServerEvent('xt-cuopnha:server:set:locker:state', CurrentHouse, LockerId, 'Busy', false)
        TriggerServerEvent('xt-cuopnha:server:set:locker:state', CurrentHouse, LockerId, 'Opened', true)
        StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
      end, function() -- Cancel
        OpeningSomething = false
        TriggerServerEvent('xt-cuopnha:server:set:locker:state', CurrentHouse, LockerId, 'Busy', false)
        StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
    end)
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
local  function PoliceCall()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
        local closestPed = GetNearbyPed()
        local StreetLabel = QBCore.Functions.GetStreetLabel()
        if closestPed ~= nil then
            local gender = "người đàn ông"
            if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
                gender = "người phụ nữ"
            end
            local msg = "Có một " .. gender .." đang cố gắng đột nhập tại " .. StreetLabel
            TriggerServerEvent("police:server:HouseRobberyCall", pos, msg, StreetLabel)
        end

end
local usingAdvanced
local function lockpickFinish(Success)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if Success then
        local Time = math.random(13000, 17000)
        LockpickAnim(Time)
        QBCore.Functions.Progressbar("lockpick-door", "Phá khóa", Time, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('xt-cuopnha:server:set:door:status', CurrentHouse, true)
            StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
        end)
    else
        StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
        exports['xt-notify']:Alert("THÔNG BÁO", "Thất bại", 5000, 'error')
        if usingAdvanced then
            if math.random(26,40) > 25 then
                TriggerServerEvent("QBCore:Server:RemoveItem", 'advancedlockpick', 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['advancedlockpick'], "remove")
                exports['xt-notify']:Alert("THÔNG BÁO", "Thất bại", 5000, 'error')
                if math.random(1,100) <= 30 then
                --  TriggerServerEvent('evidence:server:CreateBloodDrop', pos)
                  exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã chọc trúng ngón tay của mình", 5000, 'error')
                end
            end
        else
            if math.random(0,1) >= 0 then
                TriggerServerEvent("QBCore:Server:RemoveItem", 'lockpick', 1)
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['lockpick'], "remove")
                if math.random(1,100) <= 50 then
                 --   TriggerServerEvent('evidence:server:CreateBloodDrop', pos)
                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã chọc trúng ngón tay của mình", 5000, 'error')
                end
            end
        end
    end
end


-- Code

RegisterNetEvent('xt-cuopnha:client:set:door:status', function(RobHouseId, bool)
    Config.HouseLocations[RobHouseId]['Opened'] = bool
end)

RegisterNetEvent('xt-cuopnha:client:set:locker:state', function(RobHouseId, LockerId, Type, bool)
    Config.HouseLocations[RobHouseId]['Lockers'][LockerId][Type] = bool
end)

RegisterNetEvent('xt-cuopnha:client:set:extra:state', function(RobHouseId, Id, bool)
    Config.HouseLocations[RobHouseId]['Extras'][Id]['Stolen'] = bool
end)

RegisterNetEvent('xt-cuopnha:server:reset:state', function(RobHouseId)
    Config.HouseLocations[RobHouseId]['Opened'] = bool
    for k, v in pairs(Config.HouseLocations[RobHouseId]["Lockers"]) do
        v["Opened"] = false
        v["Busy"] = false
    end
    if Config.HouseLocations[RobHouseId]["Extras"] ~= nil then
        for k, v in pairs(Config.HouseLocations[RobHouseId]["Extras"]) do
            v['Stolen'] = false
        end
    end
end)
CreateThread(function()
    while true do
        Wait(4)
        if LoggedIn then
            QBCore.Functions.TriggerCallback('xt-cuopnha:server:robbery:item', function(HoldItem)
                if HoldItem then
                    if not AddedProp then
                        AddedProp = true
                        AddPropToHands(HoldItem)
                    end
                else
                    if AddedProp then
                        AddedProp = false
                        RemovePropFromHands()
                    end
                end
            end)
            Wait(350)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(4)
        if LoggedIn then
            local ItemsNeeded = {[1] = {name = QBCore.Shared.Items["screwdriverset"]["name"], image = QBCore.Shared.Items["screwdriverset"]["image"]}, [2] = {name = QBCore.Shared.Items["lockpick"]["name"], image = QBCore.Shared.Items["lockpick"]["image"]}}
            NearRobHouse = false
            for k, v in pairs(Config.HouseLocations) do
                local ped = PlayerPedId()
                local PlayerCoords = GetEntityCoords(ped)
                local Distance = GetDistanceBetweenCoords(PlayerCoords.x ,PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true)
                if Distance < 2.0 then
                  NearRobHouse = true
                  CurrentHouse = k
                  if not ShowingItems and not v['Opened'] then
                    ShowingItems = true
                    TriggerEvent('inventory:client:requiredItems', ItemsNeeded, true)
                  end
                end
            end
            if not NearRobHouse then
                if ShowingItems then
                    ShowingItems = false
                    TriggerEvent('inventory:client:requiredItems', ItemsNeeded, false)
                end
                Wait(1500)
                if not InsideHouse then
                    CurrentHouse = nil
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(4)
        if LoggedIn then
            if CurrentHouse ~= nil then
                local ped = PlayerPedId()
                local PlayerCoords = GetEntityCoords(ped)
                if not InsideHouse and Config.HouseLocations[CurrentHouse]['Opened'] then
                    if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.HouseLocations[CurrentHouse]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Coords']['Z'], true) < 3.0) then
                        DrawMarker(2, Config.HouseLocations[CurrentHouse]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Coords']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                       DrawText3Ds(Config.HouseLocations[CurrentHouse]['Coords']['X'], Config.HouseLocations[CurrentHouse]['Coords']['Y'], Config.HouseLocations[CurrentHouse]['Coords']['Z'], '[~g~E~s~] - Đi vào trong')
                        if IsControlJustReleased(0, 38) then
                            EnterHouseRobbery()
                        end
                    end
                elseif InsideHouse then
                    if OffSets ~= nil then
                        if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.HouseLocations[CurrentHouse]['Coords']['X'] - OffSets.exit.x, Config.HouseLocations[CurrentHouse]['Coords']['Y'] - OffSets.exit.y, Config.HouseLocations[CurrentHouse]['Coords']['Z'] - OffSets.exit.z, true) < 1.4) then
                            DrawMarker(2, Config.HouseLocations[CurrentHouse]['Coords']['X'] - OffSets.exit.x, Config.HouseLocations[CurrentHouse]['Coords']['Y'] - OffSets.exit.y, Config.HouseLocations[CurrentHouse]['Coords']['Z'] - OffSets.exit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                           DrawText3Ds(Config.HouseLocations[CurrentHouse]['Coords']['X'] - OffSets.exit.x, Config.HouseLocations[CurrentHouse]['Coords']['Y'] - OffSets.exit.y, Config.HouseLocations[CurrentHouse]['Coords']['Z'] - OffSets.exit.z + 0.12, '[~g~E~s~] - Rời đi')
                            if IsControlJustReleased(0, 38) then
                               LeaveHouseRobbery()
                            end
                        end
                        for k, v in pairs(Config.HouseLocations[CurrentHouse]['Lockers']) do
                            if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true) < 1.5) then
                                local Text = '[~g~E~s~] - Trộm'
                                if Config.HouseLocations[CurrentHouse]['Lockers'][k]['Busy'] then Text = '~o~Bận...' elseif Config.HouseLocations[CurrentHouse]['Lockers'][k]['Opened'] then Text = '~r~Trống...' end
                               DrawText3Ds(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'] + 0.15, Text)
                                DrawMarker(2, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                                if IsControlJustReleased(0, 38) and not Config.HouseLocations[CurrentHouse]['Lockers'][k]['Opened'] and not Config.HouseLocations[CurrentHouse]['Lockers'][k]['Busy'] then
                                    OpenLocker(k)
                                end
                            end
                        end
                        if Config.HouseLocations[CurrentHouse]['Extras'] ~= nil then
                            for k, v in pairs(Config.HouseLocations[CurrentHouse]['Extras']) do
                                if not v['Stolen'] then
                                    if (GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true) < 1.7) then
                                       DrawText3Ds(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'] + 0.15, '[~g~E~s~] - Trộm')
                                        DrawMarker(2, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                                        if IsControlJustReleased(0, 38) then
                                            StealPropItem(k)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick', function(IsAdvanced)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    usingAdvanced = IsAdvanced
    if CurrentHouse ~= nil then
        if GetClockHours() >= 21 or GetClockHours() <= 6 then
            if CurrentCops >= Config.CopsNeeded then
                if usingAdvanced then
                    PoliceCall()
                    TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
                    if not IsWearingHandshoes() then
                        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                    end
                else
                    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
                        if HasItem then
                            PoliceCall()
                            TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
                            if not IsWearingHandshoes() then
                                TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                            end
                        else
                            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn cần "..QBCore.Shared.Items['screwdriverset'].label, 5000, 'error')
                        end
                    end, "screwdriverset")
                end
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Cần có ("..Config.CopsNeeded.." cảnh sát trong ca trực)", 5000, 'warning')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Có vẻ chủ nhà chưa đi ngủ", 5000, 'error')
        end
    end
end)






