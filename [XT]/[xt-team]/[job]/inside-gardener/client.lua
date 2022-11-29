QBCore = exports["qb-core"]:GetCoreObject()

local Base = Config.Gardener.Base
local Garage = Config.Gardener.Garage
local Marker = Config.Gardener.DefaultMarker
local GarageSpawnPoint = Config.Gardener.GarageSpawnPoint
local Type = nil
local AmountPayout = 0
local done = 0
local PlayerData = {}
local salary = nil

onDuty = false
hasCar = false
inGarageMenu = false
inMenu = false
wasTalked = false
appointed = false
waitingDone = false
CanWork = false
Paycheck = false

hasOpenDoor = false
hasBlower = false
hasTrimmer = false
hasLawnMower = false
hasBackPack = false

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

-- BASE
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

                if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 8) then
                    sleep = 5
                    DrawMarker(Base.Type, Base.Pos.x, Base.Pos.y, Base.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Base.Size.x, Base.Size.y, Base.Size.z, Base.Color.r, Base.Color.g, Base.Color.b, 100, false, true, 2, false, false, false, false)
                    if (GetDistanceBetweenCoords(coords, Base.Pos.x, Base.Pos.y, Base.Pos.z, true) < 1.2) then
                        if not onDuty then
                            sleep = 5
                            DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, 'Nhấn ~g~[E]~s~ - Để thay đồ và bắt đầu công việc')
                            if IsControlJustPressed(0, Keys["E"]) then
                                local PlayerData = QBCore.Functions.GetPlayerData()
                                QBCore.Functions.Progressbar("thay-do", "Thay đồ", 3000, false, false, {
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
                                        SetPedPropIndex(ped, 0, Config.Clothes.male['hat_1'], Config.Clothes.male['hat_2'], true) -- mũ
                                    else
                                        SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
                                        SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) 
                                        SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0)
                                        SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0)
                                        SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0)
                                        SetPedPropIndex(ped, 0, Config.Clothes.female['hat_1'], Config.Clothes.female['hat_2'], true) -- mũ
                                    end
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bắt đầu làm việc', 5000, 'info')	
                                    onDuty = true
                                    addGarageBlip()
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Để mở bảng công việc, nhấn [DEL]', 5000, 'info')
                                end)    				
                            end
                        elseif onDuty then
                            sleep = 5
                            DrawText3Ds(Base.Pos.x, Base.Pos.y, Base.Pos.z + 0.4, 'Nhấn ~r~[E]~s~ - Để thay đồ và kết thúc công việc')
                            if IsControlJustPressed(0, Keys["E"]) then
                                local health = GetEntityHealth(ped)
                            local maxhealth = GetEntityMaxHealth(ped)
                                            QBCore.Functions.Progressbar("thay-do", "Thay đồ", 3000, false, false, {
                                                disableMovement = true,
                                                disableCarMovement = false,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function() -- Done
                                            TriggerServerEvent("qb-clothes:loadPlayerSkin")
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã hoàn thành công việc', 5000, 'info')
                                            onDuty = false
                                            removeGarageBlip()
                                            SetPedMaxHealth(PlayerId(), maxhealth)
                                            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
                                            SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
                                            Citizen.Wait(3000) -- Safety Delay
                                            SetEntityHealth(PlayerPedId(), health)
                                            end)                   				           
                            end
                        end
                    end
                end
            
        Citizen.Wait(sleep)
        
            end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

                if onDuty then
                    if not inMenu then
                        sleep = 2
                        if IsControlJustPressed(0, Keys["DEL"]) then
                            inMenu = true
                        end
                    elseif inMenu then
                        sleep = 2
                        DrawText3Dss(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Tìm việc | ~r~[8]~s~ - Huỷ')
                        if IsControlJustPressed(0, Keys["DEL"]) then
                            inMenu = false
                        elseif IsControlJustPressed(0, Keys["7"]) then
                            if Type == nil then
                                inMenu = false
                                exports['xt-notify']:Alert("THÔNG BÁO", 'Tìm việc...', 5000, 'info')
                                Citizen.Wait(15000)
                                Gardens = Randomize(Config.Gardens)
                                CreateWork(Gardens.StreetHouse)
                                exports['xt-notify']:Alert("THÔNG BÁO", 'Đã đặt điểm trên GPS! ' ..Gardens.StreetHouse, 5000, 'success')
                                salary = math.random(300, 350)
                                if Type == "Rockford Hills" then
                                    for i, v in ipairs(Config.RockfordHills) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "West Vinewood" then
                                    for i, v in ipairs(Config.WestVinewood) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Vinewood Hills" then
                                    for i, v in ipairs(Config.VinewoodHills) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "El Burro Heights" then
                                    for i, v in ipairs(Config.ElBurroHeights) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Richman" then
                                    for i, v in ipairs(Config.Richman) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "Mirror Park" then
                                    for i, v in ipairs(Config.MirrorPark) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                elseif Type == "East Vinewood" then
                                    for i, v in ipairs(Config.EastVinewood) do
                                        SetNewWaypoint(v.x, v.y, v.z)
                                    end
                                end
                            else
                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đang bận rồi', 5000, 'warning')
                            end
                        elseif IsControlJustPressed(0, Keys["8"]) then
                            if Type then
                                CancelWork()
                                DeleteWaypoint()
                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã huỷ cuộc gặp với khách hàng', 5000, 'error')
                            elseif not Type then
                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn không có cuộc hẹn trước nào', 5000, 'error')
                            end
                        end
                    end
                end

        Citizen.Wait(sleep)
    end
end)

-- GARAGE MENU
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local WLCar = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

                if onDuty then
                    if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 8) then
                        sleep = 5
                        DrawMarker(Marker.Type, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Garage.Size.x, Garage.Size.y, Garage.Size.z, Garage.Color.r, Garage.Color.g, Garage.Color.b, 100, false, true, 2, false, false, false, false)
                        if (GetDistanceBetweenCoords(coords, Garage.Pos.x, Garage.Pos.y, Garage.Pos.z, true) < 1.2) then
                            if IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~r~[E]~s~ - Cất xe')
                                if IsControlJustReleased(0, Keys["E"]) then
                                    local xe = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                                    if GetEntityModel(xe) == GetHashKey(Config.Vehicle) then
                                        QBCore.Functions.TriggerCallback('inside-gardener:server:CheckBail', function(DidBail)
                                            if DidBail then
                                                ReturnVehicle()
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã nhận lại $'..Config.BailPrice..' tiền cọc xe', 5000, 'success')
                                                hasCar = false
                                                Plate = nil
                                            else
                                                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn chưa trả tiền cho phương tiện này", 5000, 'error')
                                            end	  
                                        end)
                                    else
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Đây không phải xe của chúng tôi", 5000, 'error')
                                    end
                                end
                            elseif not IsPedInAnyVehicle(ped, false) then
                                sleep = 5
                                if not inGarageMenu then
                                    DrawText3Ds(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z + 0.4, '~g~[E]~s~ - Mở danh sách')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if not inMenu then
                                            FreezeEntityPosition(ped, true)
                                            inGarageMenu = true
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Chọn vị trí đậu xe', 5000, 'info')
                                        elseif inMenu then
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Đóng', 5000, 'warning')
                                        end
                                    end
                                elseif inGarageMenu then
                                    DrawText3DMenu(Garage.Pos.x - 0.8, Garage.Pos.y, Garage.Pos.z + 0.8, '~g~[7]~s~ - Vị trí đỗ xe #1\n~g~[8]~s~ - Vị trí đỗ xe #2\n~r~[E]~s~ - Đóng')
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        inGarageMenu = false
                                        FreezeEntityPosition(ped, false)
                                    elseif IsControlJustReleased(0, Keys["7"]) then
                                        if not hasCar then
                                            QBCore.Functions.TriggerCallback('inside-gardener:server:HasMoney', function(HasMoney)
                                                if HasMoney then
                                                    QBCore.Functions.SpawnVehicle(Config.CompanyVehicle, function(vehicle)
                                                        SetEntityHeading(vehicle, GarageSpawnPoint.Pos1.h)
                                                        exports['ps-fuel']:SetFuel(vehicle, 100.0)
                                                        SetVehicleNumberPlateText(vehicle, "VUON"..tostring(math.random(1000, 9999)))
                                                        SetVehicleEngineOn(vehicle, true, true)
                                                        SetEntityAsMissionEntity(vehicle, true, true)
                                                        exports['xt-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(vehicle), true)
                                                        exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã trả ' ..Config.BailPrice.. '$ để cọc phương tiện', 5000, 'info')
                                                        hasCar = true
                                                        Plate = GetVehicleNumberPlateText(vehicle)
                                                    end, vector3(GarageSpawnPoint.Pos1.x, GarageSpawnPoint.Pos1.y, GarageSpawnPoint.Pos1.z), true)
                                                        inGarageMenu = false
                                                        FreezeEntityPosition(ped, false)
                                                else
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn không đủ tiền', 5000, 'error')
                                                    inGarageMenu = false
                                                    FreezeEntityPosition(ped, false)
                                                end
                                            end)
                                        elseif hasCar then
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn còn chưa trả xe cũ', 5000, 'error')
                                        end
                                    elseif IsControlJustReleased(0, Keys["8"]) then
                                        if not hasCar then
                                            QBCore.Functions.TriggerCallback('inside-gardener:server:HasMoney', function(HasMoney)
                                            if HasMoney then
                                                QBCore.Functions.SpawnVehicle(Config.CompanyVehicle, function(vehicle)
                                                    SetEntityHeading(vehicle, GarageSpawnPoint.Pos2.h)
                                                    exports['ps-fuel']:SetFuel(vehicle, 100.0)
                                                    SetVehicleNumberPlateText(vehicle, "VUON"..tostring(math.random(1000, 9999)))
                                                    SetVehicleEngineOn(vehicle, true, true)
                                                    SetEntityAsMissionEntity(vehicle, true, true)
                                                    exports['xt-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(vehicle), true)
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã trả ' ..Config.BailPrice.. '$ để cọc phương tiện', 5000, 'info')
                                                    hasCar = true
                                                    Plate = GetVehicleNumberPlateText(vehicle)
                                                end, vector3(GarageSpawnPoint.Pos2.x, GarageSpawnPoint.Pos2.y, GarageSpawnPoint.Pos2.z), true)
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            else
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn không đủ tiền', 5000, 'error')
                                                inGarageMenu = false
                                                FreezeEntityPosition(ped, false)
                                            end
                                            end)
                                        elseif hasCar then
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn còn chưa trả xe cũ', 5000, 'error')
                                        end
                                    end
                                end
                            end
                        end
                    end
            end
        Citizen.Wait(sleep)
    end
end)

-- OPENING VAN DOORS
Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)

            if hasCar then
                if not IsPedInAnyVehicle(ped, false) then
                    if Plate == GetVehicleNumberPlateText(vehicle) then
                        local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.0, 0)
                        if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2) then
                            if not hasOpenDoor then
                                sleep = 5
                                DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.4, "~g~[G]~s~ - Mở cửa")
                                if IsControlJustReleased(0, Keys["G"]) then
                                    QBCore.Functions.Progressbar("mo-cua", "Mở cửa", 3000, false, false, {
                                        disableMovement = true,
                                        disableCarMovement = false,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function() -- Done
                                        SetVehicleDoorOpen(vehicle, 3, false, false)
                                        SetVehicleDoorOpen(vehicle, 2, false, false)
                                        hasOpenDoor = true
                                    end)    			
                                end
                            elseif hasOpenDoor then
                                if not hasBlower and not hasLawnMower and not hasTrimmer and not hasBackPack then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.7, "~g~[E]~s~ - Máy thổi lá | ~g~[H]~s~ Bình nước")
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.5, "~g~[7]~s~ - Kéo tỉa | ~g~[8]~s~ - Máy cắt cỏ")
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.3, "~r~[G]~s~ - Đóng cửa")
                                    if IsControlJustReleased(0, Keys["G"]) then
                                        QBCore.Functions.Progressbar("dong-cua", "Đóng cửa", 3000, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            SetVehicleDoorShut(vehicle, 3, false)
                                            SetVehicleDoorShut(vehicle, 2, false)
                                            hasOpenDoor = false
                                        end)                            
                                     elseif IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("may-thoi", "Lấy máy thổi lá", 3000, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            addLeafBlower()
                                            hasBlower = true
                                        end)
                                    elseif IsControlJustReleased(0, Keys["H"]) then
                                        QBCore.Functions.Progressbar("binh-nuoc", "Lấy bình nước", 3000, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            addBackPack()
                                            hasBackPack = true
                                        end)
                                    elseif IsControlJustReleased(0, Keys["7"]) then
                                        QBCore.Functions.Progressbar("keo", "Lấy kéo", 3000, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            addTrimmer()
                                            hasTrimmer = true
                                        end)
                                    elseif IsControlJustReleased(0, Keys["8"]) then
                                        QBCore.Functions.Progressbar("may-cat", "Lấy máy cắt cỏ", 3000, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            addLawnMower()
                                            hasLawnMower = true
                                        end)
                                    end
                                elseif hasLawnMower or hasBlower or hasBackPack or hasTrimmer then
                                    sleep = 5
                                    DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.5, "Nhấn ~g~[E]~s~ -Để cất dụng cụ vào trong cốp xe")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        QBCore.Functions.Progressbar("cat-do", "Cất dụng cụ vào cốp", 3000, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            removeLawnMower()
                                            removeBackPack()
                                            removeLeafBlower()
                                            removeTrimmer()
                                            hasLawnMower = false
                                            hasBlower = false
                                            hasTrimmer = false
                                            hasBackPack = false
                                            ClearPedTasks(ped)
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do

        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

            if Type == 'Rockford Hills' then
                for i, v in ipairs(Config.RockfordHills) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Chào bạn.Tôi cần dọn khu vườn.Tôi sẽ trả bạn ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Quất luôn | ~r~[8]~s~ - Bèo quá')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Hãy dọn sạch khu vườn của khách hàng', 5000, 'info')
                                    BlipsWorkingRH()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Thế tôi sẽ tìm người khác vậy!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Thật tuyệt! Khi nào làm xong hãy tới trước cổng tìm tôi")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bạn còn chưa xong việc mà")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bây giờ khu vườn trông thật tuyệt, đây là tiền công của bạn")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Lấy tiền')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn nhận được ' ..salary.. '$!', 5000, 'info')
                                                RequestAnimDict("mp_common")
                                                while (not HasAnimDictLoaded("mp_common")) do
                                                    Citizen.Wait(7)
                                                end                                               
                                                TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                RequestAnimDict("mp_common")
                                                while (not HasAnimDictLoaded("mp_common")) do
                                                    Citizen.Wait(7)
                                                end 
                                                TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.RockfordHillsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Nhổ cỏ")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        RequestAnimDict("amb@world_human_gardener_plant@male@enter")
                                        while (not HasAnimDictLoaded("amb@world_human_gardener_plant@male@enter")) do
                                            Citizen.Wait(7)
                                        end                                        
                                        TaskPlayAnim(ped, 'amb@world_human_gardener_plant@male@enter', 'enter', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        QBCore.Functions.Progressbar("cat-co", "Nhổ cỏ", 3500, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            ClearPedTasks(ped)
                                            if done == #Config.RockfordHillsWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Khu vườn đã được dọn sạch, hãy đi nhận tiền công', 5000, 'info')
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "West Vinewood" then
                for i, v in ipairs(Config.WestVinewood) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Chào bạn, bạn có muốn trồng cây cho tôi với giá ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Tất nhiên | ~r~[8]~s~ - Thôi tôi mệt lắm')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Trồng cây ven đường lái xe!', 5000, 'info')
                                    BlipsWorkingWV()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Thôi đươc rồi, để tôi tự làm còn hơn!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Tôi sẽ chờ bạn ở hồ bơi")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bạn sắp trồng xong chưa?")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bây giờ thì chờ cây lớn nữa thôi, đây là tiền công của bạn!")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Nhận tiền')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn nhận được ' ..salary.. '$!', 5000, 'info')
                                                RequestAnimDict("mp_common")
                                                while (not HasAnimDictLoaded("mp_common")) do
                                                    Citizen.Wait(7)
                                                end 
                                                TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                RequestAnimDict("mp_common")
                                                while (not HasAnimDictLoaded("mp_common")) do
                                                    Citizen.Wait(7)
                                                end 
                                                TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.WestVinewoodWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Trồng cây")
                                    if IsControlJustReleased(0, Keys["E"]) then  
                                        LoadDict("amb@medic@standing@kneel@base")
                                        LoadDict("amb@prop_human_bum_bin@idle_a")
                                        TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
                                        TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_a", "idle_a", 8.0, -8.0, -1, 2, 0, false, false, false)
                                        QBCore.Functions.Progressbar("trong-cay", "Trồng cây", 5500, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.WestVinewoodWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Đã trồng xong, hãy đi nhận tiền công', 5000, 'info')
                                            end
                                        end)               
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Vinewood Hills" then
                for i, v in ipairs(Config.VinewoodHills) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Chào buổi sáng, có muốn kiếm ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Rất sẵn lòng | ~r~[8]~s~ - Không đâu')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Thổi lá ra khỏi thân cây và khu vườn', 5000, 'info')
                                    BlipsWorkingVH()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Tránh ra!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Tôi sẽ chờ ở trên sân thượng")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bạn chưa thổi hết lá")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Tốt lắm, cầm lấy tiền công đi cưng")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Nhận tiền')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasBlower then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn nhận được ' ..salary.. '$!', 5000, 'info')
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end 
                                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end 
                                                    TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasBlower then
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bỏ máy thôi lá và trong cốp', 5000, 'info')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.VinewoodHillsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Thổi hết lá")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasBlower then
                                                RequestAnimDict("amb@world_human_gardener_leaf_blower@idle_a")
                                                while (not HasAnimDictLoaded("amb@world_human_gardener_leaf_blower@idle_a")) do
                                                    Citizen.Wait(7)
                                                end 
                                                TaskPlayAnim(ped, 'amb@world_human_gardener_leaf_blower@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                            QBCore.Functions.Progressbar("thoi-la", "Thổi lá", 5500, false, false, {
                                                disableMovement = true,
                                                disableCarMovement = false,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function() -- Done
                                                ClearPedTasks(ped)
                                                v.taked = true
                                                RemoveBlip(v.blip)
                                                done = done + 1
                                                if done == #Config.VinewoodHillsWork then
                                                    Paycheck = true
                                                    done = 0
                                                    AmountPayout = AmountPayout + 1
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Lá rơi đã được dọn sạch, hãy nhận tiền công từ khách hàng', 5000, 'info')
                                                end
                                            end)
                                        elseif not hasBlower then
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn không có máy thổi lá', 5000, 'warning')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "El Burro Heights" then
                for i, v in ipairs(Config.ElBurroHeights) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Này, có muốn kiếm ít tiền không ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Ồ có chứ | ~r~[8]~s~ - Nah,không đâu')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Hãy nhổ hết cỏ trong sân', 5000, 'info')
                                    BlipsWorkingEBH()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Biến đi!")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Khi xong việc hãy báo cho tôi ...")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Sắp xong chưa!")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bạn làm tốt lắm, tiền công của bạn đây")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Nhận tiền')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn nhận được ' ..salary.. '$!', 5000, 'info')
                                                RequestAnimDict("mp_common")
                                                while (not HasAnimDictLoaded("mp_common")) do
                                                    Citizen.Wait(7)
                                                end 
                                                TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                RequestAnimDict("mp_common")
                                                while (not HasAnimDictLoaded("mp_common")) do
                                                    Citizen.Wait(7)
                                                end 
                                                TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                Citizen.Wait(3500)
                                                ClearPedTasks(ped)
                                                CancelWork()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.ElBurroHeightsWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Nhổ cỏ")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        RequestAnimDict("amb@world_human_gardener_plant@male@idle_a")
                                        while (not HasAnimDictLoaded("amb@world_human_gardener_plant@male@idle_a")) do
                                            Citizen.Wait(7)
                                        end 
                                        TaskPlayAnim(ped, 'amb@world_human_gardener_plant@male@idle_a', 'idle_c', 8.0, -8.0, -1, 2, 0, false, false, false)
                                        QBCore.Functions.Progressbar("nho-co", "Nhổ cỏ", 5500, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            ClearPedTasks(ped)
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.ElBurroHeightsWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã nhổ hết cỏ!', 5000, 'info')
                                            end
                                        end)              
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Richman" then
                for i, v in ipairs(Config.Richman) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, 'Chào buổi sáng, đi kiếm tí tiền không ~g~' ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[7]~s~ - Quất luôn | ~r~[8]~s~ - Tôi bận quá')
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Lấy kéo tỉa lại hàng rào', 5000, 'info')
                                    BlipsWorkingRM()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Không có gì, chúc ngày mới tốt lành")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Tôi sẽ đợi ở cửa")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bạn chưa tỉa hết")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Đây là tiền công của bạn đây, bạn thật tuyệt vời!")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - nhận tiền')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasTrimmer then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn nhận được ' ..salary.. '$', 5000, 'info')
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end 
                                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end
                                                    TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasTrimmer then
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Cất kéo tỉa vào cốp', 5000, 'info')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.RichmanWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Tỉa hàng rào")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasTrimmer then
                                            RequestAnimDict("anim@mp_radio@garage@high")
                                            while (not HasAnimDictLoaded("anim@mp_radio@garage@high")) do
                                                Citizen.Wait(7)
                                            end
                                            TaskPlayAnim(ped, 'anim@mp_radio@garage@high', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                            QBCore.Functions.Progressbar("hang-rao", "Tỉa hàng rào", 5500, false, false, {
                                                disableMovement = true,
                                                disableCarMovement = false,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function() -- Done
                                                ClearPedTasks(ped)
                                                v.taked = true
                                                RemoveBlip(v.blip)
                                                done = done + 1
                                                if done == #Config.RichmanWork then
                                                    Paycheck = true
                                                    done = 0
                                                    AmountPayout = AmountPayout + 1
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Công việc hoàn thành, hãy đi nhận tiền công', 5000, 'info')
                                                end
                                            end)           
                                        elseif not hasTrimmer then
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn không có kéo tỉa', 5000, 'warning')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "Mirror Park" then
                for i, v in ipairs(Config.MirrorPark) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Chào, bạn có muốn nhận cắt cỏ với giá ~g~" ..salary.. '$~s~?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[7]~s~ - Ổn đấy | ~r~[8]~s~ - Tôi bận rồi không rảnh đâu")
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Cắt cỏ trong sân cho khách hàng', 5000, 'info')
                                    BlipsWorkingMP()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Hmm, may mà trong thành phố còn nhiều người làm vườn")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Hãy đến nhận lương khi bạn cắt xong nhé")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Bạn chưa cắt xong hết cỏ")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Khu vườn giờ đây trông thật tuyệt, đây là tiền công như đã hứa ")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Nhận tiền')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasLawnMower then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bãi cỏ đã được cắt, đi nhận tiền thôi nào', 5000, 'info')
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end
                                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)                                                   
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end
                                                    TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasLawnMower then
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Cất máy cắt cỏ vào cốp', 5000, 'info')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.MirrorParkWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Cắt cỏ")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasLawnMower then
                                            v.taked = true
                                            RemoveBlip(v.blip)
                                            done = done + 1
                                            if done == #Config.MirrorParkWork then
                                                Paycheck = true
                                                done = 0
                                                AmountPayout = AmountPayout + 1
                                                exports['xt-notify']:Alert("THÔNG BÁO", 'Bãi cỏ đã hoàn thiện, đây là tiền công', 5000, 'info')
                                            end
                                        elseif not hasLawnMower then
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn không có máy cắt cỏ', 5000, 'warning')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif Type == "East Vinewood" then
                for i, v in ipairs(Config.EastVinewood) do
                    local coordsNPC = GetEntityCoords(v.ped, false)
                    sleep = 5
                    if not IsPedInAnyVehicle(ped, false) then
                        if not wasTalked then
                            if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Nhận tưới cây để lấy ~g~" ..salary.. '$~s~ tiền không?')
                                DrawText3Ds(coords.x, coords.y, coords.z + 1.0, "~g~[7]~s~ - Thú vị đấy | ~r~[8]~s~ - Không đâu chán lắm")
                                if IsControlJustReleased(0, Keys["7"]) then
                                    wasTalked = true
                                    appointed = true
                                    CanWork = true
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Lấy bình đựng nước ra khỏi cốp và bắt đầu tưới cây thôi', 5000, 'info')
                                    BlipsWorkingEV()
                                elseif IsControlJustReleased(0, Keys["8"]) then
                                    wasTalked = true
                                    appointed = false
                                    FreezeEntityPosition(v.ped, false)
                                    TaskGoToCoordAnyMeans(v.ped, v.houseX, v.houseY, v.houseZ, 1.3)
                                end
                            end
                        elseif wasTalked then
                            if not appointed then
                                if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 3.5) then
                                    DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Tưới cây thôi cũng không được, tự thấy xấu hổ đi")
                                elseif (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                    CancelWork()
                                end
                            elseif appointed then
                                if not waitingDone then
                                    if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                        DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.05, "Hãy quay lại nhận tiền công khi đã hoàn thành")
                                    end
                                    if (GetDistanceBetweenCoords(coordsNPC, v.houseX, v.houseY, v.houseZ, true) < 0.35) then
                                        ClearPedTasksImmediately(v.ped)
                                        FreezeEntityPosition(v.ped, true)
                                        SetEntityCoords(v.ped, v.houseX, v.houseY, v.houseZ - 1.0)
                                        SetEntityHeading(v.ped, v.houseH)
                                        waitingDone = true
                                    end
                                elseif waitingDone then
                                    if not Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 2.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Đã tưới hết đâu")
                                        end
                                    elseif Paycheck then
                                        if (GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
                                            DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 0.95, "Đám cây sẽ lớn nhanh thôi... Tiền công đây")
                                            DrawText3Ds(coords.x, coords.y, coords.z + 1.0, '~g~[E]~s~ - Nhận tiền')
                                            if IsControlJustReleased(0, Keys["E"]) then
                                                if not hasBackPack then
                                                    TaskTurnPedToFaceEntity(v.ped, ped, 0.2)
                                                    TriggerServerEvent('inside-gardener:Payout', salary, AmountPayout)
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn nhận được ' ..salary.. '$', 5000, 'info')
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end
                                                    TaskPlayAnim(ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    RequestAnimDict("mp_common")
                                                    while (not HasAnimDictLoaded("mp_common")) do
                                                        Citizen.Wait(7)
                                                    end
                                                    TaskPlayAnim(v.ped, 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                                    Citizen.Wait(3500)
                                                    ClearPedTasks(ped)
                                                    CancelWork()
                                                elseif hasBackPack then
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Cất bình phun nước vào cốp xe', 5000, 'info')
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if CanWork then
                    for i, v in ipairs(Config.EastVinewoodWork) do
                        if not v.taked then
                            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 8) then
                                sleep = 5
                                DrawMarker(Marker.Type, v.x, v.y, v.z - 0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Color.r, Marker.Color.g, Marker.Color.b, 100, false, true, 2, false, false, false, false)
                                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
                                    sleep = 5
                                    DrawText3Ds(v.x, v.y, v.z + 0.4, "~g~[E]~s~ - Tưới cây")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        if hasBackPack then
                                            RequestAnimDict("missarmenian3_gardener")
                                            while (not HasAnimDictLoaded("missarmenian3_gardener")) do
                                                Citizen.Wait(7)
                                            end
                                            TaskPlayAnim(ped, 'missarmenian3_gardener', 'blower_idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                                            QBCore.Functions.Progressbar("tuoi-cay", "Tưới cây", 5500, false, false, {
                                                disableMovement = true,
                                                disableCarMovement = false,
                                                disableMouse = false,
                                                disableCombat = true,
                                            }, {}, {}, {}, function() -- Done
                                                ClearPedTasks(ped)
                                                v.taked = true
                                                RemoveBlip(v.blip)
                                                done = done + 1
                                                if done == #Config.EastVinewoodWork then
                                                    Paycheck = true
                                                    done = 0
                                                    AmountPayout = AmountPayout + 1
                                                    exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã xong việc, tới lúc lấy tiền công rồi', 5000, 'info')
                                                end
                                            end)                                 
                                        elseif not hasBackPack then
                                            exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn không có bình đựng nước', 5000, 'warning')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        Citizen.Wait(sleep)
    end
