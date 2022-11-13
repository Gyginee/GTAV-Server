local QBCore = exports['qb-core']:GetCoreObject()

local Races = {}

RegisterNetEvent('qb-streetraces:NewRace', function(RaceTable)
    local src = source
    local RaceId = math.random(1000, 9999)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveMoney('cash', RaceTable.amount, "streetrace-created") then
        Races[RaceId] = RaceTable
        Races[RaceId].creator = QBCore.Functions.GetIdentifier(src, 'license')
        Races[RaceId].joined[#Races[RaceId].joined+1] = QBCore.Functions.GetIdentifier(src, 'license')
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
        TriggerClientEvent('qb-streetraces:SetRaceId', src, RaceId)
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", 'Bạn đã tham gia cuộc đua với tiền cược $'..Races[RaceId].amount, 5000, 'success')
    end
end)

RegisterNetEvent('qb-streetraces:RaceWon', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddMoney('cash', Races[RaceId].pot, "race-won")
    TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", 'Bạn đã thắng cược đua với tiền cược $'..Races[RaceId].amount, 5000, 'success')
    TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
    TriggerClientEvent('qb-streetraces:RaceDone', -1, RaceId, GetPlayerName(src))
end)

RegisterNetEvent('qb-streetraces:JoinRace', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local zPlayer = QBCore.Functions.GetPlayer(Races[RaceId].creator)
    if zPlayer ~= nil then
        if xPlayer.PlayerData.money.cash >= Races[RaceId].amount then
            Races[RaceId].pot = Races[RaceId].pot + Races[RaceId].amount
            Races[RaceId].joined[#Races[RaceId].joined+1] = QBCore.Functions.GetIdentifier(src, 'license')
            if xPlayer.Functions.RemoveMoney('cash', Races[RaceId].amount, "streetrace-joined") then
                TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
                TriggerClientEvent('qb-streetraces:SetRaceId', src, RaceId)
                local ten = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname
                TriggerClientEvent('xt-notify:client:Alert', Races[RaceId].creator,"THÔNG BÁO", ten..' đã tham gia cuộc đua', 5000, 'info')
            end
        else
            TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không đủ tiền", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Người tạo cuộc đua hiện không có mặt trong thành phố", 5000, 'error')
        Races[RaceId] = {}
    end
end)

QBCore.Commands.Add("createrace", "Tạo ra một cuộc đua đường phố", {{name="amount", help="Số tiền cược"}}, false, function(source, args)
    local src = source
    local amount = tonumber(args[1])
    if GetJoinedRace(QBCore.Functions.GetIdentifier(src, 'license')) == 0 then
        TriggerClientEvent('qb-streetraces:CreateRace', src, amount)
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đang tham gia một cuộc đua khác", 5000, 'error')
    end
end)

QBCore.Commands.Add("stoprace", "Huỷ cuộc đua của bạn", {}, false, function(source, args)
    local src = source
    CancelRace(src)
end)

QBCore.Commands.Add("quitrace", "RỜi cuộc đua. (Bạn sẽ MẤT tiền cọc)", {}, false, function(source, args)
    local src = source
    local RaceId = GetJoinedRace(QBCore.Functions.GetIdentifier(src, 'license'))
    if RaceId ~= 0 then
        if GetCreatedRace(QBCore.Functions.GetIdentifier(src, 'license')) ~= RaceId then
            RemoveFromRace(QBCore.Functions.GetIdentifier(src, 'license'))
            TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn đã rời khỏi cuộc đua", 5000, 'error')
        else
            TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "/stoprace để dừng cuộc đua", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn không trong cuộc đua nào cả", 5000, 'error')
    end
end)

QBCore.Commands.Add("startrace", "Bắt đầu cuộc đua", {}, false, function(source, args)
    local src = source
    local RaceId = GetCreatedRace(QBCore.Functions.GetIdentifier(src, 'license'))

    if RaceId ~= 0 then

        Races[RaceId].started = true
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
        TriggerClientEvent("qb-streetraces:StartRace", -1, RaceId)
    else
        TriggerClientEvent('xt-notify:client:Alert', src,"THÔNG BÁO", "Bạn chưa bắt đầu cuộc đua nào cả", 5000, 'error')
    end
end)

function CancelRace(source)
    local RaceId = GetCreatedRace(QBCore.Functions.GetIdentifier(source, 'license'))
    local Player = QBCore.Functions.GetPlayer(source)

    if RaceId ~= 0 then
        for key, race in pairs(Races) do
            if Races[key] ~= nil and Races[key].creator == Player.PlayerData.license then
                if not Races[key].started then
                    for _, iden in pairs(Races[key].joined) do
                        local xdPlayer = QBCore.Functions.GetPlayer(iden)
                            xdPlayer.Functions.AddMoney('cash', Races[key].amount, "race-cancelled")
                            TriggerClientEvent('xt-notify:client:Alert', xdPlayer.PlayerData.source,"THÔNG BÁO", "Cuộc đua đã bị huỷ, bạn đã được nhận lại $"..Races[key].amount, 5000, 'error')
                            TriggerClientEvent('qb-streetraces:StopRace', xdPlayer.PlayerData.source)
                            RemoveFromRace(iden)
                    end
                else
                    TriggerClientEvent('xt-notify:client:Alert', Player.PlayerData.source,"THÔNG BÁO", "Cuộc đua đã bắt đầu", 5000, 'error')
                end
                TriggerClientEvent('xt-notify:client:Alert', source,"THÔNG BÁO", "Cuộc đua đã dừng lại", 5000, 'error')
                Races[key] = nil
            end
        end
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
    else
        TriggerClientEvent('xt-notify:client:Alert', source,"THÔNG BÁO", "Bạn chưa bắt đầu cuộc đua nào cả", 5000, 'error')
    end
end

function RemoveFromRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for i, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    table.remove(Races[key].joined, i)
                end
            end
        end
    end
end

function GetJoinedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for _, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    return key
                end
            end
        end
    end
    return 0
end

function GetCreatedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and Races[key].creator == identifier and not Races[key].started then
            return key
        end
    end
    return 0
end
