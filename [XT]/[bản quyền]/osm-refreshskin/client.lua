QBCore = exports['qb-core']:GetCoreObject()

----------------------------------------------------------------------------------------------------

RegisterCommand("rf", function(source, args, rawCommand)
  local playerPed = PlayerPedId()
  local maxhealth = GetEntityMaxHealth(playerPed)
  local health = GetEntityHealth(playerPed)
  reloadSkin(health)
end)

function reloadSkin(health)
  local model = nil
  local gender = QBCore.Functions.GetPlayerData().charinfo.gender
  if gender == 1 then -- Gender is ONE for FEMALE
    model = GetHashKey("mp_f_freemode_01") -- Female Model
  else
    model = GetHashKey("mp_m_freemode_01") -- Male Model
  end
  RequestModel(model)
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
    Wait(1000) -- Safety Delay
  TriggerServerEvent("qb-clothes:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
  TriggerServerEvent("qb-clothing:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES - Event 2
  SetPedMaxHealth(PlayerId(), maxhealth)
  SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
  SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
    Wait(1000) -- Safety Delay
  SetEntityHealth(PlayerPedId(), health)
end

CreateThread(function()
  while true do
      Wait(1)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
  end
end)
