-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData, CurrentWeaponData, CanShoot, MultiplierAmount = {}, {}, true, 0

-- Handlers

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback("weapons:server:GetConfig", function(RepairPoints)
        for k, data in pairs(RepairPoints) do
            Config.WeaponRepairPoints[k].IsRepairing = data.IsRepairing
            Config.WeaponRepairPoints[k].RepairingData = data.RepairingData
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    for k, v in pairs(Config.WeaponRepairPoints) do
        Config.WeaponRepairPoints[k].IsRepairing = false
        Config.WeaponRepairPoints[k].RepairingData = {}
    end
end)

-- Functions

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Events

RegisterNetEvent("weapons:client:SyncRepairShops", function(NewData, key)
    Config.WeaponRepairPoints[key].IsRepairing = NewData.IsRepairing
    Config.WeaponRepairPoints[key].RepairingData = NewData.RepairingData
end)

RegisterNetEvent("addAttachment", function(component)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = QBCore.Shared.Weapons[weapon]
    GiveWeaponComponentToPed(ped, GetHashKey(WeaponData.name), GetHashKey(component))
end)

RegisterNetEvent('weapons:client:EquipTint', function(tint)
    local player = PlayerPedId()
    local weapon = GetSelectedPedWeapon(player)
    SetPedWeaponTintIndex(player, weapon, tint)
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data, bool)
    if data ~= false then
        CurrentWeaponData = data
    else
        CurrentWeaponData = {}
    end
    CanShoot = bool
end)

RegisterNetEvent('weapons:client:SetWeaponQuality', function(amount)
    if CurrentWeaponData and next(CurrentWeaponData) then
        TriggerServerEvent("weapons:server:SetWeaponQuality", CurrentWeaponData, amount)
    end
end)

RegisterNetEvent('weapon:client:AddAmmo', function(type, amount, itemData)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    if CurrentWeaponData then
        if QBCore.Shared.Weapons[weapon]["name"] ~= "weapon_unarmed" and QBCore.Shared.Weapons[weapon]["ammotype"] == type:upper() then
            TriggerEvent('inventory:client:set:busy', true)
            local total = GetAmmoInPedWeapon(ped, weapon)
            local found, maxAmmo = GetMaxAmmo(ped, weapon)
            if total < maxAmmo then
                QBCore.Functions.Progressbar("taking_bullets", "Nạp đạn", math.random(4000, 6000), false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    local weapon2 = GetSelectedPedWeapon(ped)
                    if weapon == weapon2 then
                        if QBCore.Shared.Weapons[weapon] then
                            AddAmmoToPed(ped,weapon,amount)
                            TaskReloadWeapon(ped)
                            TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, total + amount)
                            TriggerServerEvent('QBCore:Server:RemoveItem', itemData.name, 1, itemData.slot)
                            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[itemData.name], "remove")
                            exports['xt-notify']:Alert("THÔNG BÁO", "Nạp đạn <span style='color:#4fff00'>thành công</span>!", 5000, 'success')
                            TriggerEvent('inventory:client:set:busy', false)
                        end
                    end
                end, function()
                    TriggerEvent('inventory:client:set:busy', false)
                    exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ bỏ", 5000, 'error')
                end)
            else
                TriggerEvent('inventory:client:set:busy', false)
                exports['xt-notify']:Alert("THÔNG BÁO", "Băng đạn đã <span style='color:#ff1100'>đầy</span>!", 5000, 'error')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không cầm <span style='color:#ff1100'>vũ khí</span>!", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không cầm <span style='color:#ff1100'>vũ khí</span>!", 5000, 'error')
    end
end)

RegisterNetEvent("weapons:client:EquipAttachment", function(ItemData, attachment)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = QBCore.Shared.Weapons[weapon]
    if weapon ~= `WEAPON_UNARMED` then
        WeaponData.name = WeaponData.name:upper()
        if WeaponAttachments[WeaponData.name] then
            if WeaponAttachments[WeaponData.name][attachment]['item'] == ItemData.name then
                TriggerServerEvent("weapons:server:EquipAttachment", ItemData, CurrentWeaponData, WeaponAttachments[WeaponData.name][attachment])
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Phụ kiện không <span style='color:#ff1100'>phù hợp</span> với vũ khí này!", 5000, 'error')
            end
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không cầm <span style='color:#ff1100'>vũ khí</span>!", 3000, 'error')
    end
end)

-- Threads

