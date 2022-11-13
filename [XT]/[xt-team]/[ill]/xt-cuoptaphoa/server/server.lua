local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('xt-cuoptaphoa:server:get:config', function(source, cb)
    cb(Config)
end)

QBCore.Commands.Add("resetsafes", "Đặt lại hòm tiền các cửa hàng", {}, false, function(source, args)
    for k, v in pairs(Config.Safes) do
        Config.Safes[k]['Busy'] = false
        TriggerClientEvent('xt-cuoptaphoa:client:safe:busy', -1, k, false)
    end
end, "admin")

QBCore.Functions.CreateCallback('xt-cuoptaphoa:server:HasItem', function(source, cb, itemName)
    local Player = QBCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName(itemName)
	if Player ~= nil then
        if Item ~= nil then
			cb(true)
        else
			cb(false)
        end
	end
end)

CreateThread(function()
    while true do
        for k, v in pairs(Config.Registers) do
            if Config.Registers[k].time > 0 and (Config.Registers[k].time - Config.Inverval) >= 0 then
                Config.Registers[k].time = Config.Registers[k].time - Config.Inverval
            else
                Config.Registers[k].time = 0
                Config.Registers[k].robbed = false
                TriggerClientEvent('xt-cuoptaphoa:client:set:register:robbed', -1, k, false)
            end
        end
        Wait(Config.Inverval)
    end
end)

RegisterServerEvent('xt-cuoptaphoa:server:set:register:robbed', function(RegisterId, bool)
    Config.Registers[RegisterId].robbed = bool
    Config.Registers[RegisterId].time = Config.ResetTime
    TriggerClientEvent('xt-cuoptaphoa:client:set:register:robbed', -1, RegisterId, bool)
end)

RegisterServerEvent('xt-cuoptaphoa:server:set:register:busy', function(RegisterId, bool)
    Config.Registers[RegisterId]['Busy'] = bool
    TriggerClientEvent('xt-cuoptaphoa:client:set:register:busy', -1, RegisterId, bool)
end)

RegisterServerEvent('xt-cuoptaphoa:server:safe:busy', function(SafeId, bool)
    Config.Safes[SafeId]['Busy'] = bool
    TriggerClientEvent('xt-cuoptaphoa:client:safe:busy', -1, SafeId, bool)
end)

RegisterServerEvent('xt-cuoptaphoa:server:safe:robbed', function(SafeId, bool)
    Config.Safes[SafeId].robbed = bool
    TriggerClientEvent('xt-cuoptaphoa:client:safe:robbed', -1, SafeId, bool)
    SetTimeout((1000 * 60) * 25, function()
        TriggerClientEvent('xt-cuoptaphoa:client:safe:robbed', -1, SafeId, false)
        Config.Safes[SafeId].robbed = false
    end)
end)

RegisterServerEvent('xt-cuoptaphoa:server:rob:register', function(RegisterId, IsDone)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        local bags = math.random(2,3)
        Player.Functions.AddItem('tienban', bags)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "add", bags)
        if IsDone then
            local bag = math.random(2,3)
            Player.Functions.AddItem('tienban', bag)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "add", bag)
        end
    end
end)

RegisterServerEvent('xt-cuoptaphoa:server:safe:reward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bags = math.random(50,60)
	Player.Functions.AddItem('tienban', bags)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['tienban'], "add", bags)
        local RandomValue = math.random(1,190)
    if RandomValue <= 100 then
        local sl = math.random(15,25)
        Player.Functions.AddItem("rolex", sl)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rolex"], "add", sl)
    elseif RandomValue >= 45 and RandomValue <= 190 then
        local sl = math.random(5,9)
        Player.Functions.AddItem("gold-bar", sl)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["gold-bar"], "add", sl)
    end
end)
