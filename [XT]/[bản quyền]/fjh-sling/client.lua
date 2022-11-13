local QBCore = exports['qb-core']:GetCoreObject()
local attached_weapons = {}
local hotbar = {}
local playerLoaded = false

CreateThread(function()
  while true do
    if playerLoaded then
        local me = PlayerPedId()
        local items = QBCore.Functions.GetPlayerData().items
        if items ~= nil then 
          hotbar = { items[1], items[2], items[3], items[4], items[5], items[41] }
          for slot, item in pairs(hotbar) do
            if item ~= nil and item.type == "weapon" and Config.compatable_weapon_hashes[item.name] ~= nil then
              local wep_model = Config.compatable_weapon_hashes[item.name].model
              local wep_hash = Config.compatable_weapon_hashes[item.name].hash
              if not attached_weapons[wep_model] and GetSelectedPedWeapon(me) ~= wep_hash then
                  AttachWeapon(wep_model, wep_hash, Config.compatable_weapon_hashes[item.name].pos.bone, Config.compatable_weapon_hashes[item.name].pos.x, Config.compatable_weapon_hashes[item.name].pos.y, Config.compatable_weapon_hashes[item.name].pos.z, Config.compatable_weapon_hashes[item.name].pos.x_rotation, Config.compatable_weapon_hashes[item.name].pos.y_rotation, Config.compatable_weapon_hashes[item.name].pos.z_rotation)
              end
            end
          end
          for key, attached_object in pairs(attached_weapons) do
              if GetSelectedPedWeapon(me) == attached_object.hash or not inHotbar(attached_object.hash) then -- equipped or not in weapon wheel
                DeleteObject(attached_object.handle)
                attached_weapons[key] = nil
              end
          end
        end
      end
    Wait(500)
  end
end)

function inHotbar(hash)
  for slot, item in pairs(hotbar) do
    if item ~= nil and item.type == "weapon" and Config.compatable_weapon_hashes[item.name] ~= nil then
      if hash == GetHashKey(item.name) then
        return true
      end
    end
  end
  return false
end

function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR)
  local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
    RequestModel(GetHashKey(attachModel))
  while not HasModelLoaded(GetHashKey(attachModel)) do
      Wait(100)
  end
attached_weapons[attachModel] = {
  hash = modelHash,
  handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
}
  AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end



RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  playerLoaded = true;
end)