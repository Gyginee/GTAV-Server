nitro = {}

if Config.EnableNitro then

    Citizen.CreateThread(function()
        while frameworkObject == nil do
            Citizen.Wait(0)
        end
    
        if Config.Framework == "esx" then
            frameworkObject.RegisterUsableItem(Config.NitroItem, function(source)
                TriggerClientEvent('xt-hud:SetupNitro', source)
            end)
        else
            frameworkObject.Functions.CreateUseableItem(Config.NitroItem, function(source)
                TriggerClientEvent('xt-hud:SetupNitro', source)
            end)
        end
    end)
    
    RegisterServerEvent('xt-hud:InstallNitro')
    AddEventHandler('xt-hud:InstallNitro', function(plate)
        local src = source
        if plate then
            nitro[plate] = 100
            TriggerClientEvent('xt-hud:UpdateNitroData', -1, nitro)
        end
    end)
    
    RegisterServerEvent('xt-hud:UpdateNitro')
    AddEventHandler('xt-hud:UpdateNitro', function(plate, val)
        local src = source
        if plate then
            if nitro[plate] then
                nitro[plate] = val
                TriggerClientEvent('xt-hud:UpdateNitroData', -1, nitro)
            end
        end
    end)
end
