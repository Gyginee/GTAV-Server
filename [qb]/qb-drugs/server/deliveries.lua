local QBCore = exports['qb-core']:GetCoreObject()

local function GetDealers()
    return Config.Dealers
end

exports("GetDealers", GetDealers)

RegisterNetEvent('qb-drugs:server:updateDealerItems', function(itemData, amount, dealer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.Dealers[dealer]["products"][itemData.slot].amount - 1 >= 0 then
        Config.Dealers[dealer]["products"][itemData.slot].amount =
            Config.Dealers[dealer]["products"][itemData.slot].amount - amount
        TriggerClientEvent('qb-drugs:client:setDealerItems', -1, itemData, amount, dealer)
    else
        Player.Functions.RemoveItem(itemData.name, amount)
        Player.Functions.AddMoney('cash', amount * Config.Dealers[dealer]["products"][itemData.slot].price)
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Mặt hàng này không có sẵn, bạn đã được hoàn lại tiền", 5000, 'error')
    end
end)

RegisterNetEvent('qb-drugs:server:giveDeliveryItems', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem('weed_brick', amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "add")
end)

QBCore.Functions.CreateCallback('qb-drugs:server:RequestConfig', function(source, cb)
    cb(Config.Dealers)
end)

RegisterNetEvent('qb-drugs:server:succesDelivery', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local curRep = Player.PlayerData.metadata["dealerrep"]
    if inTime then
        if Player.Functions.GetItemByName('weed_brick') ~= nil and Player.Functions.GetItemByName('weed_brick').amount >=
            deliveryData["amount"] then
            Player.Functions.RemoveItem('weed_brick', deliveryData["amount"])
            local price = 3000
            if CurrentCops == 1 then
                price = 4000
            elseif CurrentCops == 2 then
                price = 5000
            elseif CurrentCops == 3 then
                price = 6000
            end
            if curRep < 10 then
                Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 8), "dilvery-drugs")
            elseif curRep >= 10 then
                Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 10), "dilvery-drugs")
            elseif curRep >= 20 then
                Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 12), "dilvery-drugs")
            elseif curRep >= 30 then
                Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 15), "dilvery-drugs")
            elseif curRep >= 40 then
                Player.Functions.AddMoney('cash', (deliveryData["amount"] * price / 100 * 18), "dilvery-drugs")
            end
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "remove")
            TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Đơn hàng đang được vận chuyển", 5000, 'success')
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'perfect', deliveryData)

                Player.Functions.SetMetaData('dealerrep', (curRep + 1))
            end)
        else
            TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Điều này không đáp ứng yêu cầu", 5000, 'error')
            if Player.Functions.GetItemByName('weed_brick').amount ~= nil then
                Player.Functions.RemoveItem('weed_brick', Player.Functions.GetItemByName('weed_brick').amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "remove")
                Player.Functions.AddMoney('cash', (Player.Functions.GetItemByName('weed_brick').amount * 6000 / 100 * 5))
            end
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'bad', deliveryData)
                if curRep - 1 > 0 then
                    Player.Functions.SetMetaData('dealerrep', (curRep - 1))
                else
                    Player.Functions.SetMetaData('dealerrep', 0)
                end
            end)
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã quá chậm", 5000, 'error')
        Player.Functions.RemoveItem('weed_brick', deliveryData["amount"])
        Player.Functions.AddMoney('cash', (deliveryData["amount"] * 6000 / 100 * 4), "delivery-drugs-too-late")

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_brick"], "remove")

        SetTimeout(math.random(5000, 10000), function()
            TriggerClientEvent('qb-drugs:client:sendDeliveryMail', src, 'late', deliveryData)

            if curRep - 1 > 0 then
                Player.Functions.SetMetaData('dealerrep', (curRep - 1))
            else
                Player.Functions.SetMetaData('dealerrep', 0)
            end
        end)
    end
end)

