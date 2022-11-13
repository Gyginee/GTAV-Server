CreateThread(function()
    while true do
        Wait(0)
        if LocalPlayer.state.isLoggedIn then
            Wait((1000 * 60) * QBCore.Config.UpdateInterval)
            TriggerServerEvent('QBCore:UpdatePlayer')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(QBCore.Config.StatusInterval)
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local currentHealth = GetEntityHealth(ped)
            if QBCore.Functions.GetPlayerData().metadata['hunger'] <= 0 or QBCore.Functions.GetPlayerData().metadata['thirst'] <= 0 then
                SetEntityHealth(ped, currentHealth - math.random(5, 8))
            elseif QBCore.Functions.GetPlayerData().metadata['pee'] <= 0 or QBCore.Functions.GetPlayerData().metadata['poo'] <= 0 then
                SetEntityHealth(ped, currentHealth - math.random(3, 6))
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(QBCore.Config.Thongbao)
        if LocalPlayer.state.isLoggedIn then
            if QBCore.Functions.GetPlayerData().metadata['hunger'] <= 10 then
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang bị <span style='color:#ffd700'>đói</span>", 5000, "warning")
            elseif QBCore.Functions.GetPlayerData().metadata['thirst'] <= 10 then
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang bị <span style='color:#ffd700'>khát</span>", 5000, "warning")
            elseif QBCore.Functions.GetPlayerData().metadata['poo'] <= 10 then
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang bị <span style='color:#ffd700'>đầy bàng quang</span>", 5000, "warning")
            elseif QBCore.Functions.GetPlayerData().metadata['pee'] <= 10 then
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang bị <span style='color:#ffd700'>đau bụng</span>", 5000, "warning")
            end
        end
    end
end)