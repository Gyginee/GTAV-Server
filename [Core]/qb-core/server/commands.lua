QBCore.Commands = {}
QBCore.Commands.List = {}

-- Register & Refresh Commands

function QBCore.Commands.Add(name, help, arguments, argsrequired, callback, permission)
    if type(permission) == 'string' then
        permission = permission:lower()
    else
        permission = 'user'
    end
    QBCore.Commands.List[name:lower()] = {
        name = name:lower(),
        permission = permission,
        help = help,
        arguments = arguments,
        argsrequired = argsrequired,
        callback = callback
    }
end

function QBCore.Commands.Refresh(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local suggestions = {}
    if Player then
        for command, info in pairs(QBCore.Commands.List) do
            local isGod = QBCore.Functions.HasPermission(src, 'god')
            local hasPerm = QBCore.Functions.HasPermission(src, QBCore.Commands.List[command].permission)
            local isPrincipal = IsPlayerAceAllowed(src, 'command')
            if isGod or hasPerm or isPrincipal then
                suggestions[#suggestions + 1] = {
                    name = '/' .. command,
                    help = info.help,
                    params = info.arguments
                }
            end
        end
        TriggerClientEvent('chat:addSuggestions', tonumber(source), suggestions)
    end
end

-- Teleport

QBCore.Commands.Add('tp', 'TP đến người chơi hoặc toạ độ (Chỉ dành cho Admin)', { { name = 'id/x', help = 'ID người chơi hoặc toạ độ X' }, { name = 'y', help = 'Toạ độ Y' }, { name = 'z', help = 'Toạ độ Z' } }, false, function(source, args)
    local src = source
    if args[1] and not args[2] and not args[3] then
        local target = GetPlayerPed(tonumber(args[1]))
        if target ~= 0 then
            local coords = GetEntityCoords(target)
            TriggerClientEvent('QBCore:Command:TeleportToPlayer', src, coords)
        else
            TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error')
        end
    else
        if args[1] and args[2] and args[3] then
            local x = tonumber(args[1])
            local y = tonumber(args[2])
            local z = tonumber(args[3])
            if (x ~= 0) and (y ~= 0) and (z ~= 0) then
                TriggerClientEvent('QBCore:Command:TeleportToCoords', src, x, y, z)
            else
                TriggerClientEvent('xt-notify:Alert', src, "Giá trị sai", 'error')
            end
        else
            TriggerClientEvent('xt-notify:Alert', src, "Thiếu giá trị", 'error')
        end
    end
end, 'admin')

QBCore.Commands.Add('tpm', 'TP đến điểm đặt sẵn (Chỉ dành cho Admin)', {}, false, function(source)
    local src = source
    TriggerClientEvent('QBCore:Command:GoToMarker', src)
end, 'admin')


QBCore.Commands.Add('togglepvp', 'Chỉnh chế độ PvP (Chỉ dành cho Admin)', {}, false, function(source)
    local src = source
    local pvp_state = QBConfig.Server.pvp
    QBConfig.Server.pvp = not pvp_state
    TriggerClientEvent('QBCore:Client:PvpHasToggled', -1, QBConfig.Server.pvp)
end, 'admin')
-- Permissions

QBCore.Commands.Add('addpermission', 'Cấp quyền cho người chơi (Chỉ dành cho God)', { { name = 'id', help = 'ID người chơi' }, { name = 'permission', help = 'Quyền hạn(user, admin, god)' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local permission = tostring(args[2]):lower()
    if Player then
        QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
    else
        TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error')
    end
end, 'god')

QBCore.Commands.Add('removepermission', 'Xoá quyền của người chơi (Chỉ dành cho God)', { { name = 'id', help = 'ID người chơi' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        QBCore.Functions.RemovePermission(Player.PlayerData.source)
    else
        TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error')
    end
end, 'god')

-- Vehicle

QBCore.Commands.Add('sv', 'Gọi phương tiện (Chỉ dành cho Admin)', { { name = 'model', help = 'Mã của phương tiện' } }, true, function(source, args)
    local src = source
    TriggerClientEvent('QBCore:Command:SpawnVehicle', src, args[1])
end, 'admin')

QBCore.Commands.Add('dv', 'Delete Vehicle (Chỉ dành cho Admin)', {}, false, function(source)
    local src = source
    TriggerClientEvent('QBCore:Command:DeleteVehicle', src)
end, 'admin')

-- Money

QBCore.Commands.Add('givemoney', 'Cấp tiền cho người chơi (Chỉ dành cho Admin)', { { name = 'id', help = 'ID người chơi' }, { name = 'moneytype', help = 'Dạng tiền (cash, bank, crypto)' }, { name = 'amount', help = 'Số lượng' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Người chơi không online", 5000, 'error')
        --[[ TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error') ]]
    end
end, 'admin')

QBCore.Commands.Add('setmoney', 'Chỉnh số tiền của người chơi (Chỉ dành cho Admin)', { { name = 'id', help = 'ID người chơi' }, { name = 'moneytype', help = 'Dạng tiền (cash, bank, crypto)' }, { name = 'amount', help = 'Số lượng' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error')
    end
end, 'admin')

-- Job

QBCore.Commands.Add('job', 'Kiểm tra nghề nghiệp của bạn', {}, false, function(source)
    local src = source
    local PlayerJob = QBCore.Functions.GetPlayer(src).PlayerData.job
    TriggerClientEvent('xt-notify:Alert', src, string.format('[Công việc]: %s [Chức vụ]: %s [Tình trạng]: %s', PlayerJob.label, PlayerJob.grade.name, PlayerJob.onduty))
end, 'user')

QBCore.Commands.Add('setjob', 'Chỉnh công việc của người chơi (Chỉ dành cho Admin)', { { name = 'id', help = 'ID người chơi' }, { name = 'job', help = 'Tên công việc' }, { name = 'grade', help = 'Chức vụ' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error')
    end
end, 'admin')

-- Gang

QBCore.Commands.Add('gang', 'Kiểm tra băng đảng', {}, false, function(source)
    local src = source
    local PlayerGang = QBCore.Functions.GetPlayer(source).PlayerData.gang

    TriggerClientEvent('xt-notify:Alert', src, string.format('[Băng đảng]: %s [Vai vế]: %s', PlayerGang.label, PlayerGang.grade.name))
end, 'user')

QBCore.Commands.Add('setgang', 'Chỉnh sửa băng đảng cho người chơi (Chỉ dành cho Admin)', { { name = 'id', help = 'ID người chơi' }, { name = 'gang', help = 'Tên Băng đảng' }, { name = 'grade', help = 'Vai vế' } }, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player then
        Player.Functions.SetGang(tostring(args[2]), tonumber(args[3]))
    else
        TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error')
    end
end, 'admin')

-- Inventory (should be in qb-inventory?)

QBCore.Commands.Add('clearinv', 'Clear Players Inventory (Chỉ dành cho Admin)', { { name = 'id', help = 'ID người chơi' } }, false, function(source, args)
    local src = source
    local playerId = args[1] or src
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player then
        Player.Functions.ClearInventory()
    else
        TriggerClientEvent('xt-notify:Alert', src, "Người chơi không online", 'error')
    end
end, 'admin')

-- Out of Character Chat
--[[ 
QBCore.Commands.Add('ooc', 'Chat OOC', {}, false, function(source, args)
    local src = source
    local message = table.concat(args, ' ')
    local Players = QBCore.Functions.GetPlayers()
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(Players) do
        if v == src then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 0, 0, 255},
                multiline = true,
                args = {'OOC | '.. GetPlayerName(src), message}
            })
        elseif #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(v))) < 20.0 then
            TriggerClientEvent('chat:addMessage', v, {
                color = { 0, 0, 255},
                multiline = true,
                args = {'OOC | '.. GetPlayerName(src), message}
            })
        elseif QBCore.Functions.HasPermission(v, 'admin') or QBCore.Functions.HasPermission(v, 'god') then
            if QBCore.Functions.IsOptin(v) then
                TriggerClientEvent('chat:addMessage', v, {
                    color = { 0, 0, 255},
                    multiline = true,
                    args = {'THÔNG BÁO | '.. GetPlayerName(src), message}
                })
                TriggerEvent('qb-log:server:CreateLog', 'ooc', 'CHAT', 'white', '**' .. GetPlayerName(src) .. '** (Mã công dân: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. src .. ') **Tin nhắn:** ' .. message, false)
            end
        end
    end
end, 'user')

-- Me command

QBCore.Commands.Add('me', 'Chat gần', {{name = 'message', help = 'Nội dung'}}, false, function(source, args)
    local src = source
    local ped = GetPlayerPed(src)
    local pCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(src)
    if msg == '' then return end
    for k,v in pairs(QBCore.Functions.GetPlayers()) do
        local target = GetPlayerPed(v)
        local tCoords = GetEntityCoords(target)
        if #(pCoords - tCoords) < 20 then
            TriggerClientEvent('QBCore:Command:ShowMe3D', v, src, msg)
            TriggerEvent('qb-log:server:CreateLog', 'ooc', 'CHAT', 'white', '**' .. GetPlayerName(src) .. '** (Mã công dân: ' .. Player.PlayerData.citizenid .. ' | ID: ' .. src .. ') **Tin nhắn:** ' ..msg, false)
        end
    end
end, 'user')
 ]]