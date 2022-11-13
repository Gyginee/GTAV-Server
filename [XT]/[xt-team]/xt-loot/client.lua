local script_active = true
QBCore = exports['qb-core']:GetCoreObject()
local labels = {}
RegisterNUICallback('xt-vongquay:NUIoff', function(data, cb)
	SetNuiFocus(false,false)
    SendNUIMessage({
        type = "off"
    })
end)
CreateThread(function()
    for k, v in pairs(QBCore.Shared.Items) do
        labels[k] = v.label
    end
end)
RegisterNetEvent("xt-vongquay:client:dunghom", function(itemName)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
    TriggerEvent("xt-vongquay:client:quay", itemName)
    TriggerEvent("inventory:client:dong")
end)

RegisterNetEvent("xt-vongquay:client:quay", function(data)
	local sum = 0
	draw = {}
	for k, v in pairs(Config["hom"][data].list) do
		local rate = Config["chance"][v.tier].rate * 100
		for i=1,rate do
			if v.item then
				if v.amount then
					table.insert(draw, {item = v.item ,amount = v.amount, tier = v.tier})
				else
					table.insert(draw, {item = v.item ,amount = 1, tier = v.tier})
				end
			elseif v.weapon then
				table.insert(draw, {weapon = v.weapon , tier = v.tier})
			elseif v.money then
				table.insert(draw, {money = v.money, tier = v.tier})
			end
			i = i + 1
		end
		sum = sum + rate
	end
	local random = math.random(1,sum)
	SetNuiFocus(true,true)
	SendNUIMessage({
        type = "ui",
		data = Config["hom"][data].list,
		img = "/../../[qb]/lj-inventory/html/images",
		win = draw[random]
    })
	Wait(9000)
	if draw[random].item then
        TriggerServerEvent('xt-vongquay:server:nhando', draw[random].item, draw[random].amount)
	elseif draw[random].money then
		TriggerServerEvent('xt-vongquay:server:nhantien', draw[random].money)
	end
    --[[ if Config["broadcast"] then
        TriggerServerEvent("mkbuss:boradcast", draw[random].tier)
    end ]]
end)
