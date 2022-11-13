QBCore = exports['qb-core']:GetCoreObject()

StartAnim = function(lib, anim)
RequestAnimDict(lib)
while not HasAnimDictLoaded(lib) do
    Wait(1)
end
TaskPlayAnim(PlayerPedId(), lib, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
end

local Objects = {
    {
        ["x"] = 399.06744384766,
        ["y"] = -769.93621826172,
        ["z"] = 29.286233901978,
        ["h"] = 69.0,
        ["model"] = "dt1_15_ladder_003"
    }

}

local heath = 0
local vehspawn = nil

local trabalhando = false
local escadaNaMao = false
local escadaNoCarro = true
local escadaNoPoste = false
local foraCarro = true

local executandoServico = false
local servicoConcluido = false

local posteConsertado = {}
tempoConserto = Config.TiempoParaArreglar

local respawn = 0
local segundos = 0
local function DrawText3D(x, y, z, text)
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

CreateThread(function()
    while true do
        sleep = 1000
        local player = PlayerPedId()
        local veh = GetVehiclePedIsIn(player, false)
        local playercoords = GetEntityCoords(player)
        local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(Config.delveh.x,Config.delveh.y,Config.delveh.z))
        if dist <= 8 then
            sleep = 0 
            DrawMarker(2, Config.delveh.x, Config.delveh.y,Config.delveh.z-0.80, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
            if dist <= 3 and veh ~= 0 then
                DrawText3D(Config.delveh.x, Config.delveh.y,Config.delveh.z, '[~b~E~s~] - Cất xe')
                if IsControlJustPressed(1, Config.Keys['E']) then
                        DeleteVehicle(veh)
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local objects = {}
        local sleep = 500
        for k, v in pairs(Config.postes) do table.insert(objects, v.prop) end
        if escadaNaMao or escadaNoPoste then
            sleep = 0
            local ped = GetPlayerPed(-1)
            local list = {}
            for k, v in pairs(objects) do
                local obj = GetClosestObjectOfType(GetEntityCoords(ped).x,
                            GetEntityCoords(ped).y,
                            GetEntityCoords(ped).z, 3.0,
                            GetHashKey(v), false, true, true)
                local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),
                            GetEntityCoords(obj), true)
                table.insert(list, {object = obj, distance = dist})
            end
            local closest = list[1]
            for k, v in pairs(list) do
                if v.distance < closest.distance then closest = v end
            end
            local distance = closest.distance
            local object = closest.object
            if escadaNoPoste and not executandoServico then
                local ob = GetEntityCoords(object).z
                local p = GetEntityCoords(ped).z
                local distancia = p - ob
                if distancia > 5 then
                    sleep = 0
                    DrawText3D(GetEntityCoords(ped).x, GetEntityCoords(ped).y,GetEntityCoords(ped).z + 2, Config.Locales["iniciarrepa"])
                    if IsControlJustPressed(0, 246) then
                        executandoServico = true
                        segundos = tempoConserto
                    end
                        sleep = 5
                end
            end

            if distance < Config.distance and DoesEntityExist(object) and  not posteConsertado[object] then
                sleep = 5
                local ped = PlayerPedId()
                if escadaNaMao then
                    sleep = 0
                    DrawText3D(GetEntityCoords(object).x, GetEntityCoords(object).y, GetEntityCoords(object).z + 2.5, Config.Locales["ponerescalera"])
                elseif escadaNoPoste and servicoConcluido then
                    DrawText3D(GetEntityCoords(object).x,GetEntityCoords(object).y,GetEntityCoords(object).z + 2.5,Config.Locales["sacarescalera"])
                end
                sleep = 5
                if IsControlJustPressed(0, 246) then
                    if not escadaNoPoste and escadaNaMao then
                        escadaNoPoste = true
                        escadaNaMao = false
                        executandoServico = false
                        StartAnim('mini@repair', 'fixing_a_ped')
                        Wait(1000)
                        ClearPedTasks(PlayerPedId())
                        DeleteObject(entity)
                        local HashKey = GetHashKey("hw1_06_ldr_")
                        SpawnObject = CreateObject(HashKey, GetEntityCoords(
                                                       object).x - 0.25,
                                                   GetEntityCoords(object).y,
                                                   GetEntityCoords(object).z)
                        PlaceObjectOnGroundProperly(SpawnObject)
                        SetEntityHeading(SpawnObject, 69.0)
                        FreezeEntityPosition(SpawnObject, true)
                        SetEntityAsMissionEntity(SpawnObject, true, true)
                    elseif escadaNoPoste and not escadaNaMao and
                        servicoConcluido then
                        servicoConcluido = false
                        executandoServico = false
                        escadaNoPoste = false
                        escadaNaMao = true
                        posteConsertado[object] = true

                        StartAnim('mini@repair', 'fixing_a_ped')

                        Wait(1000)
                        DeleteObject(SpawnObject)
                        entity = CreateObject(GetHashKey("prop_byard_ladder01"),
                                              0, 0, 0, true, true, true)
                        StartAnim(
                            'amb@world_human_muscle_free_weights@male@barbell@idle_a',
                            'idle_a')
                        AttachEntityToEntity(entity, PlayerPedId(),
                                             GetPedBoneIndex(PlayerPedId(),
                                                             28422), 0.05, 0.1,
                                             -0.3, 300.0, 100.0, 20.0, true,
                                             true, false, true, 1, true)
                    end
                end
            end
            if segundos > 0 then
                sleep = 0
                drawTxt(Config.Locales["espera"]..segundos.. Config.Locales["tofinish"], 4, 0.5, 19, 0.50, 255, 255, 255, 180)
            end
            sleep = 5
        end
        Wait(sleep)
    end
