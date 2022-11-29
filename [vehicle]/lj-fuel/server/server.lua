-- Variables

local QBCore = exports['qb-core']:GetCoreObject()

-- Functions

local function GlobalTax(value)
	local tax = (value / 100 * Config.GlobalTax)
	return tax
end

-- Server Events

RegisterNetEvent("ps-fuel:server:OpenMenu", function (amount, inGasStation)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	local tax = GlobalTax(amount)
	local total = math.ceil(amount + tax)
	if inGasStation == true then
		TriggerClientEvent('qb-menu:client:openMenu', src, {
			{
				header = 'Pê trô li mít tựt',
				txt = 'Tổng tiền : $'..total..' cả thuế.' ,
				params = {
					event = "ps-fuel:client:RefuelVehicle",
					args = total,
				}
			},
		})
	end
		if inGasStation == false then
			TriggerClientEvent('qb-menu:client:openMenu', src, {
				{
					header = 'Pê trô li mít tựt',
					txt = 'Tổng tiền : $'..total..' cả thuế.' ,
					params = {
					event = "ps-fuel:client:RefuelVehicle",
					args = total,
				}
			},
		})
	end
end)

RegisterNetEvent("ps-fuel:server:PayForFuel", function (amount)
	local src = source
	if not src then return end
	local player = QBCore.Functions.GetPlayer(src)
	if not player then return end
	player.Functions.RemoveMoney('cash', amount)
end)
