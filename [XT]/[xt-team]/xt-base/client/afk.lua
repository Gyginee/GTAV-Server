-- AFK Kick Time Limit (in seconds)
local group = 'user'
local secondsUntilKick = 1800
local QBCore = exports['qb-core']:GetCoreObject()
local prevPos, time = nil, nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-afkkick:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
end)

RegisterNetEvent('QBCore:Client:OnPermissionUpdate', function(UserGroup)
    group = UserGroup
end)

CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        if LocalPlayer.state.isLoggedIn then
            if group == 'user' then
                currentPos = GetEntityCoords(playerPed, true)
                if prevPos ~= nil then
                    if currentPos == prevPos then
                        if time ~= nil then
                            if time > 0 then
                                if time == (900) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" .. math.ceil(time / 60) .. "</span> phút!", 5000, 'warning')
                                elseif time == (600) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" .. math.ceil(time / 60) .. "</span> phút!", 5000, 'warning')
                                elseif time == (300) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" .. math.ceil(time / 60) .. "</span> phút!", 5000, 'warning')
                                elseif time == (150) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" .. math.ceil(time / 60) .. "</span> phút!", 5000, 'warning')
                                elseif time == (60) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" .. math.ceil(time / 60) .. "</span> phút!", 5000, 'warning')
                                elseif time == (30) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" ..time.. "</span> giây!", 5000, 'warning')
                                elseif time == (20) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" ..time.. "</span> giây!", 5000, 'warning')
                                elseif time == (10) then
                                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang <span style='color:#ffd700'>AFK</span> và sẽ bị <span style='color:#ffd700'>kick</span> sau <span style='color:#ffd700'>" ..time.. "</span> giây!", 5000, 'warning')
                                end
                                time = time - 1
                            else
                                TriggerServerEvent('KickForAFK')
                            end
                        else
                            time = secondsUntilKick
                        end
                    else
                        time = secondsUntilKick
                    end
                end
                prevPos = currentPos
            end
        end
    end
end)
