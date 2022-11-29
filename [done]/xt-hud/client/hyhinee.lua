local QBCore = exports['qb-core']:GetCoreObject()

--[[ RegisterNetEvent('hud:client:UpdatePee', function(newPee) -- Add this event with adding pee elsewhere
    pee = newPee
end)
RegisterNetEvent('hud:client:UpdatePoo', function(newPoo) -- Add this event with adding poo elsewhere
    poo = newPoo
end) ]]

RegisterNetEvent('hud:client:UpdatePee', function(newPee) -- Add this event with adding stress elsewhere
    stress = newStress
    SendNUIMessage({ type="set_status", statustype = "pee", value = newPee})
end)

RegisterNetEvent('hud:client:UpdatePoo', function(newPoo) -- Add this event with adding stress elsewhere
    stress = newStress
    SendNUIMessage({ type="set_status", statustype = "poo", value = newPoo})
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if LocalPlayer.state.isLoggedIn then
            Citizen.Wait((1000*60)*5)
            TriggerServerEvent('hud:server:GainPee', math.random(2, 3))
        else
            Citizen.Wait(5000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if LocalPlayer.state.isLoggedIn then
            Citizen.Wait((1000*60)*5)
            TriggerServerEvent('hud:server:GainPoo', math.random(1, 2))
        else
            Citizen.Wait(5000)
        end
    end
end)