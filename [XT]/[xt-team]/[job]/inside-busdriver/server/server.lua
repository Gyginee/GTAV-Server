local QBCore = exports["qb-core"]:GetCoreObject()
local Bail = {}

QBCore.Functions.CreateCallback('inside-busdriver:payout', function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = math.random(Config.MinPayout, Config.MaxPayout)
	xPlayer.Functions.AddMoney("cash", money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-busdriver:server:HasMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
     if Player.PlayerData.money.cash >= Config.BailPrice then
         Bail[CitizenId] = "cash"
         Player.Functions.RemoveMoney('cash', Config.BailPrice)
         cb(true)
     elseif Player.PlayerData.money.bank >= Config.BailPrice then
        Bail[CitizenId] = "bank"
        Player.Functions.RemoveMoney('bank', Config.BailPrice)
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('inside-busdriver:server:CheckBail', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CitizenId = Player.PlayerData.citizenid
    if Bail[CitizenId] ~= nil then
        Player.Functions.AddMoney(Bail[CitizenId], Config.BailPrice)
        Bail[CitizenId] = nil
        cb(true)
    else
        cb(false)
    end
end)