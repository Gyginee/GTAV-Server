local QBCore = exports["qb-core"]:GetCoreObject()
local Bail = {}

QBCore.Functions.CreateCallback('inside-gardener:server:HasMoney', function(source, cb)
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

QBCore.Functions.CreateCallback('inside-gardener:server:CheckBail', function(source, cb)
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


RegisterServerEvent('inside-gardener:Payout')
AddEventHandler('inside-gardener:Payout', function(salary, arg)	
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local Payout = salary * arg
	xPlayer.Functions.AddMoney("cash", Payout)
end)