local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('xt-nghedien:PayJob', function(money, can)
    local src = source
    if can == 'sdafghjrehrw2345dfe' then
        local xPlayer = QBCore.Functions.GetPlayer(src)
        xPlayer.Functions.AddMoney('cash', money, 'Pay Job')
        print(money)
    else
        DropPlayer(src, 'Bye, Bye Cheater')
    end
end)