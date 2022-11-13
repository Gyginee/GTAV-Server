local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('xt-cuopnha:server:get:config', function(source, cb)
  cb(Config)
end)

-- Code

RegisterServerEvent('xt-cuopnha:server:set:door:status', function(RobHouseId, bool)
 Config.HouseLocations[RobHouseId]['Opened'] = bool
 TriggerClientEvent('xt-cuopnha:client:set:door:status', -1, RobHouseId, bool)
 ResetHouse(RobHouseId)
end)

RegisterServerEvent('xt-cuopnha:server:set:locker:state', function(RobHouseId, LockerId, Type, bool)
 Config.HouseLocations[RobHouseId]['Lockers'][LockerId][Type] = bool
 TriggerClientEvent('xt-cuopnha:client:set:locker:state', -1, RobHouseId, LockerId, Type, bool)
end)

RegisterServerEvent('xt-cuopnha:server:locker:reward', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local RandomValue = math.random(1, 100)
  if RandomValue <= 50 then
    local sl = math.random(70, 90)
    Player.Functions.AddItem('tienban', sl)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "add", sl)
  elseif RandomValue >= 45 and RandomValue <= 80 then
    Player.Functions.AddItem('diamond-ring', 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['diamond-ring'], "add")
  elseif RandomValue >= 50 and RandomValue <= 82 then
    Player.Functions.AddItem('gold-necklace', 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['gold-necklace'], "add")
  elseif RandomValue >= 50 and RandomValue <= 98 then
    Player.Functions.AddItem('rolex', 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['rolex'], "add")
  else
    TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Không tìm thấy gì ở đây", 5000, 'error')
  end 
end)

RegisterServerEvent('xt-cuopnha:server:recieve:extra', function(CurrentHouse, Id)
  local Player = QBCore.Functions.GetPlayer(source)
  Player.Functions.AddItem(Config.HouseLocations[CurrentHouse]['Extras'][Id]['Item'], 1)
  TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.HouseLocations[CurrentHouse]['Extras'][Id]['Item']], "add")
  Config.HouseLocations[CurrentHouse]['Extras'][Id]['Stolen'] = true
  TriggerClientEvent('xt-cuopnha:client:set:extra:state', -1, CurrentHouse, Id, true)
end)

function ResetHouse(HouseId)
  SetTimeout((1000 * 60) * 15, function()
      Config.HouseLocations[HouseId]["Opened"] = false
      for k, v in pairs(Config.HouseLocations[HouseId]["Lockers"]) do
          v["Opened"] = false
          v["Busy"] = false
      end
      if Config.HouseLocations[HouseId]["Extras"] ~= nil then
        for k, v in pairs(Config.HouseLocations[HouseId]["Extras"]) do
          v['Stolen'] = false
        end
      end
      TriggerClientEvent('xt-cuopnha:server:reset:state', -1, HouseId)
  end)
end

QBCore.Functions.CreateCallback('xt-cuopnha:server:robbery:item', function(source, cb)
  local Player = QBCore.Functions.GetPlayer(source)
  if Player ~= nil then
    local StolenTv = Player.Functions.GetItemByName('stolen-tv')
    local StolenMicro = Player.Functions.GetItemByName('stolen-micro')
    local StolenPc = Player.Functions.GetItemByName('stolen-pc')
    local DuffleBag = Player.Functions.GetItemByName('duffel-bag')
    if StolenTv ~= nil then
        cb('StolenTv')
    elseif StolenMicro ~= nil then
        cb('StolenMicro')
    elseif StolenPc ~= nil then
        cb('StolenPc')
    elseif DuffleBag ~= nil then
        cb('Duffel')
    else
        cb(false)
    end
  end
end)
