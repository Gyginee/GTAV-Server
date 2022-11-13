QBCore = exports['qb-core']:GetCoreObject()
LoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  SetTimeout(1250, function()
    LoggedIn = true
    exports['qb-target']:AddTargetModel(Config.Dongho,  {
          options = {
              {
                  event = "xt-dongho:client:open",
                  icon = "fa-solid fa-coin",
                  label = "Cạy đồng hồ",
              },
              },
          distance = 1.0
      })
  end)
end)
-- Code
local timer = 0
local canRob = true
MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true,
}

FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
}

RegisterNetEvent('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

local function IsInVehicle()
  local ped = PlayerPedId()
  if IsPedSittingInAnyVehicle(ped) then
    return true
  else
    return false
  end
end

local function IsWearingHandshoes()
  local ped = PlayerPedId()
  local armIndex = GetPedDrawableVariation(ped, 3)
  local model = GetEntityModel(ped)
  local retval = true
  if model == GetHashKey("mp_m_freemode_01") then
      if MaleNoHandshoes[armIndex] ~= nil and MaleNoHandshoes[armIndex] then
          retval = false
      end
  else
      if FemaleNoHandshoes[armIndex] ~= nil and FemaleNoHandshoes[armIndex] then
          retval = false
      end
  end
  return retval
end
local function GetNearbyPed()
	local retval = nil
	local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
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
          local msg = "Có một " .. gender .." đang cố gắng cạy đồng hồ tại " .. StreetLabel
          TriggerServerEvent("police:server:DonghoRobberyCall", pos, msg, StreetLabel)
      end
  end
end
local function RequestAnimationDict(AnimDict)
  RequestAnimDict(AnimDict)
  while not HasAnimDictLoaded(AnimDict) do
      Wait(1)
  end
end

local function lockpickFinish(success)
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  if success then
    QBCore.Functions.Progressbar("search_parkmeter", "Cạy", 20000, false, false, {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
    }, {}, {}, {}, function() -- Done
      TriggerServerEvent('xt-dongho:server:phanthuong')
      StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
      canRob = false
      timer = 60
      end)
  else
    StopAnimTask(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
    if math.random(0,1) == 0 then
      TriggerServerEvent("QBCore:Server:RemoveItem", 'lockpick', 1)
      TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['lockpick'], "remove")
      if not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
      elseif math.random(0, 30) <= 15 and IsWearingHandshoes() then
        exports['okokNotify']:Alert("HỆ THỐNG", "Bạn đã bị rách găng tay", 5000, 'error')
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
      end
    end
  end
end

RegisterNetEvent('xt-dongho:client:open', function()
  if CurrentCops >= Config.PoliceNeeded then
    if not IsInVehicle() then
      QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result == true then
          if canRob == true then
            local ped = PlayerPedId()
            RequestAnimationDict("veh@break_in@0h@p_m_one@")
            TaskPlayAnim(ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            PoliceCall()
            TriggerEvent('qb-lockpick:client:openLockpick', lockpickFinish)
            else
              exports['xt-notify']:Alert("HỆ THỐNG", "Đang khôi phục, tầm "..timer.." giây nữa bạn có thể thử lại", 5000, 'error')
            end
          else
            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn cần có "..QBCore.Shared.Items['lockpick'].label, 5000, 'error')
          end
        end, "lockpick")
      else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn không thể phá khoá khi đang ở trên phương tiện", 5000, 'error')
      end
  else
    exports['xt-notify']:Alert("HỆ THỐNG", "Không đủ cảnh sát (Cần x"..Config.PoliceNeeded.." Cảnh sát)", 5000, 'error')
  end
end)

CreateThread(function()
  while true do
      if canRob == false then
          if timer < 0 then
              timer = 0
              canRob = true
          else
              if timer == 0 then
                  canRob = true
              else
                  timer = timer - 60
              end
          end
      end
      Wait(60000)
  end
end)

