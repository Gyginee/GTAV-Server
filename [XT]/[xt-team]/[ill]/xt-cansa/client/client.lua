QBCore = exports['qb-core']:GetCoreObject()
local CurrentCops = 0
local AllProps = {}
local HasProp = false
local LoggedIn = false
RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)
local function RequestModelHash(Model)
    RequestModel(Model)
	while not HasModelLoaded(Model) do
	    Wait(1)
    end
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
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
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

local Config
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
  SetTimeout(650, function()
      QBCore.Functions.TriggerCallback('xt-cansa:server:GetConfig', function(config)
          Config = config
          Wait(250)
          LoggedIn = true
      end)
  end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    LoggedIn = false
end)
-- Code


CreateThread(function()
    Wait(15000)
    while true do
        Wait(4)
        if LoggedIn then
          NearWietField = false
          local ped = PlayerPedId()
          local PlayerCoords = GetEntityCoords(ped)
          local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, Config.WeedLocations.x, Config.WeedLocations.y, Config.WeedLocations.z, true)
          if Distance <= 75.0 then
              NearWietField = true
              Config.CanWiet = true
          end
          if not NearWietField then
              Wait(1500)
              Config.CanWiet = false
          end
        end
    end
end)


CreateThread(function()
    while true do
        Wait(4)
        if LoggedIn then
            local ped = PlayerPedId()
            local SpelerCoords = GetEntityCoords(ped)
            local NearAnything = false
                local danglam = false
                local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Donggoi.x, Config.Donggoi.y, Config.Donggoi.z, true)
                if PlantDistance < 2 and not danglam then
                    NearAnything = true
                        DrawText3D(Config.Donggoi.x, Config.Donggoi.y, Config.Donggoi.z, '[~g~E~s~] - Đóng gói')
                        DrawMarker(25, Config.Donggoi.x, Config.Donggoi.y, Config.Donggoi.z - 0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                        if IsControlJustPressed(0, Config.Keys['E']) and NearAnything then
                            if CurrentCops >= Config.PoliceNeeded then
                                QBCore.Functions.TriggerCallback('xt-cansa:server:has:nugget', function(HasNugget)
                                    if HasNugget then
                                        LoadDict("amb@prop_human_bum_bin@idle_a")
                                        TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0, -8.0, -1, 2, 0, false, false, false)
                                        danglam = true
                                        QBCore.Functions.Progressbar("dong-goi", "Đóng gói", math.random(8000, 12000), false, false, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableAll = true,
                                        }, {}, {}, {}, function() -- Done
                                            RemoveAnimDict("amb@prop_human_bum_bin@idle_a")
                                            ClearPedTasks(ped)
                                            TriggerServerEvent('xt-cansa:server:donggoi:reward')
                                            danglam = false
                                        end)
                                    else
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ nguyên liệu (Cần 5x Cần sấy khô và x1 Túi nhựa)", 5000, 'error')
                                    end
                                end)
                            else
                                exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ cảnh sát(cần "..Config.PoliceNeeded.." cảnh sát)", 5000, 'error')
                            end
                        end
                else
                    NearAnything = false
                end
            if not NearAnything then
                Wait(2500)
            end
        end
    end
end)
CreateThread(function()
    while true do
        Wait(4)
        if LoggedIn then
            local ped = PlayerPedId()
        local SpelerCoords = GetEntityCoords(ped)
        local NearAnything = false

                local PlantDistance = GetDistanceBetweenCoords(SpelerCoords.x, SpelerCoords.y, SpelerCoords.z, Config.Say.x, Config.Say.y, Config.Say.z, true)
                local danglam = false
                if PlantDistance < 2 and not danglam then
                    NearAnything = true
                    DrawText3D(Config.Say.x, Config.Say.y, Config.Say.z, '[~g~E~s~] - Chế biến')
                    DrawMarker(25, Config.Say.x, Config.Say.y, Config.Say.z - 0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                        if IsControlJustPressed(0, Config.Keys['E']) and NearAnything then
                            if CurrentCops >= Config.PoliceNeeded then
                                local docan = 'wood'
                                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                    if result then
                                        LoadDict("amb@prop_human_bum_bin@idle_a")
                                        TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0, -8.0, -1, 2, 0, false, false, false)
                                        danglam = true
                                        QBCore.Functions.Progressbar("che-bien", "Chế biến", 15000, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableAll = true,
                                        }, {}, {}, {}, function() -- Done
                                            RemoveAnimDict("amb@prop_human_bum_bin@idle_a")
                                            ClearPedTasks(ped)
                                            TriggerServerEvent('xt-cansa:server:chebien:reward')
                                            danglam = false
                                        end)
                                    else
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ Cây cần sa (Cần x1 Cây cần sa)", 5000, 'error')
                                    end
                                end, docan)
                            else
                                exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ cảnh sát(cần "..Config.PoliceNeeded.." cảnh sát)", 5000, 'error')
                            end
                        end
                else
                    NearAnything = false
                end

            if not NearAnything then
                Wait(2500)
            end
        end
    end
end)
RegisterNetEvent('xt-cansa:client:rod:anim', function()
    local ped = PlayerPedId()
    AddProp('Schaar')
    LoadDict('amb@world_human_gardener_plant@male@idle_a')
    TaskPlayAnim(ped, "amb@world_human_gardener_plant@male@idle_a", "idle_a", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
end)

RegisterNetEvent('xt-cansa:client:use:scissor', function()
    SetTimeout(1000, function()
        local ped = PlayerPedId()
    if Config.CanWiet then
        if CurrentCops >= Config.PoliceNeeded then
            if not IsPedInAnyVehicle(ped) then
                    Config.UsingRod = true
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    local lan = math.random(3, 5)
                    TriggerEvent('xt-cansa:client:rod:anim')
                    local time = math.random(7,12) -- Time on how fast the circle goes around. The lower the value = faster it is!
                    local success = exports['qb-lock']:StartLockPickCircle(lan, time, success)
                    if success then
                        TriggerEvent('inventory:client:set:busy', true)
                        QBCore.Functions.Progressbar("thu-hoach", "Thu hoạch", 5000, false, false, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                            disableAll = true,
                        }, {}, {}, {}, function() -- Done
                            FreezeEntityPosition(ped, false)
                            RemoveProp()
                            Config.UsingRod = false
                            TriggerServerEvent('xt-cansa:server:weed:reward')
                            exports['xt-doben']:UpdateToolQuality(1)
                            StopAnimTask(ped, "amb@world_human_gardener_plant@male@idle_a", "idle_a", 1.0)
                            TriggerEvent('inventory:client:set:busy', false)
                        end)
                    else
                        FreezeEntityPosition(ped, false)
                        RemoveProp()
                        Config.UsingRod = false
                        exports['xt-notify']:Alert("THÔNG BÁO", "Thất bại", 5000, 'error')
                        TriggerEvent('inventory:client:set:busy', false)
                        StopAnimTask(ped, "amb@world_human_gardener_plant@male@idle_a", "idle_a", 1.0)
                    end
            else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang ngồi trong phương tiện.", 5000, 'error')
            end
        else
        exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ cảnh sát (cần "..Config.PoliceNeeded.." cảnh sát)", 5000, 'error')
        end
    else
    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không ở trong khu vực cây trồng", 5000, 'error')
    end
  end)
end)



