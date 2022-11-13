-- Code
QBCore = exports['qb-core']:GetCoreObject()
QBCore.Functions.CreateCallback("xt-vehiclekeys:server:get:key:config", function(source, cb)
  cb(Config)
end)

QBCore.Functions.CreateCallback("xt-vehiclekeys:server:has:keys", function(source, cb, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
      local PlayerData = Player.PlayerData
      if Config.VehicleKeys[plate] ~= nil then
          if Config.VehicleKeys[plate]['CitizenId'] == PlayerData.citizenid and Config.VehicleKeys[plate]['HasKey'] then
              HasKey = true
          else
              HasKey = false
          end
      else
          HasKey = false
      end
      cb(HasKey)
    end
end)

-- // Events \\ --

RegisterServerEvent('xt-vehiclekeys:server:set:keys', function(Plate, bool)
  local Player = QBCore.Functions.GetPlayer(source)
  Config.VehicleKeys[Plate] = {['CitizenId'] = Player.PlayerData.citizenid, ['HasKey'] = bool}
  TriggerClientEvent('xt-vehiclekeys:client:set:keys', -1, Plate, Player.PlayerData.citizenid, bool)
end)

RegisterServerEvent('xt-vehiclekeys:server:give:keys', function(Target, Plate, bool)
  local Player = QBCore.Functions.GetPlayer(Target)
  if Player ~= nil then
    TriggerClientEvent('xt-notify:client:Alert', Player.PlayerData.source, "THÔNG BÁO", "Bạn đã nhận được chìa khóa xe có biển số: <span style='color:#30ff00'><b>"..Plate.."<b></span>", 5000, 'success')
    Config.VehicleKeys[Plate] = {['CitizenId'] = Player.PlayerData.citizenid, ['HasKey'] = bool}
    TriggerClientEvent('xt-vehiclekeys:client:set:keys', -1, Plate, Player.PlayerData.citizenid, bool)
  end
end)

-- // Commands \\ -- 

QBCore.Commands.Add("dongco", "Bật / tắt động cơ xe", {}, false, function(source, args)
  TriggerClientEvent('xt-vehiclekeys:client:toggle:engine', source)
end)