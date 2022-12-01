-- Event Handler

AddEventHandler('playerDropped', function(reason)
    local src = source
    local ped = GetPlayerPed(src)
    local msg= ''
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local armor = GetPedArmour(ped)
    local health = GetEntityHealth(ped)
    if QBCore.Players[src] then
        local Player = QBCore.Players[src]
        for k,v in pairs(GetPlayerIdentifiers(src))do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamid = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
              discord = v.gsub(v,"discord:", "")
            end    
        end
        if reason == 'Exiting' or reason=='Disconnected.' then
            TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Dropped', 'red',  'Username Steam: '.. GetPlayerName(src) .. '\nSteam Id: ' .. steamid .. '\nLicense gta: '.. Player.PlayerData.license .. '\nID citizen: ' .. Player.PlayerData.citizenid .. '\nID Discord: <@' .. discord .. '>\n**Quit**'.. '\n(Reason: ' .. reason .. ')')
            msg= 'Player left \n' .. Player.PlayerData.license 
        elseif string.find(reason, "GTA5.exe") then
            TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Dropped', 'red',  'Username Steam: '.. GetPlayerName(src) .. '\nSteam Id: ' .. steamid .. '\nLicense gta: '.. Player.PlayerData.license .. '\nID citizen: ' .. Player.PlayerData.citizenid .. '\nID Discord: <@' .. discord .. '>\n**Crash**'.. '\n(Reason: ' .. reason .. ')')
            msg= 'Player Crash \n' .. Player.PlayerData.license 
        else
            TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Dropped', 'red',  'Username Steam: '.. GetPlayerName(src) .. '\nSteam Id: ' .. steamid .. '\nLicense gta: '.. Player.PlayerData.license .. '\nID citizen: ' .. Player.PlayerData.citizenid .. '\nID Discord: <@' .. discord .. '>\n**Unknown message**'.. '\n(Reason: ' .. reason .. ')')
            msg= 'Player Left/Crash \n' .. Player.PlayerData.license 
        end
        Player.Functions.SetMetaData('health', health)
        Player.Functions.SetMetaData('armor', armor)
        for k,v in pairs(QBCore.Functions.GetPlayers()) do
            local target = GetPlayerPed(v)
            local tCoords = GetEntityCoords(target)
            if #(playerCoords - tCoords) < 60 then
                TriggerClientEvent('QBCore:Client:Draw3dTextLogout', v, playerCoords, msg)
            end
        end
        Player.Functions.Save()
        _G.Player_Buckets[Player.PlayerData.license] = nil
        QBCore.Players[src] = nil
    end
end)
AddEventHandler('chatMessage', function(source, n, message)
    local src = source
    if string.sub(message, 1, 1) == '/' then
        local args = QBCore.Shared.SplitStr(message, ' ')
        local command = string.gsub(args[1]:lower(), '/', '')
        CancelEvent()
        if QBCore.Commands.List[command] then
            local Player = QBCore.Functions.GetPlayer(src)
            if Player then
                local isGod = QBCore.Functions.HasPermission(src, 'god')
                local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
                local isPrincipal = IsPlayerAceAllowed(src, 'command')
                table.remove(args, 1)
                if isGod or hasPerm or isPrincipal then
                    if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
                        TriggerClientEvent('xt-notify:Alert', src, "Thiếu giá trị", 'error')
                    else
                        QBCore.Commands.List[command].callback(src, args)
                    end
                else
                    TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không đủ <span style='color:#ff0000'>quyền hạn</span>!", 5000, 'error')
                end
            end
        end
    end
end)

-- Player Connecting

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local license
    local identifiers = GetPlayerIdentifiers(player)
    local ten = QBConfig.Server.Ten
    deferrals.defer()

    -- mandatory wait!
    Wait(0)

    deferrals.update(string.format('Xin chào %s. Chúng tôi đang kiểm tra mã Rockstar của bạn', name))

    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end

    -- mandatory wait!
    Wait(2500)

    deferrals.update(string.format('Xin chào %s. Chúng tôi đang kiểm tra xem bạn có bị ban hay không.', name))

    local isBanned, Reason = QBCore.Functions.IsPlayerBanned(player)
    local isLicenseAlreadyInUse = QBCore.Functions.IsLicenseInUse(license)

    Wait(2500)

    deferrals.update(string.format('Chào mừng %s đã đến với thàng phố %s.', name, ten))

    if not license then
        deferrals.done('Không có mã Rockstar nào được tìm thấy')
    elseif isBanned then
        deferrals.done(Reason)
    elseif isLicenseAlreadyInUse and QBCore.Config.Server.checkDuplicateLicense then
        deferrals.done('Trùng mã Rockstar(Nếu bạn mới rời khỏi thành phố thì vui lòng chờ ít phút rồi bấm kết nối lại)')
    else
        deferrals.done()
        Wait(1000)
        TriggerEvent('connectqueue:playerConnect', name, setKickReason, deferrals)
    end
    --Add any additional defferals you may need!
end

AddEventHandler('playerConnecting', OnPlayerConnecting)

-- Open & Close Server (prevents players from joining)

RegisterNetEvent('QBCore:server:CloseServer', function(reason)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god') then
        local reason = reason or 'No reason specified'
        QBCore.Config.Server.closed = true
        QBCore.Config.Server.closedReason = reason
    else
        QBCore.Functions.Kick(src, 'Bạn không có quyền này', nil, nil)
    end
end)

