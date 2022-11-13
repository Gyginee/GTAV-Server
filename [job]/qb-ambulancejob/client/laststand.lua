Laststand = Laststand or {}
Laststand.ReviveInterval = 360
Laststand.MinimumRevive = 300
InLaststand = false
LaststandTime = 0
lastStandDict = "combat@damage@writhe"
lastStandAnim = "writhe_loop"
isEscorted = false
local isEscorting = false

-- Functions

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

local function LoadAnimation(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(100)
    end
end

function SetLaststand(bool, spawn)
    local ped = PlayerPedId()
    if bool then
        Wait(1000)
        local pos = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)

        while GetEntitySpeed(ped) > 0.5 or IsPedRagdoll(ped) do
            Wait(10)
        end

        TriggerServerEvent("InteractSound_SV:PlayOnSource", "demo", 0.1)

        LaststandTime = Laststand.ReviveInterval

        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local veh = GetVehiclePedIsIn(ped)
            local vehseats = GetVehicleModelNumberOfSeats(GetHashKey(GetEntityModel(veh)))
            for i = -1, vehseats do
                local occupant = GetPedInVehicleSeat(veh, i)
                if occupant == ped then
                    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
                    SetPedIntoVehicle(ped, veh, i)
                end
            end
        else
            NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
        end		
		
        SetEntityHealth(ped, 150)

        if IsPedInAnyVehicle(ped, false) then
            LoadAnimation("veh@low@front_ps@idle_duck")
            TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 8.0, -1, 1, -1, false, false, false)
        else
            LoadAnimation(lastStandDict)
            TaskPlayAnim(ped, lastStandDict, lastStandAnim, 1.0, 8.0, -1, 1, -1, false, false, false)
        end

        InLaststand = true

        TriggerServerEvent('xt-benhvien:server:ambulanceAlert', "Cư dân bị thương")

        CreateThread(function()
            while InLaststand do
                ped = PlayerPedId()
                player = PlayerId()
                if LaststandTime - 1 > Laststand.MinimumRevive then
                    LaststandTime = LaststandTime - 1
                    Config.DeathTime = LaststandTime
                elseif LaststandTime - 1 <= Laststand.MinimumRevive and LaststandTime - 1 ~= 0 then
                    LaststandTime = LaststandTime - 1
                    Config.DeathTime = LaststandTime
                elseif LaststandTime - 1 <= 0 then
                    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang bị chảy <span style='color:#fc1100'>máu</span>!", 5000, 'error')
                    SetLaststand(false)
                    local killer_2, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
                    local killer = GetPedSourceOfDeath(ped)

                    if killer_2 ~= 0 and killer_2 ~= -1 then
                        killer = killer_2
                    end

                    local killerId = NetworkGetPlayerIndexFromPed(killer)
                    local killerName = killerId ~= -1 and GetPlayerName(killerId) .. " " .. "("..GetPlayerServerId(killerId)..")" or "Tự tử hoặc bị NPC giết"
                    local weaponLabel = "Không xác định"
                    local weaponName = "Không xác định"
                    local weaponItem = QBCore.Shared.Weapons[killerWeapon]
                    if weaponItem then
                        weaponLabel = weaponItem.label
                        weaponName = weaponItem.name
                    end
                    TriggerServerEvent("qb-log:server:CreateLog", "death", GetPlayerName(-1).."("..GetPlayerServerId(player)..") đã chết" , "red", killerName.." đã giết chết "..GetPlayerName(player).." bằng "..weaponLabel.."("..weaponName..")" )
                    deathTime = 0
                    OnDeath()
                    DeathTimer()
                end
                Wait(1000)
            end
        end)
    else
        TaskPlayAnim(ped, lastStandDict, "exit", 1.0, 8.0, -1, 1, -1, false, false, false)
        InLaststand = false
        LaststandTime = 0
    end
    TriggerServerEvent("xt-benhvien:server:SetLaststandStatus", bool)
end

-- Events

RegisterNetEvent('xt-benhvien:client:SetEscortingState', function(bool)
    isEscorting = bool
end)

RegisterNetEvent('xt-benhvien:client:isEscorted', function(bool)
    isEscorted = bool
end)

RegisterNetEvent('xt-benhvien:client:UseFirstAid', function()
    if not isEscorting then
        local player, distance = GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            TriggerServerEvent('xt-benhvien:server:UseFirstAid', playerId)
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Không thể thực hiện hành động", 5000, 'error')
    end
end)

RegisterNetEvent('xt-benhvien:client:CanHelp', function(helperId)
    if InLaststand then
        if LaststandTime <= 300 then
            TriggerServerEvent('xt-benhvien:server:CanHelp', helperId, true)
        else
            TriggerServerEvent('xt-benhvien:server:CanHelp', helperId, false)
        end
    else
        TriggerServerEvent('xt-benhvien:server:CanHelp', helperId, false)
    end
end)

RegisterNetEvent('xt-benhvien:client:HelpPerson', function(targetId)
    local ped = PlayerPedId()
    isHealingPerson = true
    QBCore.Functions.Progressbar("hospital_revive", "Chữa trị", math.random(10000, 20000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = healAnimDict,
        anim = healAnim,
        flags = 1,
    }, {}, {}, function() -- Done
        isHealingPerson = false
        ClearPedTasks(ped)
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã cứu sống người đó", 5000, 'success')
        TriggerServerEvent("xt-benhvien:server:RevivePlayer", targetId)
    end, function() -- Cancel
        isHealingPerson = false
        ClearPedTasks(ped)
        exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ bỏ", 5000, 'error')
    end)
end)