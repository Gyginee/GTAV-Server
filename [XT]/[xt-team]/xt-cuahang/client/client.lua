local NearShop = false
local isLoggedIn = true
local CurrentShop = nil

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
 SetTimeout(1250, function()
   TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
    Wait(250)
    QBCore.Functions.TriggerCallback("xt-cuahang:server:GetConfig", function(config)
      Config = config
    end)
   isLoggedIn = true
 end)
end)

-- Code
Citizen.CreateThread(function()
--[[ 	for k, v in pairs(Config.Shops) do
		local blip = AddBlipForCoord(v['Coords']['X'],v['Coords']['Y'],v['Coords']['Z'])
		SetBlipAsShortRange(blip, true)
		SetBlipSprite(blip, 59)
		SetBlipColour(blip, 8)
		SetBlipScale(blip, 0.7)
		SetBlipDisplay(blip, 6)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v['Name'])
		EndTextCommandSetBlipName(blip)
	end ]]
end)

CreateThread(function()
    while true do
        Wait(3)
        if isLoggedIn then
            NearShop = false
            for k, v in pairs(Config.Shops) do
                local PlayerCoords = GetEntityCoords(PlayerPedId())
                local Distance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], true)
                if Distance < 2.5 then
                    NearShop = true
                    CurrentShop = k
                end
            end
            if not NearShop then
                Wait(1000)
                CurrentShop = nil
            end
        end
    end
end)

RegisterNetEvent('xt-cuahang:server:open:shop', function()
  SetTimeout(350, function()
      if CurrentShop ~= nil then 
        local Shop = {label = Config.Shops[CurrentShop]['Name'], items = Config.Shops[CurrentShop]['Product'], slots = 30}
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..CurrentShop, Shop)
      end
  end)
end)

RegisterNetEvent('xt-cuahang:client:update:store', function(ItemData, Amount)
    TriggerServerEvent('xt-cuahang:server:update:store:items', CurrentShop, ItemData, Amount)
end)

RegisterNetEvent('xt-cuahang:client:set:store:items', function(ItemData, Amount, ShopId)
    Config.Shops[ShopId]["Product"][ItemData.slot].amount = Config.Shops[ShopId]["Product"][ItemData.slot].amount - Amount
end)

-- // Function \\ --