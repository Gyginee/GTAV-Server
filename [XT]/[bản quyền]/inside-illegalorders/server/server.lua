QBCore = exports["qb-core"]:GetCoreObject()

QBCore.Functions.CreateCallback('inside-illegalordersType1:payout', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForFirstOrder
    Player.Functions.AddMoney('cash', money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType2:payout', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForSecondOrder
	Player.Functions.AddMoney('cash', money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType3:payout', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForThirdOrder
	Player.Functions.AddMoney('cash', money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType4:payout', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForFourthOrder
	Player.Functions.AddMoney('cash', money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType5:payout', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForFifthOrder
	Player.Functions.AddMoney('cash', money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType6:payout', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForSixthOrder
	Player.Functions.AddMoney('cash', money)
    cb(money)
end)

QBCore.Functions.CreateCallback('inside-illegalordersType7:payout', function(source, cb)
	local Player = QBCore.Functions.GetPlayer(source)
    local money = Config.PayoutForSeventhOrder
	Player.Functions.AddMoney('cash', money)
    cb(money)
end)

AddEventHandler('playerDropped', function()
    TriggerClientEvent('inside-illegalorders:removecars', source)
end)