end)



CreateThread(function()
    while true do
        local objects = {}
        local sleep = 500
        for k, v in pairs(Config.postes) do table.insert(objects, v.prop) end
        if IsControlJustPressed(0, 38) then
            health = GetEntityHealth(PlayerPedId())
            sleep = 5
            local obj = GetClosestObjectOfType(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, 3.0,GetHashKey(objects[1]), false, true, true)
        end
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -825.55084228516, -731.86492919922, 27.074931640625, true)
        if distance <= 5 then
            sleep = 0
            DrawMarker(23, -825.55084228516, -731.86492919922, 27.074931640625,
                       0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 240, 200, 80, 80, 0, 0,
                       0, 0)

            if distance <= 1.2 then
                sleep = 6
                if not trabalhando then
                    DrawText3D(-825.55084228516, -731.86492919922, 28.054931640625 + 1.5, Config.Locales["startjob"])
                    if IsControlJustPressed(0, 38) then
                        sleep = 5
                            trabalhando = true
                            exports['xt-notify']:Alert("HỆ THỐNG", Config.Locales["jobiniciado"], 5000, 'success')
                            ChangeClothes()
                            SetEntityHealth(PlayerPedId(), health)
                            spawnCarJob(Config.Car)
                    end
                else
                    DrawText3D(-825.55084228516, -731.86492919922, 28.054931640625 + 1.5, Config.Locales["endjob"])
                    if IsControlJustPressed(0, 38) then
                        health = GetEntityHealth(PlayerPedId())
                        sleep = 5
                        trabalhando = false
                        GetClothes()
                        SetEntityHealth(PlayerPedId(), health)
                        exports['xt-notify']:Alert("HỆ THỐNG", Config.Locales["jobterminado"], 5000, 'success')
                    end
                end
            end
        end
        if trabalhando and foraCarro() and Perto() then
            sleep = 0
            if IsControlJustPressed(0, 38) then
                sleep = 0
                if not escadaNaMao and escadaNoCarro then
                    sleep = 10
                    escadaNoCarro = false
                    escadaNaMao = true
                    StartAnim('mini@repair', 'fixing_a_ped')
                    Wait(1000)
                    ClearPedTasks(PlayerPedId())
                    entity = CreateObject(GetHashKey("prop_byard_ladder01"), 0,
                                          0, 0, true, true, true)
                    StartAnim(
                        'amb@world_human_muscle_free_weights@male@barbell@idle_a',
                        'idle_a')
                    AttachEntityToEntity(entity, PlayerPedId(),GetPedBoneIndex(PlayerPedId(), 28422),0.05, 0.1, -0.3, 300.0, 100.0, 20.0,true, true, false, true, 1, true)
                else if escadaNaMao and not escadaNoCarro then
                    escadaNoCarro = true
                    escadaNaMao = false
                    StartAnim('mini@repair', 'fixing_a_ped')
                    Wait(1000)
                    ClearPedTasks(PlayerPedId())
                    DeleteObject(entity)
                    else
                        exports['xt-notify']:Alert("HỆ THỐNG", "Không có cầu thang nào. Cần lấy lại cầu thang cũ", 5000, 'success')
                    end
                end
            end
        end
        Wait(sleep)
    end
