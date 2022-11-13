local QBCore = exports['qb-core']:GetCoreObject()
local Bail = {}

QBCore.Functions.CreateCallback('qg-bikerental:server:HasMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid

    if Player.PlayerData.money.cash >= Config.RentPrice then
        Bail[CitizenId] = "cash"
        Player.Functions.RemoveMoney('cash', Config.RentPrice)
         cb(true)
    elseif Player.PlayerData.money.bank >= Config.RentPrice then
        Bail[CitizenId] = "bank"
        Player.Functions.RemoveMoney('bank', Config.RentPrice)
        cb(true)
    else
        cb(false) 
    end
end)

QBCore.Functions.CreateCallback('qg-bikerental:server:CheckBail', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    if Bail[CitizenId] ~= nil then
        Player.Functions.AddMoney(Bail[CitizenId], Config.RentPrice)
        Bail[CitizenId] = nil
        cb(true)
    else
        cb(false)
    end
end)
