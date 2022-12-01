local VehicleNitrous = {}

--[[ RegisterNetEvent('tackle:server:TacklePlayer', function(playerId)
    TriggerClientEvent("tackle:client:GetTackled", playerId)
    print("Ng chơi: "..source.." đã ngáng chân:"..playerId)
end) ]]

QBCore.Functions.CreateCallback('nos:GetNosLoadedVehs', function(source, cb)
    cb(VehicleNitrous)
end)

QBCore.Commands.Add("id", "Kiểm tra ID của bạn", {}, false, function(source, args)
    local src = source
    TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "ID của bạn là :"..src, 5000, 'info')
    TriggerClientEvent('chat:addMessage', src, {
        color = {0, 0, 255},
        multiline = true,
        args = {'ID : '..src}
    })
end)

QBCore.Functions.CreateUseableItem("harness", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('seatbelt:client:UseHarness', src, item)
end)

RegisterNetEvent('equip:harness', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items[item.slot].info.uses == 1 then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('qb-carwash:server:washCar', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    elseif Player.Functions.RemoveMoney('bank', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn không đủ tiền", 5000, 'erros')
    end
end)

QBCore.Functions.CreateCallback('smallresources:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)
QBCore.Commands.Add('cinematic', 'Add cinematic bar', { { name = 'grandezza', help = 'Bar size(0 to 10)' }, }, true, function(source, args)
    local size=tonumber(args[1])
    if size and size >= 0 and size<=10 then
        local src = source
        TriggerClientEvent('xt-base:client:cinematic', src, size)
    end
end, 'user')

QBCore.Commands.Add("duatien", "Đưa tiền cho một công dân khác", {}, false, function(source, args)
	TriggerClientEvent('xt-base:client:duatien', source)
end)

RegisterNetEvent('xt-base:server:duatien', function(id, Amount)
    local SelfPlayer = QBCore.Functions.GetPlayer(source)
    local TargetPlayer = QBCore.Functions.GetPlayer(id)
    if TargetPlayer ~= nil then
        if TargetPlayer.PlayerData.source ~= SelfPlayer.PlayerData.source then
            if Amount ~= nil and Amount > 0 then
                if SelfPlayer.PlayerData.money['cash'] >= Amount then
                    TriggerClientEvent('xt-base:client:check:players:near', SelfPlayer.PlayerData.source, TargetPlayer.PlayerData.source, Amount)
                else
                    TriggerClientEvent('xt-notify:client:Alert', source, "HỆ THỐNG", "Bạn không có đủ tiền mặt", 5000, 'error')
                end
            end
        else
            TriggerClientEvent('xt-notify:client:Alert', source, "HỆ THỐNG", "Gì cơ?", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', source, "HỆ THỐNG", "Không tìm thấy công dân", 5000, 'error')
    end
end)

RegisterNetEvent('xt-base:server:give:cash', function(TargetPlayer, Amount)
    local SelfPlayer = QBCore.Functions.GetPlayer(source)
    local TargetPlayer = QBCore.Functions.GetPlayer(TargetPlayer)
    SelfPlayer.Functions.RemoveMoney('cash', Amount, 'Given cash')
    TargetPlayer.Functions.AddMoney('cash', Amount, 'Given cash')
    TriggerClientEvent('xt-notify:Alert', SelfPlayer.PlayerData.source, "Hệ thống", "Bạn đã gửi $"..Amount.. " cho " ..TargetPlayer.PlayerData.charinfo.firstname.." " ..TargetPlayer.PlayerData.charinfo.lastname, 5000, 'success')
    TriggerClientEvent('xt-notify:Alert', TargetPlayer.PlayerData.source, "Hệ thống", "Bạn đã nhận $"..Amount.. " từ "..SelfPlayer.PlayerData.charinfo.firstname.." " ..SelfPlayer.PlayerData.charinfo.lastname, 5000, 'success')
end)