end)


function foraCarro()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    if (GetPedInVehicleSeat(veh, -1) == ped) then
        return false
    else
        return true
    end
end

RegisterCommand('sb', function ()
    trabalhando = true
end)


function Perto()
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        local vehplate = GetVehicleNumberPlateText(veh)
        local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))


        local vehicle =  QBCore.Functions.GetClosestVehicle(vec3(px, py, pz))
        local model = GetEntityModel(vehicle)
        local vehplate2 = GetVehicleNumberPlateText(vehicle)
        local displaytext = GetDisplayNameFromVehicleModel(model)
        local name = GetLabelText(displaytext)
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),
                                                vehicleCoords.x, vehicleCoords.y,
                                                vehicleCoords.z, true)

        if vehplate2 == vehspawn  and distance < 2.5 then
            if not escadaNaMao then
                DrawText3D(GetEntityCoords(vehicle).x, GetEntityCoords(vehicle).y, GetEntityCoords(vehicle).z + 1.5, Config.Locales["cogerescala"])
            else
                DrawText3D(GetEntityCoords(vehicle).x, GetEntityCoords(vehicle).y,GetEntityCoords(vehicle).z + 1.5, Config.Locales["saveescalera"])
            end

            return true
        else
            return false
        end
end


function DelCar()
    local veh = GetVehiclePedIsIn(ped, false)
    local vehplate = GetVehicleNumberPlateText(veh)
    if vehplate == vehspawn then
    DeleteVehicle(veh)
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Xe không đúng với xe được cấp", 5000, 'error')
    end
end

function ChangeClothes()
        local gender = QBCore.Functions.GetPlayerData().charinfo.gender
        if gender == 0 then
            TriggerEvent('qb-clothing:client:loadOutfit', Config.Uniforms.male)
        else
            TriggerEvent('qb-clothing:client:loadOutfit', Config.Uniforms.female)
        end
end

function GetClothes()
    health = GetEntityHealth(PlayerPedId())
    TriggerServerEvent('qb-clothes:loadPlayerSkin')
    SetPedMaxHealth(PlayerId(), 200)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
    Wait(2500) -- Safety Delay
    SetEntityHealth(PlayerPedId(), health)
end

local function PayForJob(money)
    local can = 'sdafghjrehrw2345dfe' -- Just for cheaters xd
    TriggerServerEvent('xt-nghedien:PayJob', money, can)
end
CreateThread(function()
    while true do
        Wait(1000)
        if segundos > 0 then
            segundos = segundos - 1
            StartAnim('amb@world_human_hammering@male@base', 'base')
            if segundos == 0 then
                ClearPedTasks(PlayerPedId())
                servicoConcluido = true
                PayForJob(Config.Pay)
                exports['xt-notify']:Alert("HỆ THỐNG", "Nhận được "..Config.Pay.."$ tiền sửa chữa", 5000, 'success')
            end
        else
            Wait(1000)
        end
    end
end)



function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function spawnCarJob(car)
        QBCore.Functions.SpawnVehicle(Config.Car, function(veh)
            vehicle = veh
            exports['lj-fuel']:SetFuel(veh, 100.0)
            SetVehicleNumberPlateText(vehicle, Config.Plate..math.random(1000,9999))
            exports['xt-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(veh), true)
            SetEntityHeading(veh, 79.89)
            vehspawn = GetVehicleNumberPlateText(veh)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        end, vector3(-820.5, -748.1, 23.2), true)
end

CreateThread(function()
      local blip = AddBlipForCoord(-826.2,-739.9, 28.1)
      SetBlipSprite(blip, 459)
      SetBlipDisplay(blip, 4)
      SetBlipScale(blip, 0.9)
      SetBlipColour(blip, 59)
      SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Công ty Ánh sáng")
      EndTextCommandSetBlipName(blip)
end)