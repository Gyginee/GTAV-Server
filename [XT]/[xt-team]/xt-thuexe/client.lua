QBCore = exports['qb-core']:GetCoreObject()
blips = {}
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    createBlips()
end)
function createBlips()
    for k, v in pairs(Config.Locations) do
        blips[k] = AddBlipForCoord(tonumber(v.coords.x), tonumber(v.coords.y), tonumber(v.coords.z))
        SetBlipSprite(blips[k], Config.BlipsIcon)
        SetBlipDisplay(blips[k], 4)
        SetBlipScale(blips[k], 1.2)
        SetBlipColour(blips[k], Config.BlipsColor)
        SetBlipAsShortRange(blips[k], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(Config.BlipsLabel))
        EndTextCommandSetBlipName(blips[k])
    end
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
        local hash = GetEntityModel(GetVehiclePedIsIn(ped),false)
        local vehicle =  GetHashKey(Config.Vehicle)
        for k, v in pairs(Config.Locations) do
            local distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
            if isLoggedIn then
                if distance < 10.0 then
                    DrawMarker(2, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0,
                        0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if distance < 1.5 then
                        if InVehicle then
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z, "[~g~E~w~] - Trả xe")
                            if IsControlJustReleased(0, 38) then
                                if hash == vehicle then
                                    QBCore.Functions.TriggerCallback('qg-bikerental:server:CheckBail', function(DidBail)
                                        if DidBail then
                                            BringBackCar()
                                            exports['xt-notify']:Alert("Hệ thống", "Đã hoàn trả xe!", 5000, 'success')
                                        else
                                            exports['xt-notify']:Alert("Hệ thống", "Chiếc xe không được bạn thuê", 5000, 'error')
                                        end
                                    end)
                                else
                                    exports['xt-notify']:Alert("Hệ thống", "Không thể hoàn trả phương tiện này!", 5000, 'error')
                                end
                            end
                        else
                            DrawText3D(v.coords.x, v.coords.y, v.coords.z, "[~g~E~w~] - Lấy xe")
                            if IsControlJustReleased(0, 38) then
                                QBCore.Functions.TriggerCallback('qg-bikerental:server:HasMoney', function(HasMoney)
                                    if HasMoney then
                                        local coords  = v.coords
                                        QBCore.Functions.SpawnVehicle(Config.Vehicle, function(veh)
                                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                            exports['xt-notify']:Alert("Hệ thống", "Bạn đã thuê xe với giá $100", 5000, 'success')
                                        end, coords, true)
                                    else
                                        exports['xt-notify']:Alert("Hệ thống", "Bạn không đủ tiền để thuê ..", 5000, 'error')
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)

function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    DeleteVehicle(veh)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
 