end)

function CreateWork(type)

    if type == "Rockford Hills" then
        for i, v in ipairs(Config.RockfordHills) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Chỗ làm')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "West Vinewood" then
        for i, v in ipairs(Config.WestVinewood) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Chỗ làm')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Vinewood Hills" then
        for i, v in ipairs(Config.VinewoodHills) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Chỗ làm')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "El Burro Heights" then
        for i, v in ipairs(Config.ElBurroHeights) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Chỗ làm')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Richman" then
        for i, v in ipairs(Config.Richman) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Chỗ làm')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "Mirror Park" then
        for i, v in ipairs(Config.MirrorPark) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Chỗ làm')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    elseif type == "East Vinewood" then
        for i, v in ipairs(Config.EastVinewood) do
            v.blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(v.blip, 205)
            SetBlipColour(v.blip, 43)
            SetBlipScale(v.blip, 0.5)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Chỗ làm')
            EndTextCommandSetBlipName(v.blip)

            local ped_hash = GetHashKey(Config.NPC['Peds'][math.random(1,#Config.NPC['Peds'])].ped)
            RequestModel(ped_hash)
            while not HasModelLoaded(ped_hash) do
                Citizen.Wait(1)
            end
            v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.96, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(v.ped, true)
            SetPedDiesWhenInjured(v.ped, false)
            SetPedCanPlayAmbientAnims(v.ped, true)
            SetPedCanRagdollFromPlayerImpact(v.ped, false)
            SetEntityInvincible(v.ped, true)
            FreezeEntityPosition(v.ped, true)
        end
    end
    Type = type
end

function CancelWork()

    if Type == "Rockford Hills" then
        for i, v in ipairs(Config.RockfordHills) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.RockfordHillsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "West Vinewood" then
        for i, v in ipairs(Config.WestVinewood) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.WestVinewoodWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Vinewood Hills" then
        for i, v in ipairs(Config.VinewoodHills) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.VinewoodHillsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "El Burro Heights" then
        for i, v in ipairs(Config.ElBurroHeights) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.ElBurroHeightsWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Richman" then
        for i, v in ipairs(Config.Richman) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.RichmanWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "Mirror Park" then
        for i, v in ipairs(Config.MirrorPark) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.MirrorParkWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    elseif Type == "East Vinewood" then
        for i, v in ipairs(Config.EastVinewood) do
            RemoveBlip(v.blip)
            DeletePed(v.ped)
        end
        for i, v in ipairs(Config.EastVinewoodWork) do
            v.taked = false
            RemoveBlip(v.blip)
        end
    end
    Type = nil
    appointed = false
    wasTalked = false
    waitingDone = false
    CanWork = false
    Paycheck = false
    salary = nil
    AmountPayout = 0
    done = 0
end

function BlipsWorkingRH()
    for i, v in ipairs(Config.RockfordHillsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Làm vườn] Cỏ')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingWV()
    for i, v in ipairs(Config.WestVinewoodWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Làm vườn] Cây')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingVH()
    for i, v in ipairs(Config.VinewoodHillsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Làm vườn] Lá')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingEBH()
    for i, v in ipairs(Config.ElBurroHeightsWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Làm vườn] Cỏ')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingRM()
    for i, v in ipairs(Config.RichmanWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Làm vườn] Hàng rào')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingMP()
    for i, v in ipairs(Config.MirrorParkWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Làm vườn] Nhổ cỏ')
        EndTextCommandSetBlipName(v.blip)
    end
end

function BlipsWorkingEV()
    for i, v in ipairs(Config.EastVinewoodWork) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 1)
        SetBlipColour(v.blip, 24)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('[Làm vườn] Tưới nước')
        EndTextCommandSetBlipName(v.blip)
    end
end

function addBackPack()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    backpack = CreateObject(GetHashKey('prop_spray_backpack_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(backpack, ped, GetPedBoneIndex(ped, 56604), 0.0, -0.12, 0.28, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function removeBackPack()
    local ped = PlayerPedId()

    DeleteEntity(backpack)
end

function addLawnMower()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
        Citizen.Wait(7)
    end
    TaskPlayAnim(ped, "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
    lawnmower = CreateObject(GetHashKey('prop_lawnmower_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(lawnmower, ped, GetPedBoneIndex(ped, 56604), -0.05, 1.0, -0.85, 0.0, 0.0, 180.0, true, true, false, true, 1, true)
end

function removeLawnMower()
    local ped = PlayerPedId()

    DeleteEntity(lawnmower)
end

function addTrimmer()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    trimmer = CreateObject(GetHashKey('prop_hedge_trimmer_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(trimmer, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.02, 0.01, -121.0, 181.0, 187.0, true, true, false, true, 1, true)
end

function removeTrimmer()
    local ped = PlayerPedId()

    DeleteEntity(trimmer)
end

function addLeafBlower()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    leafblower = CreateObject(GetHashKey('prop_leaf_blower_01'), coords.x, coords.y, coords.z,  true,  true, true)
    AttachEntityToEntity(leafblower, ped, GetPedBoneIndex(ped, 57005), 0.14, 0.02, 0.0, -40.0, -40.0, 0.0, true, true, false, true, 1, true)
end

function removeLeafBlower()
    local ped = PlayerPedId()

    DeleteEntity(leafblower)
end

-- RETURNING VEHICLE
function ReturnVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    QBCore.Functions.DeleteVehicle(vehicle)
end

-- MAIN BLIP
Citizen.CreateThread(function()
    baseBlip = AddBlipForCoord(Base.Pos.x, Base.Pos.y, Base.Pos.z)
    SetBlipSprite(baseBlip, Base.BlipSprite)
    SetBlipDisplay(baseBlip, 4)
    SetBlipScale(baseBlip, Base.BlipScale)
    SetBlipAsShortRange(baseBlip, true)
    SetBlipColour(baseBlip, Base.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Base.BlipLabel)
    EndTextCommandSetBlipName(baseBlip)
end)

-- ADDING GARAGES BLIPS
function addGarageBlip()
    garageBlip = AddBlipForCoord(Garage.Pos.x, Garage.Pos.y, Garage.Pos.z)
    SetBlipSprite(garageBlip, Garage.BlipSprite)
    SetBlipDisplay(garageBlip, 4)
    SetBlipScale(garageBlip, Garage.BlipScale)
    SetBlipAsShortRange(garageBlip, true)
    SetBlipColour(garageBlip, Garage.BlipColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Garage.BlipLabel)
    EndTextCommandSetBlipName(garageBlip)
end

-- REMOVING GARAGES BLIPS
function removeGarageBlip()
    RemoveBlip(garageBlip)
end

function DrawText3Ds(x, y, z, text)
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

function DrawText3DMenu(x, y, z, text)
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
    DrawRect(0.0, 0.02+0.0125, -0.14+ factor, 0.08, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3Dss(x, y, z, text)
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
    DrawRect(0.0, 0.0+0.0125, 0.008+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function LoadDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end