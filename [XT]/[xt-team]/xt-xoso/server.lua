ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('raspa', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("raspa", 1)
	TriggerClientEvent('raspa:usar', source)
end)

RegisterCommand("raspa", function(source)
  TriggerClientEvent('raspa:usar', source)
end)

RegisterServerEvent('raspa:win')
AddEventHandler('raspa:win', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local array = {750, 640, 510, 0, 50, 300, 600, 1, 2, 10, 25, 90, 60, 65, 3, 290, 345, 691, 81, 329, 70, 20, 4, 5, 465, 470}
	local money = array[math.random(26)]
	xPlayer.addAccountMoney("bank", money)
end)

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'raspa' then
		TriggerClientEvent('raspa:addcalc', source)
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'raspa' and item.count < 1 then
		TriggerClientEvent('raspa:removecalc', source)
	end
end)