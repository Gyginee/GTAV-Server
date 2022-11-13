QBCore = exports['qb-core']:GetCoreObject()

--Callback de obtener las stats actuales

--Actualizar stats
RegisterServerEvent('xt-gym:checkChip', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = Player.Functions.GetItemByName('gym_membership').amount
	if quantity > 0 then
		TriggerClientEvent('xt-gym:trueMembership', src) -- true
	else
		TriggerClientEvent('xt-gym:falseMembership', src) -- false
	end
end)

RegisterServerEvent('xt-gym:buyMembership', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.money.cash >= Config.MmbershipCardPrice then
        Player.Functions.RemoveMoney('cash', Config.MmbershipCardPrice)
        Player.Functions.AddItem('gym_membership', 1)
        TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn đã trả tiền với tư cách thành viên phòng tập gym", 5000, 'success')
		TriggerClientEvent('xt-gym:trueMembership', src) -- true
	else
          TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn không có đủ tiền, bạn cần $".. Config.MmbershipCardPrice, 5000, 'error')
	end
end)