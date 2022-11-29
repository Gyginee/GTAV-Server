local QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = true
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    Wait(1250)
    isLoggedIn = true
end)
RegisterNetEvent("QBCore:Client:OnPlayerUnload")
AddEventHandler("QBCore:Client:OnPlayerUnload", function()
    isLoggedIn = false
end)

RegisterNetEvent("xt-vesinh:client:didai", function()
    if QBCore.Functions.GetPlayerData().metadata['pee'] >= 80 then
        QBCore.Functions.GetPlayerData(function(playerdata)
            if playerdata.charinfo.gender == 1 then
                TriggerServerEvent('xt-vesinh:server:vesinh', GetPlayerPed(GetPlayerFromServerId(PlayerId())), 'di-dai', 'female')
                TriggerServerEvent("QBCore:Server:SetMetaData", "pee", 0)
            else
                TriggerServerEvent('xt-vesinh:server:vesinh', GetPlayerPed(GetPlayerFromServerId(PlayerId())), 'di-dai', 'male')
                TriggerServerEvent("QBCore:Server:SetMetaData", "pee", 0)
            end
        end)
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn chưa buồn đái", 5000, 'warning')
    end
    Wait(1000)
end)

RegisterNetEvent("xt-vesinh:client:diia", function()
    if QBCore.Functions.GetPlayerData().metadata['poo'] >= 80 then
        TriggerServerEvent('xt-vesinh:server:vesinh', GetPlayerPed(GetPlayerFromServerId(PlayerId())), 'di-ia')
        TriggerServerEvent("QBCore:Server:SetMetaData", "poo", 0)
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn chưa buồn ỉa", 5000, 'warning')
    end
    Wait(1000)
end)
RegisterNetEvent('xt-vesinh:client:vesinh', function(ped, need, sex)
    if need == 'di-dai' then
        Pee(ped, sex)
    else
        Poop(ped)
    end
    Wait(500)
end)

RegisterNetEvent('xt-vesinh:client:stress', function()
    TriggerServerEvent('hud:server:GainStress', math.random(2, 3))
end)

--[[ CreateThread(function()
    while true do
        Wait(1000)
        if isLoggedIn then
            if IsEntityInWater(PlayerPedId()) then
                TriggerServerEvent('qg-hud:Server:RelieveClean', math.random(0,1))
            end
        else
            Wait(5000)
        end
    end
end) ]]

function Pee(ped, sex)
    local Player = ped
    local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))
    local particleDictionary = "core"
    local particleName = "ent_amb_peeing"
    local animDictionary = 'misscarsteal2peeing'
    local animName = 'peeing_loop'
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Wait(0)
    end
    RequestAnimDict(animDictionary)
    while not HasAnimDictLoaded(animDictionary) do
        Wait(0)
    end
    RequestAnimDict('missfbi3ig_0')
    while not HasAnimDictLoaded('missfbi3ig_0') do
        Wait(1)
    end
    if sex == 'male' then
        SetPtfxAssetNextCall(particleDictionary)
        local bone = GetPedBoneIndex(PlayerPed, 11816)
        local heading = GetEntityPhysicsHeading(PlayerPed)
        TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
        local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.2, 0.0, -140.0, 0.0, 0.0, bone, 2.5, false, false, false)
        Wait(3500)
        StopParticleFxLooped(effect, 0)
        ClearPedTasks(PlayerPed)
    else
        SetPtfxAssetNextCall(particleDictionary)
        bone = GetPedBoneIndex(PlayerPed, 11816)
        local heading = GetEntityPhysicsHeading(PlayerPed)
        TaskPlayAnim(PlayerPed, 'missfbi3ig_0', 'shit_loop_trev', 8.0, -8.0, -1, 0, 0, false, false, false)
        local effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.55, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
        Wait(3500)
        Wait(100)
        StopParticleFxLooped(effect, 0)
        ClearPedTasks(PlayerPed)
    end
end

function Poop(ped)
    local PlayerPed = GetPlayerPed(GetPlayerFromServerId(ped))
    local particleDictionary = "scr_amb_chop"
    local particleName = "ent_anim_dog_poo"
    local animDictionary = 'missfbi3ig_0'
    local animName = 'shit_loop_trev'
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
        Wait(0)
    end
    RequestAnimDict(animDictionary)
    while not HasAnimDictLoaded(animDictionary) do
        Wait(0)
    end
    SetPtfxAssetNextCall(particleDictionary)
    --gets bone on specified ped
    bone = GetPedBoneIndex(PlayerPed, 11816)
    --animation
    TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
    --2 effets for more shit
    effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
    Wait(3500)
    effect2 = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, bone, 2.0, false, false, false)
    Wait(1000)
    StopParticleFxLooped(effect, 0)
    Wait(10)
    StopParticleFxLooped(effect2, 0)
end

--[[ CreateThread(function()
	while true do
		Wait(10)
		if QBCore.Functions.GetPlayerData().metadata['clean'] <= 0 then
			LoadDict("switch@trevor@bear_floyds_face_smell")
			TaskPlayAnim(PlayerPedId(), "switch@trevor@bear_floyds_face_smell", "bear_floyds_face_smell_loop_floyd", 8.0, -8.0, 3.0, 0, 0.0, 0, 0, 0)
		end
	end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end ]]