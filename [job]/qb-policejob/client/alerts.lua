local function AddAlert(Text, Sprite, Transition, Coords, Tracker)
    local Transition = Transition
    local Blips = AddBlipForCoord(Coords.x, Coords.y, Coords.z)
    SetBlipSprite(Blips, Sprite)
    SetBlipColour(Blips, 6)
    SetBlipDisplay(Blips, 4)
    SetBlipAlpha(Blips, transG)
    SetBlipScale(Blips, 1.0)
    SetBlipAsShortRange(Blips, false)
    SetBlipFlashes(Blips, true)
    BeginTextCommandSetBlipName('STRING')
    if not Tracker then
     AddTextComponentString('Cảnh báo: '..Text)
    else
     AddTextComponentString(Text)
    end
    EndTextCommandSetBlipName(Blips)
    while Transition ~= 0 do
        Wait(180 * 4)
        Transition = Transition - 1
        SetBlipAlpha(Blips, Transition)
        if Transition == 0 then
            SetBlipSprite(Blips, 2)
            RemoveBlip(Blips)
            return
        end
    end
   end


RegisterNetEvent('police:client:send:officer:down', function(Coords, StreetName, Info, Priority)
    if PlayerJob.name == 'police' and onDuty then
        local Title, Callsign = 'Cảnh sát nằm xuống', '10-13B'
        if Priority == 3 then
            Title, Callsign = 'Cảnh sát nằm xuống (Khẩn cấp)', '10-13A'
        end
        TriggerEvent('xt-alerts:client:send:alert', {
            timeOut = 7500,
            alertTitle = Title,
            priority = Priority,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-id-badge"></i>',
                    detail = Info['Callsign']..' | '..Info['Firstname'].. ' ' ..Info['Lastname'],
                },
                [2] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = Callsign,
        })
        AddAlert(Title, 306, 250, Coords, false)
    end
end)

RegisterNetEvent('police:client:send:alert:panic:button', function(Coords, StreetName)
    if PlayerJob.name == 'police' or PlayerJob.name == 'ambulance' then
        TriggerEvent('xt-alerts:client:send:alert', {
            timeOut = 7500,
            alertTitle = "Hỗ trợ",
            priority = 3,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = '10-13C',
        }, true)
        AddAlert('Hỗ trợ', 487, 250, Coords, false)
    end
end)

RegisterNetEvent('police:client:send:alert:gunshots', function(Coords, GunType, StreetName, InVeh)
   if PlayerJob.name == 'police' and onDuty then
     local AlertMessage, CallSign = 'Phát súng', '10-47A'
     if InVeh then
         AlertMessage, CallSign = 'Phát súng bắn từ xe', '10-47B'
     end
     TriggerEvent('xt-alerts:client:send:alert', {
        timeOut = 7500,
        alertTitle = AlertMessage,
        priority = 1,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="far fa-arrow-alt-circle-right"></i>',
                detail = GunType,
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = CallSign,
    })
    AddAlert(AlertMessage, 313, 250, Coords, false)
  end
end)

RegisterNetEvent('police:client:send:alert:dead', function(Coords, StreetName)
    if (QBCore.Functions.GetPlayerData().job.name == "police" or QBCore.Functions.GetPlayerData().job.name == "ambulance") and QBCore.Functions.GetPlayerData().job.onduty then
        TriggerEvent('xt-alerts:client:send:alert', {
            timeOut = 7500,
            alertTitle = "Người dân nằm xuống",
            priority = 1,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = '10-30B',
        }, true)
        AddAlert('Người dân nằm xuống', 480, 250, Coords, false)
    end
end)

RegisterNetEvent('police:client:send:bank:alert', function(Coords, StreetName)
    if PlayerJob.name == 'police' and onDuty then
        TriggerEvent('xt-alerts:client:send:alert', {
            timeOut = 15000,
            alertTitle = "Fleeca Bank",
            priority = 1,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = '10-42A',
        }, true)
        AddAlert('Fleeca Bank', 108, 250, Coords, false)
    end
end)


RegisterNetEvent('police:client:send:meter:alert', function(Coords, StreetName)
    if PlayerJob.name == 'police' and onDuty then
        TriggerEvent('xt-alerts:client:send:alert', {
            timeOut = 15000,
            alertTitle = "Đồng hồ Đỗ xe",
            priority = 1,
            coords = {
                x = Coords.x,
                y = Coords.y,
                z = Coords.z,
            },
            details = {
                [1] = {
                    icon = '<i class="fas fa-globe-europe"></i>',
                    detail = StreetName,
                },
            },
            callSign = '10-42A',
        }, true)
        AddAlert('Đồng hồ Đỗ xe', 108, 250, Coords, false)
    end
end)


RegisterNetEvent('police:client:send:alert:jewellery', function(Coords, StreetName)
 if PlayerJob.name == 'police' and onDuty then 
    TriggerEvent('xt-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Tiệm trang sức",
        priority = 1,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-42A',
    }, true)
    AddAlert('Tiệm trang sức', 617, 250, Coords, false)
 end
end)

RegisterNetEvent('police:client:send:alert:store', function(Coords, StreetName)
 if PlayerJob.name == 'police' and onDuty then 
    TriggerEvent('xt-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Cướp tiệm tạp hóa",
        priority = 0,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-98A',
    }, true)
    AddAlert('Cướp tiệm tạp hóa', 59, 250, Coords, false)
 end
end)

RegisterNetEvent('police:client:send:house:alert', function(Coords, StreetName)
 if PlayerJob.name == 'police' and onDuty then 
    TriggerEvent('xt-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Trộm nhà",
        priority = 0,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-63B',
    }, true)
    AddAlert('Trộm nhà', 40, 250, Coords, false)
 end
end)

RegisterNetEvent('police:client:send:ammunation:alert', function(Coords, StreetName)
 if PlayerJob.name == 'police' and onDuty then 
    TriggerEvent('xt-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Cướp tiệm súng",
        priority = 0,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-03A',
    }, true)
    AddAlert('Tiệm súng', 67, 250, Coords, false)
 end
end)

RegisterNetEvent('police:client:send:banktruck:alert', function(Coords, Plate, StreetName)
 if PlayerJob.name == 'police' and onDuty then 
    TriggerEvent('xt-alerts:client:send:alert', {
        timeOut = 15000,
        alertTitle = "Cướp xe chở tiền",
        priority = 0,
        coords = {
            x = Coords.x,
            y = Coords.y,
            z = Coords.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-closed-captioning"></i>',
                detail = 'Kenteken: '..Plate,
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = StreetName,
            },
        },
        callSign = '10-03A',
    }, true)
    AddAlert('Cướp xe chở tiền', 67, 250, Coords, false)
 end
end)

RegisterNetEvent('police:client:send:tracker:alert', function(Coords, Name)
    if PlayerJob.name == 'police' and onDuty then
      AddAlert('Vị trí: '..Name, 480, 250, Coords, true)
    end
end)

-- // Funtions \\ --

