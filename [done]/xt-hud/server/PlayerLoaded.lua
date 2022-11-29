
RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    local identifier = GetIdentifier(src)
    CheckPreferencesExist(identifier)
    TriggerClientEvent('xt-hud:client:UpdateSettings', src,  preferences[identifier])
    if Config.UseStress then
        if stressData[identifier] == nil then
            stressData[identifier] = 0
        end
        TriggerClientEvent('hud:client:UpdateStress', src, stressData[identifier])

    end
    TriggerClientEvent('xt-hud:UpdateNitroData', src, nitro)
    TriggerClientEvent('xt-hud:SetForceHide', src, false)
    TriggerClientEvent('xt-hud:Loaded', src)

end)