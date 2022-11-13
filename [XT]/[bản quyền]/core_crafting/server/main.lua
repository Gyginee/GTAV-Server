

QBCore = exports['qb-core']:GetCoreObject()

-- Main Event

RegisterServerEvent("core_crafting:craft")
AddEventHandler("core_crafting:craft", function(item, retrying)
    local src = source
    craft(src, item, retrying)
end)

RegisterServerEvent("core_crafting:itemCrafted")
AddEventHandler("core_crafting:itemCrafted", function(item, count)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.Recipes[item].SuccessRate > math.random(0, Config.Recipes[item].SuccessRate) then
        if Config.Recipes[item].type == 'weapon' then
			Player.Functions.AddItem(item, count, toSlot, {serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)), ammo = 1, quality = 100.0})
		elseif Config.Recipes[item].type == 'tool' then
			Player.Functions.AddItem(item, count, toSlot, {quality = 100.0})
        else
            Player.Functions.AddItem(item, count)
            if Config.Recipes[item].Category == 'food' then
                TriggerEvent('qb-log:server:CreateLog', "restaurant", 'NẤU ĐỒ', 'lightgreen', Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. " nấu thành công x"..count.." "..QBCore.Shared.Items[item].label, false)
            elseif Config.Recipes[item].Category == 'drink' then
                TriggerEvent('qb-log:server:CreateLog', "coffee", 'PHA CHẾ', 'lightgreen', Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. " pha thành công x"..count.." "..QBCore.Shared.Items[item].label, false)
            end
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", count)
        Player.Functions.SetMetaData("craftingrep", Player.PlayerData.metadata["craftingrep"] + Config.Recipes[item].Exp)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Thất bại", 5000, 'error')
    end
end)

-- Main Function

function craft(src, item)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local cancraft = false
    local total = 0
    local count = 0
    local reward = Config.Recipes[item].count
    for k, v in pairs(Config.Recipes[item].Ingredients) do
        total = total + 1
        local mat = xPlayer.Functions.GetItemByName(k)
        if mat ~= nil and mat.amount >= v then
            count = count + 1
        end
    end
    if total == count then
        cancraft = true
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn không đủ nguyên liệu", 5000, 'error')
    end
    if cancraft then
        for k, v in pairs(Config.Recipes[item].Ingredients) do
            if not Config.PermanentItems[k] then
                xPlayer.Functions.RemoveItem(k, v)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], "remove", v)
            end
        end
        TriggerClientEvent("core_crafting:craftStart", src, item, reward)
    end
end