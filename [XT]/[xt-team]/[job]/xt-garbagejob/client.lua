QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}
local Plate = nil
local sleep = 0
local duty, layxe = false, false
local xerac
local blip, blipgara = nil, nil
local location= nil
local Zone = {}
local people = 0
local nhom = 0
local garbagebag
local camrac = false
local danhat = 0
local boss = false
local landau = true
local NPC
-- Function
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
    ClearDrawOrigin()
end

local function Laydiem(id)
    if nhom == id then
        location = Config.Collections[Zone[math.random(#Zone)]]

        exports['xt-notify']:Alert("HỆ THỐNG", "Hãy đi tới "..location.name.." để dọn đẹp", 5000, 'info')
            exports['qb-target']:AddTargetModel(Config.Bins, {
                options = {
                    {
                        event = "xt-garbagejob:client:boiRac",
                        icon = "fas fa-dumpster",
                        label = "Nhặt rác",
                    },

                },
                distance = 1.0
            })
        TriggerServerEvent('xt-garbagejob:server:taonhom', id, location)
        blip = AddBlipForCoord(location.pos.x, location.pos.y, location.pos.z)
        SetBlipRoute(blip, true)
        SetBlipSprite(blip, 11)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        BeginTextCommandSetBlipName("STRING")
        if landau == false then
            TriggerServerEvent('xt-garbagejob:server:capnhat', id)
        end
    end
end

local function getVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

local function hasTrash()
    camrac = true
    CreateThread(function()
        local ped = PlayerPedId()
        while hasTrash do
            sleep = 5
            if camrac then
                local truck = GetOffsetFromEntityInWorldCoords(xerac, 0.0, -4.5, 0.0)
                DrawText3D(truck.x, truck.y, truck.z, "~b~Đứng đây để ném rác")
                if IsControlJustReleased(0,38) and IsPedOnFoot(ped) then
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    if IsAnyVehicleNearPoint(coords, 9.0) then
                        local coordA = GetEntityCoords(playerPed, 1)
                        local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
                        xerac = getVehicleInDirection(coordA, coordB)
                        local boot = GetEntityBoneIndexByName(xerac ,'boot')
                        local bootDst = GetWorldPositionOfEntityBone(xerac ,boot)
                        local dst = #(GetEntityCoords(PlayerPedId()) - bootDst)
                        if dst < 3.0 and GetVehicleDoorAngleRatio(xerac ,5) ~= 0 and IsVehicleModel(xerac ,'trash2') then
                            if DoesEntityExist(garbagebag) and danhat < Config.TrashAmt then
                                TriggerServerEvent('xt-garbagejob:server:nemrac', nhom)
                                DeleteEntity(garbagebag)
                                camrac = false
                            end
                        elseif dst < 3.0 and GetVehicleDoorAngleRatio(xerac ,5) == 0 and IsVehicleModel(xerac ,'trash2') then
                            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn cần mở thùng xe", 5000, 'error')
                        elseif dst >= 3.0 and GetVehicleDoorAngleRatio(xerac ,5) == 0 and IsVehicleModel(xerac ,'trash2') then
                            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn đứng quá xa", 5000, 'error')
                        end
                    end
                end
            else
                sleep = 1500
            end
            Wait(sleep)
        end
    end)
end
local function Layxe()
    if DoesEntityExist(xerac) then
	    SetVehicleHasBeenOwnedByPlayer(xerac,false)
		SetEntityAsNoLongerNeeded(xerac)
		DeleteEntity(xerac)
	end
    local maxe = GetHashKey("trash2")
    RequestModel(maxe)
    while not HasModelLoaded(maxe) do
        Citizen.Wait(0)
    end
    xerac = CreateVehicle(maxe, Config.Xe.x, Config.Xe.y, Config.Xe.z, 100, true, false)
    layxe = true
	SetVehicleHasBeenOwnedByPlayer(xerac,true)
 	SetEntityHeading(xerac, Config.Xe.w)
     if nhom <=9 then
        SetVehicleNumberPlateText(xerac, 'XERA000'..nhom)
    elseif nhom <=99 then
        SetVehicleNumberPlateText(xerac, 'XERA00'..nhom)
    elseif nhom <=999 then
        SetVehicleNumberPlateText(xerac, 'XERA0'..nhom)
    else
        SetVehicleNumberPlateText(xerac, 'XERA'..nhom)
    end
	Plate = GetVehicleNumberPlateText(xerac)
    TaskWarpPedIntoVehicle(PlayerPedId(), xerac, -1)
    exports['xt-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(xerac), true)
    exports['ps-fuel']:SetFuel(xerac, 100.0)
end

-- Thread
CreateThread(function()
    while true do
        sleep = 5
        local plyCoords = GetEntityCoords(PlayerPedId(), false)
        local dist = #(plyCoords - vector3(Config.Locations.coords.x, Config.Locations.coords.y, Config.Locations.coords.z))
        if dist <= 100.0  then
            if dist <= 10.0  then
                DrawText3D(Config.Locations.coords.x, Config.Locations.coords.y, Config.Locations.coords.z + 1, "~b~CÔNG NHÂN")
                exports['qb-target']:AddCircleZone("Vsmt", vector3(-321.87, -1545.87, 31.0), 2.0, {
                    name="Vsmt",
                    debugPoly=false,
                    useZ=true,
                    }, {
                        options = {
                            {
                                type = "client",
                                event = "xt-garbagejob:client:nhanviec",
                                icon = "fas fa-dumpster",
                                label = "Nhận việc/ Nghỉ việc",
                            },
                            {
                                type = "client",
                                event = "xt-garbagejob:client:layxe",
                                icon = "fas fa-truck-pickup",
                                label = "Lấy xe rác",
                            },
                            {
                                type = "server",
                                action = function(entity)
                                    TriggerServerEvent('xt-garbagejob:server:nhom')
                                end,
                                icon = "fas fa-user",
                                label = "Tạo nhóm",
                            },
                                {
                                    type = "client",
                                    action = function(entity)
                                        TriggerEvent('xt-garbagejob:client:moi')
                                    end,
                                    icon = "fas fa-user",
                                    label = "Mời thành viên",
                                },
                                {
                                    type = "client",
                                    action = function(entity)
                                        TriggerEvent('xt-garbagejob:client:roinhom')
                                    end,
                                    icon = "fas fa-user",
                                    label = "Rời nhóm",
                                },
                            },
                        distance = 2.0
                    })
                else
                    sleep = 1500
                end
        else
            sleep = 1500
        end
        Wait(sleep)
	end
end)
CreateThread(function ()
    blipgara = AddBlipForCoord(-321.77,-1545.84,30.02)
    SetBlipSprite(blipgara, 318)
    SetBlipDisplay(blipgara, 4)
    SetBlipScale(blipgara, 0.8)
    SetBlipColour(blipgara, 39)
    SetBlipAsShortRange(blipgara, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Công ty vệ sinh môi trường")
    EndTextCommandSetBlipName(blipgara)
    while true do
        sleep = 5
        local plyCoords = GetEntityCoords(PlayerPedId(), false)
        local dist = #(plyCoords - vector3(Config.Locations.coords.x, Config.Locations.coords.y, Config.Locations.coords.z))
        if dist <= 100.0  then
            if not DoesEntityExist(NPC) then
                RequestModel("s_m_y_garbage")
                while not HasModelLoaded("s_m_y_garbage") do
                    Wait(10)
                end
                TriggerEvent('xt-garbagejob:client:NPC')
            else
                sleep = 1500
            end
        else
            sleep = 1500
        end
        Wait(sleep)
    end
end)
Citizen.CreateThread(function()
    while true do
        if layxe == true then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
            sleep = 5
            local dist = #(pos - vector3(Config.Xe.x, Config.Xe.y, Config.Xe.z))
            if dist < 5 then
                if InVehicle then
                    DrawText3D(Config.Xe.x, Config.Xe.y, Config.Xe.z, '[~g~E~w~] - Trả xe')
                    if IsControlJustPressed(1, 51) then
                        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                        if GetVehicleNumberPlateText(vehicle) == Plate then
                            local Vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                            local driver = GetPedInVehicleSeat(Vehicle, -1)
                            if driver == PlayerPedId() then
                                QBCore.Functions.Progressbar("cat_xe", "Trả xe", 5000, false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    DeleteEntity(xerac)
                                    TriggerServerEvent('xt-garbagejob:server:tracoc')
                                    layxe = false
                                end)
                            else
                                exports['xt-notify']:Alert("HỆ THỐNG", "Bạn phải ngồi ở vị trí tài xế", 5000, 'error')
                            end
                        else
                            exports['xt-notify']:Alert("HỆ THỐNG", 'Đây không phải xe bạn thuê', 5000, 'error')
                        end
                    end
                end
            end
        else
            sleep = 1500
        end
        Wait(sleep)
    end
end)
CreateThread(function()
    for k in pairs(Config.Collections) do
        Zone[#Zone+1] = k
    end
end)
-- Event
RegisterNetEvent('xt-garbagejob:client:NPC', function()
    local hash = `s_m_y_garbage`
    NPC = CreatePed(5, hash, vector3(Config.Locations.coords.x, Config.Locations.coords.y, Config.Locations.coords.z - 1), Config.Locations.coords.w, false, false)
    FreezeEntityPosition(NPC, true)
    SetEntityInvincible(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    SetModelAsNoLongerNeeded(hash)
    TaskStartScenarioInPlace(NPC,'WORLD_HUMAN_HANG_OUT_STREET')
end)
RegisterNetEvent('xt-garbagejob:client:nhanviec',function()
    local ped = PlayerPedId()
    if not duty then
        local PlayerData = QBCore.Functions.GetPlayerData()
            QBCore.Functions.Progressbar("thay-dp", "Thay đồng phục", 3000, false, false, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                if PlayerData.charinfo.gender == 0 then
                    SetPedComponentVariation(ped, 3, Config.Clothes.male['arms'], 0, 0) --tay
                    SetPedComponentVariation(ped, 8, Config.Clothes.male['tshirt_1'], Config.Clothes.male['tshirt_2'], 0) --áo trong
                    SetPedComponentVariation(ped, 11, Config.Clothes.male['torso_1'], Config.Clothes.male['torso_2'], 0) --áo ngoài
                    SetPedComponentVariation(ped, 4, Config.Clothes.male['pants_1'], Config.Clothes.male['pants_2'], 0) -- quần
                    SetPedComponentVariation(ped, 6, Config.Clothes.male['shoes_1'], Config.Clothes.male['shoes_2'], 0) --giày
                else
                    SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
                    SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) 
                    SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0)
                    SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0)
                    SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0)
                end
                duty = true
                exports['xt-notify']:Alert("HỆ THỐNG", "Cùng làm sạch Thành phố nào", 5000, 'success')
            end)
    else
        local health = GetEntityHealth(ped)
        local maxhealth = GetEntityMaxHealth(ped)
        QBCore.Functions.Progressbar("thay-do", "Thay đồ", 3000, false, false, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
            }, {}, {}, {}, function() -- Done
            TriggerServerEvent("qb-clothes:loadPlayerSkin")
            duty = false
            RemoveBlip(blip)
            SetBlipRoute(blip, false)
            TriggerEvent('xt-garbagejob:client:matnguoi', nhom)
            nhom = 0
            people = 0
            boss = false
            location= nil
            exports['qb-target']:RemoveTargetModel(Config.Bins, 'Nhặt rác')
            exports['xt-notify']:Alert("HỆ THỐNG", "Mai lại đến nhé!", 5000, 'success')
        end)
        SetPedMaxHealth(PlayerId(), maxhealth)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
        Citizen.Wait(3000) -- Safety Delay
        SetEntityHealth(PlayerPedId(), health)
        RemoveBlip(thungrac)
        SetBlipRoute(thungrac, false)
    end
end)
RegisterNetEvent('xt-garbagejob:client:layxe', function()
    if duty then
        if nhom ~= 0 then
            QBCore.Functions.TriggerCallback('xt-garbagejob:pay', function(success)
                if success then
                    Layxe()
                    exports['xt-notify']:Alert("HỆ THỐNG", "Bạn đã thuê xe rác", 5000, 'success')
                end
            end)
        else
            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn chưa có nhóm", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn phải đi nhận việc đã", 5000, 'error')
    end
end)
RegisterNetEvent('xt-garbagejob:client:taonhom', function(sonhom)
    if nhom == 0 then
        if duty then
            people = 1
            boss = true
            nhom = sonhom
            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn đã tạo nhóm "..nhom, 5000, 'success')
            Laydiem(nhom)
            landau = true
        else
            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn phải đi nhận việc đã", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn đã có nhóm rồi", 5000, 'error')
    end
end)

