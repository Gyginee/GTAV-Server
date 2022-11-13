ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('raspa:usar')
AddEventHandler('raspa:usar', function()
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = true
	})
end)

RegisterNetEvent('raspa:showprice')
AddEventHandler('raspa:showprice', function(money)
	SetNuiFocus( true, true )
	SendNUIMessage({
		showPlayerMenu = nil,
		prize = money
	})
end)

RegisterCommand("helpnui", function(source, args, rawCommand)
	SetNuiFocus( false, false )
	SendNUIMessage({
		showPlayerMenu = false
	})

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	item = false

	for i=1, #PlayerData.inventory, 1 do
		if PlayerData.inventory[i].name == 'raspa' then
			if PlayerData.inventory[i].count > 0 then
				item = true
			end
		end
	end

end)

RegisterNetEvent('raspa:addcalc')
AddEventHandler('raspa:addcalc', function()
	item = true
end)

RegisterNetEvent('raspa:removecalc')
AddEventHandler('raspa:removecalc', function()
	item = false
end)
