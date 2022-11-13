

RegisterServerEvent('xt-vesinh:server:vesinh', function(player, need, gender)
    local src = source
    TriggerClientEvent('xt-vesinh:client:vesinh', src, player, need, gender)
end)

--[[ RegisterServerEvent('xt-vesinh:client:muithoi')
AddEventHandler('xt-vesinh:client:muithoi', function(target)
    TriggerClientEvent('xt-vesinh:client:stress', target)
    TriggerClientEvent('okokNotify:Alert', target, "HỆ THỐNG", "Người đối diện thối quá", 5000, 'error')
end) ]]