RegisterNetEvent('QBCore:server:OpenServer', function()
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or QBCore.Functions.HasPermission(src, 'god') then
        QBCore.Config.Server.closed = false
    else
        QBCore.Functions.Kick(src, 'Bạn không đủ quyền hạn', nil, nil)
    end
end)

-- Callbacks

RegisterNetEvent('QBCore:Server:TriggerCallback', function(name, ...)
    local src = source
    QBCore.Functions.TriggerCallback(name, src, function(...)
        TriggerClientEvent('QBCore:Client:TriggerCallback', src, name, ...)
    end, ...)
end)

-- Player

RegisterNetEvent('QBCore:UpdatePlayer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local newHunger = Player.PlayerData.metadata['hunger'] - QBCore.Config.Player.HungerRate
        local newThirst = Player.PlayerData.metadata['thirst'] - QBCore.Config.Player.ThirstRate
        local newPee = Player.PlayerData.metadata['pee'] + QBCore.Config.Player.PeeRate
        local newPoo = Player.PlayerData.metadata['poo'] + QBCore.Config.Player.PooRate
        if newHunger <= 0 then
            newHunger = 0
        end
        if newThirst <= 0 then
            newThirst = 0
        end
        if newPee <= 0 then
            newPee = 0
        elseif newPee >=100 then
            newPee = 100
        end
        if newPoo <= 0 then
            newPoo = 0
        elseif newPoo >=100 then
            newPoo = 100
        end
        Player.Functions.SetMetaData('thirst', newThirst)
        Player.Functions.SetMetaData('pee', newPee)
        Player.Functions.SetMetaData('poo', newPoo)
        Player.Functions.SetMetaData('hunger', newHunger)
        TriggerClientEvent('hud:client:UpdateNeeds', src, newHunger, newThirst, newPee, newPoo)
        Player.Functions.Save()
    end
end)

RegisterNetEvent('QBCore:Server:SetMetaData', function(meta, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if meta == 'hunger' or meta == 'thirst' or meta == 'pee' or meta == 'poo' then
        if data > 100 then
            data = 100
        end
    end
    if Player then
        Player.Functions.SetMetaData(meta, data)
    end
    TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata['hunger'], Player.PlayerData.metadata['thirst'], Player.PlayerData.metadata['pee'], Player.PlayerData.metadata['poo'])
end)

RegisterNetEvent('QBCore:ToggleDuty', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.onduty then
        Player.Functions.SetJobDuty(false)
        TriggerClientEvent('xt-notify:Alert', src, "Bạn đã <span style='color:#ff0000'>kết thúc</span> ca làm", 'error')
    else
        Player.Functions.SetJobDuty(true)
        TriggerClientEvent('xt-notify:Alert', src, "Bạn đã <span style='color:#30ff00'>bắt đầu</span> ca làm", 'success')
    end
    TriggerClientEvent('QBCore:Client:SetDuty', src, Player.PlayerData.job.onduty)
end)

-- Items

RegisterNetEvent('QBCore:Server:UseItem', function(item)
    local src = source
    if item and item.amount > 0 then
        if QBCore.Functions.CanUseItem(item.name) then
            QBCore.Functions.UseItem(src, item)
        end
    end
end)

RegisterNetEvent('QBCore:Server:RemoveItem', function(itemName, amount, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(itemName, amount, slot)
end)

RegisterNetEvent('QBCore:Server:AddItem', function(itemName, amount, slot, info)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(itemName, amount, slot, info)
end)

-- Non-Chat Command Calling (ex: qb-adminmenu)

RegisterNetEvent('QBCore:CallCommand', function(command, args)
    local src = source
    if QBCore.Commands.List[command] then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            local isGod = QBCore.Functions.HasPermission(src, 'god')
            local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
            local isPrincipal = IsPlayerAceAllowed(src, 'command')
            if (QBCore.Commands.List[command].permission == Player.PlayerData.job.name) or isGod or hasPerm or isPrincipal then
                if (QBCore.Commands.List[command].argsrequired and #QBCore.Commands.List[command].arguments ~= 0 and args[#QBCore.Commands.List[command].arguments] == nil) then
                    TriggerClientEvent('xt-notify:Alert', src, "Thiếu giá trị", 'error')
                else
                    QBCore.Commands.List[command].callback(src, args)
                end
            else
                TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không đủ <span style='color:#ff0000'>quyền hạn</span>!", 5000, 'error')
            end
        end
    end
end)

-- Has Item Callback (can also use client function - QBCore.Functions.HasItem(item))

QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, items, amount)
    local src = source
    local retval = false
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if type(items) == 'table' then
            local count = 0
            local finalcount = 0
            for k, v in pairs(items) do
                if type(k) == 'string' then
                    finalcount = 0
                    for i, _ in pairs(items) do
                        if i then
                            finalcount = finalcount + 1
                        end
                    end
                    local item = Player.Functions.GetItemByName(k)
                    if item then
                        if item.amount >= v then
                            count = count + 1
                            if count == finalcount then
                                retval = true
                            end
                        end
                    end
                else
                    finalcount = #items
                    local item = Player.Functions.GetItemByName(v)
                    if item then
                        if amount then
                            if item.amount >= amount then
                                count = count + 1
                                if count == finalcount then
                                    retval = true
                                end
                            end
                        else
                            count = count + 1
                            if count == finalcount then
                                retval = true
                            end
                        end
                    end
                end
            end
        else
            local item = Player.Functions.GetItemByName(items)
            if item then
                if amount then
                    if item.amount >= amount then
                        retval = true
                    end
                else
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)
