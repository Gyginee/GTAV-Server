local banlength = nil
local showCoords = false
local vehicleDevMode = false
local banreason = 'Không xác định'
local kickreason = 'Không xác định'
local menuLocation = 'topright' -- e.g. topright (default), topleft, bottomright, bottomleft

local menu = MenuV:CreateMenu(false, "Menu Admin", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test')
local menu2 = MenuV:CreateMenu(false, "Tuỳ chỉnh", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test1')
local menu4 = MenuV:CreateMenu(false, "Người chơi Online", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test3')
local menu5 = MenuV:CreateMenu(false, "Tuỳ chỉnh server", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test4')
local menu6 = MenuV:CreateMenu(false, "Tuỳ chỉnh thời tiết", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test5')
local menu7 = MenuV:CreateMenu(false, "Danh sách Dealer", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test6')
local menu8 = MenuV:CreateMenu(false, "Ban", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test7')
local menu9 = MenuV:CreateMenu(false, "KIck", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test8')
local menu10 = MenuV:CreateMenu(false, "Quyền hạn", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test9')
local menu11 = MenuV:CreateMenu(false, "Chế độ Dev", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test10')
local menu12 = MenuV:CreateMenu(false, "Tuỳ chỉnh Phương tiện", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test11')
local menu13 = MenuV:CreateMenu(false, "Dang sách Phương tiện", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test12')
local menu14 = MenuV:CreateMenu(false, "Mã Phương tiện", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test13')

RegisterNetEvent('qb-admin:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)

local menu_button = menu:AddButton({
    icon = '😃',
    label = "Tuỳ chỉnh",
    value = menu2,
    description = "Tuỳ chỉnh chế độ Admin"
})
local menu_button2 = menu:AddButton({
    icon = '🙍‍♂️',
    label = "Quản lý Người chơi",
    value = menu4,
    description = "Xem danh sách Người chơi"
})
local menu_button3 = menu:AddButton({
    icon = '🎮',
    label = "Quản lý Server",
    value = menu5,
    description = "Tuỳ chỉnh Server"
})
local menu_button21 = menu:AddButton({
    icon = '🚗',
    label = "Phương tiện",
    value = menu12,
    description = "Tuỳ chỉnh Phương tiện"
})
local menu_button4 = menu:AddButton({
    icon = '💊',
    label = "Danh sách Dealer",
    value = menu7,
    description = "Tuỳ chỉnh Phương tiện"
})
local menu_button5 = menu2:AddCheckbox({
    icon = '🎥',
    label = "NoClip",
    value = menu2,
    description = "Bật/Tắt chế độ NoClip"
})
local menu_button6 = menu2:AddButton({
    icon = '🏥',
    label = "Hồi sinh",
    value = 'revive',
    description = "Hồi sinh bạn"
})
local menu_button7 = menu2:AddCheckbox({
    icon = '👻',
    label = "Tàng hình",
    value = menu2,
    description = "Bật/Tắt chế độ Tàng hình"
})
local menu_button8 = menu2:AddCheckbox({
    icon = '⚡',
    label = "Chế độ Bất tử",
    value = menu2,
    description = "Bật/Tắt chế độ Bất tử"
})
local names_button = menu2:AddCheckbox({
    icon = '📋',
    label = "Tên",
    value = menu2,
    description = "Bật/Tắt chế độ Hiển thị tên"
})
local blips_button = menu2:AddCheckbox({
    icon = '📍',
    label = "Blips",
    value = menu2,
    description = "Bật/Tắt chế độ hiện vị trí trên bản đồ"
})
local menu_button11 = menu5:AddButton({
    icon = '🌡️',
    label = "Tuỳ chỉnh thời tiết",
    value = menu6,
    description = "Thay đổi thời tiết"
})
local menu_button13 = menu5:AddSlider({
    icon = '⏲️',
    label = "Thời gian của Server",
    value = GetClockHours(),
    values = {{
        label = '00',
        value = '00',
        description = "Thời gian"
    }, {
        label = '01',
        value = '01',
        description = "Thời gian"
    }, {
        label = '02',
        value = '02',
        description = "Thời gian"
    }, {
        label = '03',
        value = '03',
        description = "Thời gian"
    }, {
        label = '04',
        value = '04',
        description = "Thời gian"
    }, {
        label = '05',
        value = '05',
        description = "Thời gian"
    }, {
        label = '06',
        value = '06',
        description = "Thời gian"
    }, {
        label = '07',
        value = '07',
        description = "Thời gian"
    }, {
        label = '08',
        value = '08',
        description = "Thời gian"
    }, {
        label = '09',
        value = '09',
        description = "Thời gian"
    }, {
        label = '10',
        value = '10',
        description = "Thời gian"
    }, {
        label = '11',
        value = '11',
        description = "Thời gian"
    }, {
        label = '12',
        value = '12',
        description = "Thời gian"
    }, {
        label = '13',
        value = '13',
        description = "Thời gian"
    }, {
        label = '14',
        value = '14',
        description = "Thời gian"
    }, {
        label = '15',
        value = '15',
        description = "Thời gian"
    }, {
        label = '16',
        value = '16',
        description = "Thời gian"
    }, {
        label = '17',
        value = '17',
        description = "Thời gian"
    }, {
        label = '18',
        value = '18',
        description = "Thời gian"
    }, {
        label = '19',
        value = '19',
        description = "Thời gian"
    }, {
        label = '20',
        value = '20',
        description = "Thời gian"
    }, {
        label = '21',
        value = '21',
        description = "Thời gian"
    }, {
        label = '22',
        value = '22',
        description = "Thời gian"
    }, {
        label = '23',
        value = '23',
        description = "Thời gian"
    }}
})

menu_button11:On("select",function()
    menu6:ClearItems()
    local elements = {
        [1] = {
            icon = '☀️',
            label = "Nắng to",
            value = "EXTRASUNNY",
            description = "Tôi cảm thấy mình đang tan chảy"
        },
        [2] = {
            icon = '☀️',
            label = "Trong lành",
            value = "CLEAR",
            description = "Một ngày thật tuyệt"
        },
        [3] = {
            icon = '☀️',
            label = "Ấm áp",
            value = "NEUTRAL",
            description = "Một ngày như bao ngày"
        },
        [4] = {
            icon = '🌁',
            label = "Sương mù",
            value = "SMOG",
            description = "Như một cỗ máy nhả khói"
        },
        [5] = {
            icon = '🌫️',
            label = "Sương mù x2",
            value = "FOGGY",
            description = "Như một cỗ máy nhả khói"
        },
        [6] = {
            icon = '⛅',
            label = "U ám",
            value = "OVERCAST",
            description = "Không có một chút nắng"
        },
        [7] = {
            icon = '☁️',
            label = "Mây mù",
            value = "CLOUDS",
            description = "Mặt trời của tôi đâu rồi?"
        },
        [8] = {
            icon = '🌤️',
            label = "Không mây",
            value = "CLEARING",
            description = "Những đám mây đã biến mất"
        },
        [9] = {
            icon = '☂️',
            label = "Mưa",
            value = "RAIN",
            description = "Đi tắm mưa thôi nào"
        },

        [10] = {
            icon = '⛈️',
            label = "Bão",
            value = "THUNDER",
            description = "Tìm ngay chỗ trốn đi"
        },
        [11] = {
            icon = '❄️',
            label = "Tuyết",
            value = "SNOW",
            description = "Thời tiết thật là lạnh"
        },
        [12] = {
            icon = '🌨️',
            label = "Bão tuyết",
            value = "BLIZZARD",
            description = "Ai đó tắt cái máy tạo tuyết này đi được không"
        },
        [13] = {
            icon = '❄️',
            label = "Giáng sinh 1",
            value = "SNOWLIGHT",
            description = "Không khí Giáng sinh đang đến gần"
        },
        [14] = {
            icon = '🌨️',
            label = "Giáng sinh 2",
            value = "XMAS",
            description = "Chuẩn bị đại chiến bóng tuyết thôi"
        },
        [15] = {
            icon = '🎃',
            label = "Halloween",
            value = "HALLOWEEN",
            description = "Bầu không khí thật rùng rợn"
        }
    }
    for k,v in ipairs(elements) do
        local menu_button14 = menu6:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn)
            local selection = btn.Value
            TriggerServerEvent('qb-weathersync:server:setWeather', selection.value)
            exports['xt-notify']:Alert("THÔNG BÁO", "Thời tiết đã được đổi thành <span style='color:#0092ff'>"..selection.label.."</span>!", 5000, 'info')
        end})
    end
end)

local menu_button69 = menu:AddButton({
    icon = '🔧',
    label = "Chế độ Dev",
    value = menu11,
    description = "Tuỳ chỉnh chế độ Dev"
})
local coords3_button = menu11:AddButton({
    icon = '📋',
    label = "Sao chép Vector3",
    value = 'coords',
    description = "Sao chép Vector3"
})
local coords4_button = menu11:AddButton({
    icon = '📋',
    label = "Sao chép Vector4",
    value = 'coords',
    description = "Sao chép Vector4"
})
local togglecoords_button = menu11:AddCheckbox({
    icon = '📍',
    label = "Toạ độ",
    value = nil,
    description = "Hiển thị toạ độ lên màn hình"
})

local heading_button = menu11:AddButton({
    icon = '📋',
    label = "Copy hướng",
    value = 'heading',
    description = "Copy hướng"
})

local vehicledev_button = menu11:AddButton({
    icon = '🚘',
    label = "Thông tin Phương tiện",
    value = nil,
    description = "Hiển thị thông tin Phương tiện"
})

local menu_dev_button = menu11:AddCheckbox({
    icon = '⚫',
    label = "Chế độ Dev",
    value = menu11,
    description = "Bật/Tắt chế độ Dev"
})

local deletelazer_button = menu11:AddCheckbox({
    icon = '🔫',
    label = "Gậy Info",
    value = menu11,
    description = "Bật/Tắt gậy Info"
})
local noclip_button = menu11:AddCheckbox({
    icon = '🎥',
    label = "NoClip",
    value = menu11,
    description = "Bật/Tắt chế độ NoClip"
})

local menu12_button1 = menu12:AddButton({
    icon = '🚗',
    label = "Menu Phương tiện",
    value = menu13,
    description = "Gọi ra phương tiện"
})
local menu12_button2 = menu12:AddButton({
    icon = '🔧',
    label = "Sửa Phương tiện",
    value = 'fix',
    description = "Sửa phương tiện này"
})
local menu12_button3 = menu12:AddButton({
    icon = '💲',
    label = "Mua Phương tiện",
    value = 'buy',
    description = "Mua Phương tiện này"
})
local menu12_button4 = menu12:AddButton({
    icon = '☠',
    label = "Xoá Phương tiện",
    value = 'remove',
    description = "Xoá Phương tiện này"
})

local dev = false
menu_dev_button:On('change', function(item, newValue, oldValue)
    dev = not dev
    TriggerEvent('qb-admin:client:ToggleDevmode')
    if dev then
        while dev do
            Wait(200)
            SetPlayerInvincible(PlayerId(), true)
        end
            SetPlayerInvincible(PlayerId(), false)
    end
end)

local deleteLazer = false
deletelazer_button:On('change', function(item, newValue, oldValue)
    deleteLazer = not deleteLazer
end)

local function round(input, decimalPlaces)
    return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", input))
end

local function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        }) 
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã sao chép <span style='color:#30ff00'><b>toạ độ</b></span> thành công!", 5000, 'success')
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = round(coords.x, 2)
        local y = round(coords.y, 2)
        local z = round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã sao chép <span style='color:#30ff00'><b>toạ độ</b></span> thành công!", 5000, 'success')
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = round(heading, 2)
        SendNUIMessage({
            string = h
        })
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã sao chép <span style='color:#30ff00'><b>hướng</b></span> thành công!", 5000, 'success')
    end
end

local function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

local function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = round(coords.x, 2)
            c.y = round(coords.y, 2)
            c.z = round(coords.z, 2)
            heading = round(heading, 2)
            Wait(0)
            Draw2DText(string.format('~w~'.."Vị trí" .. '~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

RegisterNetEvent('qb-admin:client:ToggleCoords', function()
    ToggleShowCoordinates()
end)

local function ToggleVehicleDeveloperMode()
    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    CreateThread(function()
        while vehicleDevMode do
            local ped = PlayerPedId()
            Wait(0)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText("Chế độ Dev", 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
                Draw2DText(string.format("Entity ID:" .. '~b~%s~s~ | ' .. "Net ID:" .. '~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
                Draw2DText(string.format("Model" .. '~b~%s~s~ | ' .. "Hash" .. '~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
                Draw2DText(string.format("Độ bền Động cơ" .. '~b~%s~s~ | ' .. "Độ bền Thân vỏ" .. '~b~%s~s~', round(eHealth, 2), round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
            end
        end
    end)
end

coords3_button:On("select", function()
    CopyToClipboard('coords3')
end)

coords4_button:On("select", function()
    CopyToClipboard('coords4')
end)

heading_button:On("select", function()
    CopyToClipboard('heading')
end)

vehicledev_button:On('select', function()
    ToggleVehicleDeveloperMode()
end)

noclip_button:On('change', function(item, newValue, oldValue)
    ToggleNoClipMode()
end)

togglecoords_button:On('change', function()
    ToggleShowCoordinates()
end)

local vehicles = {}
for k, v in pairs(QBCore.Shared.Vehicles) do
    local category = v["category"]
    if vehicles[category] == nil then
        vehicles[category] = { }
    end
    vehicles[category][k] = v
end

-- Car Categories

local function OpenCarModelsMenu(category)
    menu14:ClearItems()
    MenuV:OpenMenu(menu14)
    for k, v in pairs(category) do
        local menu_button10 = menu14:AddButton({
             label = v["name"],
             value = k,
             description = 'Spawn ' .. v["name"],
             select = function(btn)
                 TriggerServerEvent('QBCore:CallCommand', "sv", { k })
             end
        })
    end
end

menu12_button1:On('Select', function(item)
    menu13:ClearItems()
    for k, v in pairs(vehicles) do
        local menu_button10 = menu13:AddButton({
            label = k,
            value = v,
            description = "Danh sách",
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)

menu12_button2:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

menu12_button3:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

menu12_button4:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)

names_button:On('change', function()
    TriggerEvent('qb-admin:client:toggleNames')
end)
blips_button:On('change', function()
    TriggerEvent('qb-admin:client:toggleBlips')
end)

-- Dealer List

local function OpenDealerMenu(dealer)
    local EditDealer = MenuV:CreateMenu(false, "Chỉnh sửa Dealer" .. dealer["name"], menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv')
    EditDealer:ClearItems()
    MenuV:OpenMenu(EditDealer)
    local elements = {
        [1] = {
            icon = '➡️',
            label = "Đi đến" .. " " .. dealer["name"],
            value = "goto",
            description = "Đi đến" .. " " .. dealer["name"]
        },
        [2] = {
            icon = "☠",
            label = "Xoá" .. " " .. dealer["name"],
            value = "remove",
            description = "Xoá" .. " " .. dealer["name"]
        }
    }
    for k, v in ipairs(elements) do
        local menu_button10 = EditDealer:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values == "goto" then
                    TriggerServerEvent('QBCore:CallCommand', "dealergoto", { dealer["name"] })
                elseif values == "remove" then
                    TriggerServerEvent('QBCore:CallCommand', "deletedealer", { dealer["name"] })
                    EditDealer:Close()
                    menu7:Close()
                end
            end
        })
    end
end

menu_button4:On('Select', function(item)
    menu7:ClearItems()
    QBCore.Functions.TriggerCallback('test:getdealers', function(dealers)
        for k, v in pairs(dealers) do
            local menu_button10 = menu7:AddButton({
                label = v["name"],
                value = v,
                description = "Tên của Dealer",
                select = function(btn)
                    local select = btn.Value
                    OpenDealerMenu(select)
                end
            })
        end
    end)
end)

-- Player List

local function OpenPermsMenu(permsply)
    QBCore.Functions.TriggerCallback('qb-admin:server:getrank', function(rank)
        if rank then
            local selectedgroup = 'Không xác định'
            MenuV:OpenMenu(menu10)
            menu10:ClearItems()
            local menu_button20 = menu10:AddSlider({
                icon = '',
                label = 'Group',
                value = 'user',
                values = {{
                    label = 'User',
                    value = 'user',
                    description = 'Group'
                }, {
                    label = 'Admin',
                    value = 'admin',
                    description = 'Group'
                }, {
                    label = 'God',
                    value = 'god',
                    description = 'Group'
                }},
                change = function(item, newValue, oldValue)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "user", label = "User"}
                    elseif vcal == 2 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "admin", label = "Admin"}
                    elseif vcal == 3 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "god", label = "God"}
                    end
                end
            })

            local menu_button21 = menu10:AddButton({
                icon = '',
                label = "Xác nhận",
                value = "giveperms",
                description = 'Cấp quyền',
                select = function(btn)
                    if selectedgroup ~= 'Không xác định' then
                        TriggerServerEvent('qb-admin:server:setPermissions', permsply.id, selectedgroup)
                        exports['xt-notify']:Alert("THÔNG BÁO", "Thay đổi quyền hạn <span style='color:#30ff00'><b>thành công</b></span>!", 5000, 'success')
                        selectedgroup = 'Không xác định'
                    else
                        exports['xt-notify']:Alert("THÔNG BÁO", "Thay đổi quyền hạn <span style='color:#fc1100'>thất bại</span>!", 5000, 'error')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu)
        end
    end)
end

local function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0)
    Wait(0)
  end

  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
      return result
  end
end

local function LocalInputInt(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0)
      Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
      local result = GetOnscreenKeyboardResult()
      return tonumber(result)
    end
end

local function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(menu9)
    menu9:ClearItems()
    local menu_button19 = menu9:AddButton({
        icon = '',
        label = "Bạn cần 1 lý do",
        value = "reason",
        description = "Lí do kick",
        select = function(btn)
            kickreason = LocalInput("Lí do kick", 255)
        end
    })

    local menu_button18 = menu9:AddButton({
        icon = '',
        label = "Xác nhận",
        value = "kick",
        description = "Xác nhận kick",
        select = function(btn)
            if kickreason ~= 'Không xác định' then
                TriggerServerEvent('qb-admin:server:kick', kickplayer, kickreason)
                kickreason = 'Không xác định'
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không có <span style='color:#fc1100'>lý do</span>!", 5000, 'error')
            end
        end
    })
end

local function OpenBanMenu(banplayer)
    MenuV:OpenMenu(menu8)
    menu8:ClearItems()
    local menu_button15 = menu8:AddButton({
        icon = '',
        label = "Bạn cần 1 lý do",
        value = "reason",
        description = "Lí do ban",
        select = function(btn)
            banreason = LocalInput("Lí do ban", 255)
        end
    })

    local menu_button16 = menu8:AddSlider({
        icon = '⏲️',
        label = "Thời gian",
        value = '3600',
        values = {{
            label = "1 giờ",
            value = '3600',
            description = "Thời gian Ban"
        }, {
            label = "6 giờ",
            value ='21600',
            description = "Thời gian Ban"
        }, {
            label = "12 giờ",
            value = '43200',
            description = "Thời gian Ban"
        }, {
            label = "1 ngày",
            value = '86400',
            description = "Thời gian Ban"
        }, {
            label = "3 ngày",
            value = '259200',
            description = "Thời gian Ban"
        }, {
            label = "1 tuần",
            value = '604800',
            description = "Thời gian Ban"
        }, {
            label = "1 tháng",
            value = '2678400',
            description = "Thời gian Ban"
        }, {
            label = "3 tháng",
            value = '8035200',
            description = "Thời gian Ban"
        }, {
            label = "6 tháng",
            value = '16070400',
            description = "Thời gian Ban"
        }, {
            label = "1 năm",
            value = '32140800',
            description = "Thời gian Ban"
        }, {
            label = "Dài hạn",
            value = '99999999999',
            description = "Thời gian Ban"
        }, {
            label = "Tự chỉnh",
            value = "self",
            description = "Thời gian Ban"
        }},
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                banlength = LocalInputInt('Ban Length', 11)
            else
                banlength = newValue
            end
        end
    })

    local menu_button17 = menu8:AddButton({
        icon = '',
        label = "Xác nhận",
        value = "ban",
        description = "Xác nhận Ban",
        select = function(btn)
            if banreason ~= 'Không xác định' and banlength ~= nil then
                TriggerServerEvent('qb-admin:server:ban', banplayer, banlength, banreason)
                banreason = 'Không xác định'
                banlength = nil
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Không có <span style='color:#fc1100'>lý do</span>!", 5000, 'error')
            end
        end
    })
end

local function OpenPlayerMenus(player)
    local Players = MenuV:CreateMenu(false, player.cid .. "Tuỳ chỉnh", menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    local elements = {
        [1] = {
            icon = '💀',
            label = "Giết",
            value = "kill",
            description = "Giết".. " " .. player.cid
        },
        [2] = {
            icon = '🏥',
            label = "Hồi sinh",
            value = "revive",
            description = "Hồi sinh" .. " " .. player.cid
        },
        [3] = {
            icon = '🥶',
            label = "Đóng băng",
            value = "freeze",
            description = "Đóng băng" .. " " .. player.cid
        },
        [4] = {
            icon = '👀',
            label = "Theo dõi",
            value = "spectate",
            description = "Theo dõi" .. " " .. player.cid
        },
        [5] = {
            icon = '➡️',
            label = "Đi đến",
            value = "goto",
            description = "Đi đến vị trí của"  .. player.cid
        },
        [6] = {
            icon = '⬅️',
            label = "Kéo lại",
            value = "bring",
            description = "Kéo lại" .. " " .. player.cid .. " vị trí của bạn"
        },
        [7] = {
            icon = '🚗',
            label = "Ngồi vào phương tiện",
            value = "intovehicle",
            description = "Ngồi vào phương tiện của" .. " " .. player.cid
        },
        [8] = {
            icon = '🎒',
            label = "Mở túi đồ",
            value = "inventory",
            description = "Mở túi đồ của" .. " " .. player.cid
        },
        [9] = {
            icon = '👕',
            label = "Bật menu quần áo",
            value = "cloth",
            description = "Bật menu quần áo" .. " " .. player.cid
        },
        [10] = {
            icon = '🥾',
            label = "KIck",
            value = "kick",
            description = "KIck" .. " " .. player.cid .. " " .. "Bạn cần 1 lý do"
        },
        [11] = {
            icon = '🚫',
            label = "Ban",
            value = "ban",
            description = "Ban" .. " " .. player.cid .. " " .. "Bạn cần 1 lý do"
        },
        [12] = {
            icon = '🎟️',
            label = "Quyền hạn",
            value = "perms",
            description = "Đưa" .. " " .. player.cid .. " " .. "Quyền hạn"
        }
    }
    for k, v in ipairs(elements) do
        local menu_button10 = Players:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values ~= "ban" and values ~= "kick" and values ~= "perms" then
                    TriggerServerEvent('qb-admin:server:'..values, player)
                elseif values == "ban" then
                    OpenBanMenu(player)
                elseif values == "kick" then
                    OpenKickMenu(player)
                elseif values == "perms" then
                    OpenPermsMenu(player)
                end
            end
        })
    end
end

menu_button2:On('select', function(item)
    menu4:ClearItems()
    QBCore.Functions.TriggerCallback('test:getplayers', function(players)
        for k, v in pairs(players) do
            local menu_button10 = menu4:AddButton({
                label = "ID: " .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = "Tên người chơi",
                select = function(btn)
                    local select = btn.Value -- get all the values from v!
                    OpenPlayerMenus(select) -- only pass what i select nothing else
                end
            }) -- WORKS
        end
    end)
end)

menu_button13:On("select", function(item, value)
    TriggerServerEvent("qb-weathersync:server:setTime", value, value)
    exports['xt-notify']:Alert("THÔNG BÁO", "Thời gian đã được thay đổi thành <span style='color:#30ff00'><b>"..value..":00</b></span>!", 5000, 'success')
end)

-- Toggle NoClip

menu_button5:On('change', function(item, newValue, oldValue)
    ToggleNoClipMode()
end)

-- Revive Self

menu_button6:On('select', function(item)
    TriggerEvent('hospital:client:Revive', PlayerPedId())
end)

-- Invisible

local invisible = false
menu_button7:On('change', function(item, newValue, oldValue)
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

-- Godmode

local godmode = false
menu_button8:On('change', function(item, newValue, oldValue)
    godmode = not godmode

    if godmode then
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

local function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =
	{
		x = 0.5*(max.x - min.x),
		y = 0.5*(max.y - min.y),
		z = 0.5*(max.z - min.z)
	}

    local FUR =
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x,
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y,
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL =
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 =
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 =
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 =
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 =
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 =
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 =
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end

CreateThread(function()	-- While loop needed for delete lazer
	while true do
		sleep = 1000
		if deleteLazer then
		    sleep = 5
		    local color = {r = 255, g = 255, b = 255, a = 200}
		    local position = GetEntityCoords(PlayerPedId())
		    local hit, coords, entity = RayCastGamePlayCamera(1000.0)
		    -- If entity is found then verifie entity
		    if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
			local entityCoord = GetEntityCoords(entity)
			local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
			DrawEntityBoundingBox(entity, color)
			DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
			Draw2DText("Obj" .. ': ~b~' .. entity .. '~w~ ' .. "Model" .. '~b~' .. GetEntityModel(entity), 4, {255, 255, 255}, 0.4, 0.55, 0.888)
			Draw2DText("Nhấn [~g~E~s~] để xoá", 4, {255, 255, 255}, 0.4, 0.55, 0.888 + 0.025)
			-- When E pressed then remove targeted entity
			if IsControlJustReleased(0, 38) then
			    -- Set as missionEntity so the object can be remove (Even map objects)
			    SetEntityAsMissionEntity(entity, true, true)
			    --SetEntityAsNoLongerNeeded(entity)
			    --RequestNetworkControl(entity)
			    DeleteEntity(entity)
			end
		    -- Only draw of not center of map
		    elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
			-- Draws line to targeted position
			DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
			DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
		    end
		end
		Wait(sleep)
	end
end)