RegisterNetEvent('xt-garbagejob:client:boiRac',function()
    if duty then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - vector3(location.pos.x, location.pos.y, location.pos.z))
        if dist < 5 then
            local dumpster
            for i = 1, #Config.Bins do
                dumpster = GetClosestObjectOfType(pos.x,pos.y,pos.z, 1.5, Config.Bins[i], true, false, false)
                if dumpster ~= 0 then
                    if DoesEntityExist(garbagebag) then
                        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn không thể cầm thêm rác", 5000, 'error')
                    else
                        garbagebag = CreateObject(`hei_prop_heist_binbag`, 0, 0, 0, true, true, true)
                        AttachEntityToEntity(garbagebag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand\
                        hasTrash()
                    end
                end
            end
        else
            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn cần ở "..location.name, 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn phải đi nhận việc đã", 5000, 'error')
    end
end)

RegisterNetEvent('xt-garbagejob:client:moi', function()
    if nhom ~= 0 then
        if people < 4 then
            QBCore.Functions.GetPlayerData(function(PlayerData)
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local closestPlayer, playerDistance = QBCore.Functions.GetClosestPlayer()
                target = GetPlayerServerId(closestPlayer)
                if closestPlayer ~= -1 and playerDistance <= 3.0 then
                    exports['okokRequests']:requestMenu(target, 5000, "LỜI MỜI", PlayerData.charinfo.firstname.." "..PlayerData.charinfo.lastname.." mời bạn tham gia nhóm", 'xt-garbagejob:server:check', 'server', nhom  ,1)
                else
                    exports['xt-notify']:Alert("HỆ THỐNG", "Không có ai ở gần bạn", 5000, 'error')
                end
            end)
        else
            exports['xt-notify']:Alert("HỆ THỐNG", "Nhóm bạn đã đủ 4 thành viên", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn chưa có nhóm", 5000, 'error')
    end
end)
RegisterNetEvent('xt-garbagejob:client:thanhvien',function(ten, ID)
    if nhom == ID then
        people = people + 1
        exports['xt-notify']:Alert("HỆ THỐNG", ten.." đã tham gia vào nhóm", 5000, 'success')
    end
end)
RegisterNetEvent('xt-garbagejob:client:check',function(ID)
    if nhom ~= 0 then
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn đã có nhóm rồi", 5000, 'error')
    else
        TriggerServerEvent('xt-garbagejob:server:thamgia', ID)
    end
end)
RegisterNetEvent('xt-garbagejob:client:thamgia',function(ID , zone)
    nhom = ID
    exports['xt-notify']:Alert("HỆ THỐNG", "Bạn đã vào nhóm "..nhom, 5000, 'success')
    location = zone
    exports['qb-target']:AddTargetModel(Config.Bins, {
        options = {
            {
                event = "xt-garbagejob:client:boiRac",
                icon = "fas fa-dumpster",
                label = "Nhặt rác",
            },
        },
        distance = 1.0
    })
end)
RegisterNetEvent('xt-garbagejob:client:capnhat',function(ID , zone)
    if nhom == ID then
        location = zone
        exports['qb-target']:AddTargetModel(Config.Bins, {
            options = {
                {
                    event = "xt-garbagejob:client:boiRac",
                    icon = "fas fa-dumpster",
                    label = "Nhặt rác",
                },
            },
            distance = 1.0
        })
    end
end)

RegisterNetEvent('xt-garbagejob:client:nemrac',function(ID)
    if nhom == ID then
        danhat = danhat + 1
        local con = (Config.TrashAmt - danhat)
        exports['xt-notify']:Alert("HỆ THỐNG", "Còn "..con.."/" ..Config.TrashAmt.." túi rác", 5000, 'info')
        if danhat == Config.TrashAmt then
            danhat = 0
            RemoveBlip(blip)
            SetBlipRoute(blip, false)
            landau = false
            Wait(10)
            if boss then
                Laydiem(ID)
            end
        end
    end
end)
RegisterNetEvent('xt-garbagejob:client:layluong',function()
    if boss then
        if nhom ~= 0 then
            TriggerServerEvent('xt-garbagejob:server:nhanluong', nhom, people)
        else
            exports['xt-notify']:Alert("HỆ THỐNG", "Không làm mà đòi có ăn à?", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn không phải trưởng nhóm", 5000, 'error')
    end
end)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TriggerEvent('xt-garbagejob:client:matnguoi', nhom)
end)
RegisterNetEvent('xt-garbagejob:client:roinhom', function()
    if nhom ~= 0 and not boss then
        TriggerEvent('xt-garbagejob:client:matnguoi', nhom)
        nhom = 0
        people = 0
        location = nil
    elseif nhom == 0 then
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn không có nhóm nào cả", 5000, 'error')
    else
        exports['xt-notify']:Alert("HỆ THỐNG", "Bạn là trưởng nhóm không thể rời nhóm", 5000, 'error')
    end
end)
RegisterNetEvent('xt-garbagejob:client:matnguoi',function(ID)
    if nhom == ID then
        people = people - 1
    end
end)