CreateThread(function()
    SetWeaponsNoAutoswap(true)
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedArmed(ped, 7) == 1 and (IsControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 24)) then
            local weapon = GetSelectedPedWeapon(ped)
            local ammo = GetAmmoInPedWeapon(ped, weapon)
            TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, tonumber(ammo))
            if MultiplierAmount > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponQuality", CurrentWeaponData, MultiplierAmount)
                MultiplierAmount = 0
            end
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            if CurrentWeaponData and next(CurrentWeaponData) then
                if IsPedShooting(ped) or IsControlJustPressed(0, 24) then
                    local weapon = GetSelectedPedWeapon(ped)
                    if CanShoot then
                        if weapon and weapon ~= 0 and QBCore.Shared.Weapons[weapon] then
                            local ammo = GetAmmoInPedWeapon(ped, weapon)
                            if QBCore.Shared.Weapons[weapon]["name"] == "weapon_snowball" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "snowball", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_pipebomb" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_pipebomb", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_molotov" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_molotov", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_stickybomb" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_stickybomb", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_grenade" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_grenade", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_bzgas" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_bzgas", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_proxmine" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_proxmine", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_ball" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_ball", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_smokegrenade" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_smokegrenade", 1)
                            elseif QBCore.Shared.Weapons[weapon]["name"] == "weapon_flare" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_flare", 1)
                            else
                                if ammo > 0 or weapon == `weapon_dagger` or weapon == `weapon_bat` or weapon == `weapon_bottle` or weapon == `weapon_crowbar` or weapon == `weapon_golfclub` or weapon == `weapon_hammer` or weapon == `weapon_knuckle`or weapon == `weapon_hatchet` or weapon == `weapon_knife` or weapon == `weapon_machete` or weapon == `weapon_switchblade`or weapon == `weapon_nightstick` or weapon == `weapon_wrench` or weapon == `weapon_battleaxe`or weapon == `weapon_poolcue` or weapon == `weapon_bread`or weapon == `weapon_stone_hatchet` then
                                    MultiplierAmount = MultiplierAmount + 1
                                end
                            end
                        end
                    else
                        if weapon ~= -1569615261 then
                            TriggerEvent('inventory:client:CheckWeapon', QBCore.Shared.Weapons[weapon]["name"])
                            exports['xt-notify']:Alert("THÔNG BÁO", "Vũ khí này đã <span style='color:#ff1100'>hỏng</span>!", 5000, 'error')
                            MultiplierAmount = 0
                        end
                    end
                end
            end
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local inRange = false
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k, data in pairs(Config.WeaponRepairPoints) do
                local distance = #(pos - data.coords)
                if distance < 10 then
                    inRange = true
                    if distance < 1 then
                        if data.IsRepairing then
                            if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "Cửa hàng sửa chữa hiện ~r~KHÔNG~s~ thể sử dụng")
                            else
                                if not data.RepairingData.Ready then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "Vũ khí của bạn đang được sửa chữa")
                                else
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "[~g~E~s~] - Nhận lại vũ khí")
                                end
                            end
                        else
                            if CurrentWeaponData and next(CurrentWeaponData) then
                                if not data.RepairingData.Ready then
                                    local WeaponData = QBCore.Shared.Weapons[GetHashKey(CurrentWeaponData.name)]
                                    local WeaponClass = (QBCore.Shared.SplitStr(WeaponData.ammotype, "_")[2]):lower()
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "[~g~E~s~] - Sửa vũ khí với giá "..Config.WeaponRepairCosts[WeaponClass])
                                    if IsControlJustPressed(0, 38) then
                                        QBCore.Functions.TriggerCallback('weapons:server:RepairWeapon', function(HasMoney)
                                            if HasMoney then
                                                CurrentWeaponData = {}
                                            end
                                        end, k, CurrentWeaponData)
                                    end
                                else
                                    if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "Cửa hàng sửa chữa hiện ~r~KHÔNG~s~ thể sử dụng")
                                    else
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "[~g~E~s~] - Nhận lại vũ khí")
                                        if IsControlJustPressed(0, 38) then
                                            TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                        end
                                    end
                                end
                            else
                                if data.RepairingData.CitizenId == nil then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "~r~Bạn đang không cầm vũ khí nào")
                                elseif data.RepairingData.CitizenId == PlayerData.citizenid then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, "Nhấn [~g~E~s~] - Nhận lại vũ khí")
                                    if IsControlJustPressed(0, 38) then
                                        TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if not inRange then
                Wait(1000)
            end
        end
        Wait(3)
    end
end)
