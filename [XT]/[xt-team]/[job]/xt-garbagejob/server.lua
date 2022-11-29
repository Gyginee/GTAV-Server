QBCore = exports['qb-core']:GetCoreObject()
local searchedBins = {}
local curjobs = {}
local jobzones = {}
local nhom = 0
-- functions
local function removeKey(key)
    local value = curjobs[key]
    if (value == nil) then
        return
    end
    curjobs[key] = nil
    jobzones[value] = nil
end
local function addValue(key, value)
    if (value == nil) then
        removeKey(key)
        return
    end
    curjobs[key] = value
    jobzones[value] = key
end
local function getValue(key)
    return curjobs[key]
end

-- callback
QBCore.Functions.CreateCallback('xt-garbagejob:pay', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bankamount = Player.PlayerData.money["bank"]
    if bankamount >= Config.Tiencoc then
        Player.Functions.RemoveMoney('bank', Config.Tiencoc)
        cb(true)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn cần "..Config.Tiencoc.."$ trong thẻ ngân hàng để đặt cọc", 5000, 'error')
        cb(false)
    end
end)
-- event
RegisterServerEvent('xt-garbagejob:server:tracoc', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('bank', Config.Tiencoc)
    TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn đã được nhận lại "..Config.Tiencoc.."$ tiền cọc", 5000, 'success')
end)

RegisterNetEvent('xt-garbagejob:server:taonhom', function(jobID, zone)
    addValue(jobID, zone)
end)
RegisterNetEvent('xt-garbagejob:server:check', function(ID)
    local src = source
    TriggerClientEvent('xt-garbagejob:client:check', src, ID)
end)
RegisterNetEvent('xt-garbagejob:server:thamgia', function(ID)
    local src = source
    local jobID = tonumber(ID)
    local zone = getValue(jobID)
    local Player = QBCore.Functions.GetPlayer(src)
    local ten = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname
    TriggerClientEvent('xt-garbagejob:client:thamgia', src, jobID, zone)
    TriggerClientEvent('xt-garbagejob:client:thanhvien', -1, ten, jobID)
end)

RegisterNetEvent('xt-garbagejob:server:capnhat', function(ID)
    local src = source
    local jobID = tonumber(ID)
    local zone = getValue(jobID)
    local Player = QBCore.Functions.GetPlayer(src)
    local ten = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname
    TriggerClientEvent('xt-garbagejob:client:capnhat', -1, jobID, zone)
end)

RegisterNetEvent('xt-garbagejob:server:nhom', function()
    local src = source
    nhom = nhom + 1
    if nhom == 9999 then
        nhom = 0
    end
    TriggerClientEvent('xt-garbagejob:client:taonhom', src, nhom)
end)

RegisterNetEvent('xt-garbagejob:server:nemrac', function(jobID)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local mayman = math.random(1, 20)
    TriggerClientEvent('xt-garbagejob:client:nemrac', -1, jobID)
    TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn đã được nhận được "..Config.Tien.."$ tiền", 5000, 'success')
    Player.Functions.AddMoney('cash', Config.Tien)
    if mayman >= 17 then
        local item = Config.Thuong[math.random(1, #Config.Thuong)]
        local soluong = math.random(Config.Min, Config.Max)
        Player.Functions.AddItem(item, soluong)
        TriggerClientEvent('xt-notify:client:Alert', src, "HỆ THỐNG", "Bạn đã được nhận được x"..soluong.." "..QBCore.Shared.Items[item].label, 5000, 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    end
end)