RegisterNetEvent('qb-drugs:server:callCops', function(streetLabel, coords)
    local msg = "Một tình huống đáng ngờ đã được xác định tại "..streetLabel..", có thể có giao dịch ma túy"
    local alertData = {
        title = "Giao dịch ma tuý",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = msg
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("qb-drugs:client:robberyCall", Player.PlayerData.source, msg, streetLabel, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
    end
end)

QBCore.Commands.Add("newdealer", "Đặt một tay buôn hàng (Chỉ Admin", {{
    name = "name",
    help = "Tên tay buôn"
}, {
    name = "min",
    help = "Thời gian ít nhất"
}, {
    name = "max",
    help = "Thời gian dài nhất"
}}, true, function(source, args)
    local dealerName = args[1]
    local mintime = tonumber(args[2])
    local maxtime = tonumber(args[3])
    TriggerClientEvent('qb-drugs:client:CreateDealer', source, dealerName, mintime, maxtime)
end, "admin")

QBCore.Commands.Add("deletedealer", "Xoá tay buôn ma tuý (Chỉ Admin)", {{
    name = "name",
    help = "Tên tay buôn"
}}, true, function(source, args)
    local dealerName = args[1]
    local src = source
    local result = MySQL.Sync.fetchScalar('SELECT * FROM dealers WHERE name = ?', {dealerName})
    if result then
        MySQL.Async.execute('DELETE FROM dealers WHERE name = ?', {dealerName})
        Config.Dealers[dealerName] = nil
        TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Đã xoá xổ thành công "..dealerName, 5000, 'success')
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Không tồn tại "..dealerName, 5000, 'error')
    end
end, "admin")

QBCore.Commands.Add("dealers", "Xem tất các các tây buôn (Chỉ Admin)", {}, false, function(source, args)
    local DealersText = ""
    local src = source
    if Config.Dealers ~= nil and next(Config.Dealers) ~= nil then
        for k, v in pairs(Config.Dealers) do
            DealersText = DealersText .. "Tên" .. v["name"] .. "<br>"
        end
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>'.."Danh sách"..'</strong><br><br> ' .. DealersText .. '</div></div>',
            args = {}
        })
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Không có tay buôn nào cả ", 5000, 'error')
    end
end, "admin")

QBCore.Commands.Add("dealergoto", "Dịch chuyển đến vị trí tay buôn", {{
    name = "name",
    help = "Tên tay buôn"
}}, true, function(source, args)
    local DealerName = tostring(args[1])
    local src = source
    if Config.Dealers[DealerName] ~= nil then
        TriggerClientEvent('qb-drugs:client:GotoDealer', source, Config.Dealers[DealerName])
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Không có tay buôn này", 5000, 'error')
    end
end, "admin")

CreateThread(function()
    Wait(500)
    local dealers = MySQL.Sync.fetchAll('SELECT * FROM dealers', {})
    if dealers[1] ~= nil then
        for k, v in pairs(dealers) do
            local coords = json.decode(v.coords)
            local time = json.decode(v.time)

            Config.Dealers[v.name] = {
                ["name"] = v.name,
                ["coords"] = {
                    ["x"] = coords.x,
                    ["y"] = coords.y,
                    ["z"] = coords.z
                },
                ["time"] = {
                    ["min"] = time.min,
                    ["max"] = time.max
                },
                ["products"] = Config.Products
            }
        end
    end
    TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
end)

RegisterNetEvent('qb-drugs:server:CreateDealer', function(DealerData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.Sync.fetchAll('SELECT * FROM dealers WHERE name = ?', {DealerData.name})
    if result[1] ~= nil then
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Đã có tay buôn này", 5000, 'error')
    else
        MySQL.Async.insert('INSERT INTO dealers (name, coords, time, createdby) VALUES (?, ?, ?, ?)', {DealerData.name, json.encode(DealerData.pos), json.encode(DealerData.time), Player.PlayerData.citizenid}, function()
            Config.Dealers[DealerData.name] = {
                ["name"] = DealerData.name,
                ["coords"] = {
                    ["x"] = DealerData.pos.x,
                    ["y"] = DealerData.pos.y,
                    ["z"] = DealerData.pos.z
                },
                ["time"] = {
                    ["min"] = DealerData.time.min,
                    ["max"] = DealerData.time.max
                },
                ["products"] = Config.Products
            }

            TriggerClientEvent('qb-drugs:client:RefreshDealers', -1, Config.Dealers)
        end)
    end
end)
