QBCore = exports['qb-core']:GetCoreObject()
local MissionMarker1 =  vector3(-163.7, 156.12, 77.51)
local dealerCoords1 =  vector3(-164.79, 156.47, 77.66)
local MissionMarker2 =  vector3(1121.03, -3197.1, -40.4)
local dealerCoords2 =  vector3(1121.34, -3197.76, -40.39)
local dealer, laodai
local Plate = nil
local layxe, ganxetai, delivering, coxe, vuarua
local CurrentCops = 0
local blip1
local NPC
local Robbing = false
-- thread
local function RequestAnimationDict(AnimDict)
    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Wait(0)
    end
end
local function OpenDoorAnim()
    local ped = PlayerPedId()
    RequestAnimationDict('anim@heists@keycard@')
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Wait(400)
    ClearPedTasks(ped)
end
local function EnterTrapHouse()
    local ped = PlayerPedId()
    TriggerEvent("InteractSound_CL:PlayOnOne", "houses_door_open", 0.1)
    OpenDoorAnim()
    Wait(350)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    local coords = Config.CuaRa
    SetEntityCoords(ped, coords.x, coords.y, coords.z, 0, 0, 0, false)
    SetEntityHeading(ped, coords.w)
    Wait(100)
    DoScreenFadeIn(1000)
end
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

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local plyCoords = GetEntityCoords(ped, false)
        local dist = #(plyCoords - vector3(MissionMarker1.x, MissionMarker1.y, MissionMarker1.z))
		if dist <= 25.0  then
			if not DoesEntityExist(dealer) then
                RequestModel("s_m_y_dealer_01")
                while not HasModelLoaded("s_m_y_dealer_01") do
                    Wait(10)
                end
                dealer = CreatePed(26, "s_m_y_dealer_01", dealerCoords1.x, dealerCoords1.y, dealerCoords1.z - 1, 249.71, false, false)
                SetEntityHeading(dealer, 249.71)
                FreezeEntityPosition(dealer, true)
                SetEntityInvincible(dealer, true)
                SetBlockingOfNonTemporaryEvents(dealer, true)
                TaskStartScenarioInPlace(dealer, "WORLD_HUMAN_AA_SMOKE", 0, false)
	        end
		else
			Wait(1500)
		end
        if dist <= 5.0 then
			DrawText3D(dealerCoords1.x, dealerCoords1.y, MissionMarker1.z + 1, "~r~ZANG HỒ")
            exports['qb-target']:AddCircleZone("Traphouse", vector3(-164.79, 156.47, 77.66), 2.0, {
                name="Traphouse",
                debugPoly=false,
                useZ=true,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "xt-traphouse:client:enter",
                            icon = "fas fa-file-invoice-dollar",
                            label = "Vào nhà kho",
                        },
                    },
                distance = 2.0
            })
        end
	end
end)
CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local plyCoords = GetEntityCoords(ped, false)
        local dist = #(plyCoords - vector3(MissionMarker2.x, MissionMarker2.y, MissionMarker2.z))
		if dist <= 25.0  then
			if not DoesEntityExist(laodai) then
                RequestModel("a_m_m_mlcrisis_01")
                while not HasModelLoaded("a_m_m_mlcrisis_01") do
                    Wait(10)
                end
                laodai = CreatePed(26, "a_m_m_mlcrisis_01", dealerCoords2.x, dealerCoords2.y, dealerCoords2.z - 1, 34.82, false, false)
                SetEntityHeading(laodai, 34.82)
                FreezeEntityPosition(laodai, true)
                SetEntityInvincible(laodai, true)
                SetBlockingOfNonTemporaryEvents(laodai, true)
                TaskStartScenarioInPlace(laodai, "WORLD_HUMAN_AA_SMOKE", 0, false)
	        end
		else
			Wait(1500)
		end
        if dist <= 5.0 then
			DrawText3D(dealerCoords2.x, dealerCoords2.y, MissionMarker2.z + 1, "~r~LÃO ĐẠI")
            exports['qb-target']:AddCircleZone("Laodai", vector3(1121.34, -3197.76, -40.39), 2.0, {
                name="Laodai",
                debugPoly=false,
                useZ=true,
                }, {
                    options = {
                        {
                            type = "client",
                            event = "xt-traphouse:client:muadomenu",
                            icon = "fas fa-file-invoice-dollar",
                            label = "Mua đồ",
                        },
                        {
                            type = "client",
                            event = "xt-traphouse:client:bandomenu",
                            icon = "fas fa-file-invoice-dollar",
                            label = "Bán đồ",
                        },
                        {
                            type = "client",
                            event = "xt-traphouse:checktien",
                            icon = "fas fa-truck",
                            label = "Lấy xe chở tiền",
                        },
                    },
                distance = 2.0
            })
        end
	end
end)
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        sleep = 1000
            local dist1 = #(pos - vector3(Config.CuaRa.x, Config.CuaRa.y, Config.CuaRa.z))
            if dist1 < 1.5 then
                sleep = 3
                DrawText3D(Config.CuaRa.x, Config.CuaRa.y, Config.CuaRa.z, "[~g~E~w~] - Ra ngoài")
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("InteractSound_CL:PlayOnOne", "houses_door_open", 0.1)
                    OpenDoorAnim()
                    DoScreenFadeOut(500)
                    while not IsScreenFadedOut() do
                        Wait(10)
                    end
                    local coords1 = Config.CuaVao
                    SetEntityCoords(ped, coords1.x, coords1.y, coords1.z, 0, 0, 0, false)
                    SetEntityHeading(ped, coords1.w)
                    Wait(100)
                    DoScreenFadeIn(1000)
                    TriggerEvent("InteractSound_CL:PlayOnOne", "houses_door_close", 0.1)
                end
            end
        Wait(sleep)
    end
end)
CreateThread(function()
    while true do
        if coxe == true then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
            sleep = 5
            local dist = #(pos - vector3(Config.Xe.x, Config.Xe.y, Config.Xe.z))
            if dist < 1.5 then
                if InVehicle then
                    DrawText3D(Config.Xe.x, Config.Xe.y, Config.Xe.z, '~g~[E]~w~ - Trả xe')
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
                                    DeleteEntity(xechotien)
                                    RemoveBlip(blip2)
                                    SetBlipRoute(blip2, false)
                                    coxe = false
                                end)
                            else
                                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ngồi ở vị trí tài xế", 3000, 'error')
                            end
                        else
                            exports['xt-notify']:Alert("THÔNG BÁO", 'Đây không phải xe bạn thuê', 5000, 'error')
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
local cuop = vector3(-122.48, 138.09, 78.18)
CreateThread(function()
    while true do
        sleep = 5
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Distance = GetDistanceBetweenCoords(PlayerCoords, cuop.x, cuop.y, cuop.z, true)
            local AimingWeapon, TargetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
            if Distance <= 250.0 then
                if IsPedArmed(PlayerPedId(), 1) or IsPedArmed(PlayerPedId(), 4) then
                    if AimingWeapon then
                        local NpcCoords = GetEntityCoords(TargetPed)
                        local NpcDistance = GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, NpcCoords.x, NpcCoords.y, NpcCoords.z, true)
                        if NpcDistance < 2 then
                            if LastRobbedNpc ~= TargetPed then
                                if not Robbing then
                                    if not IsEntityDead(TargetPed) then
                                        if IsPedInAnyVehicle(TargetPed) then
                                            TaskLeaveVehicle(TargetPed, GetVehiclePedIsIn(TargetPed), 1)
                                        end
                                        Wait(500)
                                        SetEveryoneIgnorePlayer(PlayerId(), true)
                                        TaskStandStill(TargetPed, 5 * 1000)
                                        FreezeEntityPosition(TargetPed, true)
                                        SetBlockingOfNonTemporaryEvents(TargetPed, true)
                                        NPC = TargetPed
                                        RequestAnimationDict("random@mugging3")
                                        TaskPlayAnim(TargetPed, 'random@mugging3', 'handsup_standing_base', 2.0, -2, 15.0, 1, 0, 0, 0, 0)
                                        for i = 1, 5 / 2, 1 do
                                            PlayAmbientSpeech1(TargetPed, "GUN_BEG", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                                            Wait(2000)
                                        end
                                        exports['qb-target']:AddCircleZone("CuopNPC", NpcCoords, 2.0, {
                                            name="CuopNPC",
                                            debugPoly=false,
                                            useZ=true,
                                            }, {
                                                options = {
                                                    {
                                                        type = "client",
                                                        event = "xt-traphouse:client:cuopNPC",
                                                        icon = "fas fa-file-invoice-dollar",
                                                        label = "Cướp",
                                                    },
                                                },
                                            distance = 2.0
                                        })
                                    end
                                end
                            end
                        end
                    else
                        sleep =150
                    end
                end
            else
                sleep = 1500
            end
        Wait(sleep)
        end
end)

-- Event
RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)
local location
RegisterNetEvent('xt-traphouse:client:cuopNPC', function()
    if not Robbing then
        FreezeEntityPosition(NPC, false)
        SetEveryoneIgnorePlayer(PlayerId(), false)
        SetBlockingOfNonTemporaryEvents(NPC, false)
        ClearPedTasks(NPC)
        AddShockingEventAtPosition(99, GetEntityCoords(NPC), 0.5)
        TriggerServerEvent('xt-traphouse:server:cuopNPC')
        LastRobbedNpc = NPC
        NPC = nil
        Robbing = true
        SetTimeout(60000, function()
            Robbing = false
        end)
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Đừng có tham lam vậy chứ?", 3000, 'error')
    end
end)
local function Delivery(location)
    CreateThread(function()
		while delivering do
            local
            sleep = 5
            local player = GetPlayerPed(-1)
			playerpos = GetEntityCoords(player)
			local disttocoord1 = #(vector3(location.coords.x, location.coords.y, location.coords.z) - vector3(playerpos.x,playerpos.y,playerpos.z))
            if disttocoord1 <= 15 then
				DrawText3D(location.coords.x,location.coords.y,location.coords.z, '~g~[E]~w~ - Để rửa tiền')
				if IsControlJustPressed(1, 51) then
                    local Vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                    local driver = GetPedInVehicleSeat(Vehicle, -1)
                    if driver == PlayerPedId() then
                        FreezeEntityPosition(xechotien, true)
                        QBCore.Functions.Progressbar("picking_", "Rửa tiền", 20000, false, false, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            delivering = false
                            FreezeEntityPosition(xechotien, false)
                            TriggerEvent('xt-traphouse:client:ruatien')
                            Laydiem()
                        end)
                    else
                        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ngồi ở vị trí tài xế", 3000, 'error')
                    end
				end
			else
				sleep = 1500
			end
			Wait(sleep)
        end
    end)
end
local function Laydiem()
    if blip2 ~= nil then
        RemoveBlip(blip2)
        SetBlipRoute(blip2, false)
    end
    Wait(500)
    rand = math.random(1,#Config.Locations)
    if rand == vuarua then
        Laydiem()
    else
        location = Config.Locations[rand]
        vuarua = rand
        blip2 = AddBlipForCoord(location.coords.x, location.coords.y, location.coords.z)
        SetBlipRoute(blip2, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Điểm rửa tiền')
        exports['xt-notify']:Alert("ÔNG TRÙM", "Lái xe đến điểm đánh dấu để rửa tiền", 5000, 'success')
        EndTextCommandSetBlipName(blip2)
        delivering = true
        Delivery(location)
    end
end
local function Layxe()
    if DoesEntityExist(xechotien) then
	    SetVehicleHasBeenOwnedByPlayer(xechotien,false)
		SetEntityAsNoLongerNeeded(xechotien)
		DeleteEntity(xechotien)
	end
    local maxe = GetHashKey("brickade")
    RequestModel(maxe)
    while not HasModelLoaded(maxe) do
        Wait(0)
    end
    ganxetai = true
    local xechotien = CreateVehicle(maxe, Config.Xe.x, Config.Xe.y, Config.Xe.z, 100, true, false)
	SetVehicleHasBeenOwnedByPlayer(xechotien,true)
 	SetEntityHeading(xechotien, Config.Xe.w)
    SetVehicleNumberPlateText(xechotien, "RUTI"..tostring(math.random(0000, 9999)))
	Plate = GetVehicleNumberPlateText(xechotien)
    exports['xt-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(xechotien), true)
    exports['ps-fuel']:SetFuel(xechotien, 100.0)
    CreateThread(function()
		while ganxetai do
			sleep = 5
			local player = GetPlayerPed(-1)
			playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(Config.Xe.x,Config.Xe.y,Config.Xe.z) - vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord <= 5 then
                RemoveBlip(blip1)
                SetBlipRoute(blip1, false)
                ganxetai= false
                Laydiem()
			else
				sleep = 1500
			end
			Wait(sleep)
		end
	end)
end
local function Main()
    layxe = true
    coxe = true
    exports['xt-notify']:Alert("ÔNG TRÙM", "Hãy lại lấy xe trên bản đồ", 5000, 'success')
    blip1 = AddBlipForCoord(Config.Xe.x, Config.Xe.y, Config.Xe.z)
	SetBlipRoute(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Xe tải')
    EndTextCommandSetBlipName(blip1)
    CreateThread(function()
		while layxe do
			sleep = 5
			local player = GetPlayerPed(-1)
			local playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(Config.Xe.x, Config.Xe.y, Config.Xe.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord <= 50 then
				Layxe()
                layxe = false
			else
				sleep = 1500
			end
			Wait(sleep)
		end
	end)
end
RegisterNetEvent('xt-traphouse:checktien', function()
    if CurrentCops >= Config.PoliceNeeded then
        QBCore.Functions.TriggerCallback('xt-traphouse:pay', function(success)
            if success then
                Main()
            end
        end)
    else
        exports['xt-notify']:Alert("ÔNG TRÙM", "Không đủ cảnh sát (Cần "..Config.PoliceNeeded.." cảnh sát)", 5000, 'error')
    end
end)
RegisterNetEvent('xt-traphouse:client:ruatien', function()
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerServerEvent('xt-traphouse:server:ruatien')
        else
            exports['xt-notify']:Alert("ÔNG TRÙM", "Bạn không đủ "..QBCore.Shared.Items['tienban'].label, 5000, 'error')
        end
    end, 'tienban')
end)
RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    SetTimeout(1000, function()
        QBCore.Functions.TriggerCallback("xt-traphouse:server:get:config", function(config)
            Config = config
        end)
    end)
end)
RegisterNetEvent('xt-traphouse:client:enter', function()
    QBCore.Functions.TriggerCallback('xt-traphouse:server:pin:code', function(Code)
        exports['xt-notify']:Alert("THÔNG BÁO", "Mã con lợn là gì?", 5000, 'warning')
        SetTimeout(450, function()
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'atm',
                pin = Code,
            })
        end)
    end)
end)

RegisterNetEvent('xt-traphouse:client:bandomenu',function()
    local Menu = {
        {
            header = "BÁN ĐỒ",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.SellItems) do
        Menu[#Menu+1] = {
            header = QBCore.Shared.Items[v.name].label,
            txt = "Giá thu mua: " ..v.ban.." "..QBCore.Shared.Items['tienban'].label,
            params = {
                event = "xt-traphouse:client:bando",
                args = {
                    name = v.name,
                    gia = v.ban,
                }
            }
        }
        Menu[#Menu+1] = {
            header = "< Đóng",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
        exports['qb-menu']:openMenu(Menu)
    end
end)
RegisterNetEvent('xt-traphouse:client:bando',function(data)
    local name = data.name
    local gia = data.gia
    local soluong = exports['qb-input']:ShowInput({
        header = "Nhập số lượng muốn bán",
        submitText = "Xác nhận",
        inputs = {
            {
                text = "Số lượng",
                name = "charge",
                type = "number",
                isRequired = true
            }
        }
    })
    if soluong then
        if not soluong.charge then return
        elseif tonumber(soluong['charge']) > 0 then
            local soluong = tonumber(soluong['charge'])
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    TriggerServerEvent('xt-traphouse:server:bando', name, gia, soluong)
                else
                    exports['xt-notify']:Alert("ÔNG TRÙM", "Bạn không đủ "..QBCore.Shared.Items[name].label, 5000, 'error')
                end
            end, name, soluong)
        else
            TriggerEvent('xt-traphouse:client:bandomenu')
        end
    end
end)

RegisterNetEvent('xt-traphouse:client:muadomenu',function()
    local Menu = {
        {
            header = "MUA ĐỒ",
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.BuyItems) do
        Menu[#Menu+1] = {
            header = QBCore.Shared.Items[v.name].label,
                    txt = "Giá bán: " ..v.mua.." "..QBCore.Shared.Items['tienban'].label,
                    params = {
                        event = "xt-traphouse:client:muado",
                        args = {
                            name = v.name,
                            gia = v.mua,
                        }
                    }
        }
        Menu[#Menu+1] = {
            header = "< Đóng",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
        exports['qb-menu']:openMenu(Menu)
    end
end)
RegisterNetEvent('xt-traphouse:client:muado',function(data)
    local name = data.name
    local gia = data.gia
    local soluong = exports['qb-input']:ShowInput({
        header = "Nhập số lượng muốn bán",
        submitText = "Xác nhận",
        inputs = {
            {
                text = "Số lượng",
                name = "charge",
                type = "number",
                isRequired = true
            }
        }
    })
    if soluong then
        if not soluong.charge then return
        elseif tonumber(soluong['charge']) > 0 then
            local ton = tonumber(soluong['charge']) * gia
            local soluong = tonumber(soluong['charge'])
            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                if result then
                    print(soluong)
                    TriggerServerEvent('xt-traphouse:server:muado', name, ton, soluong)
                else
                    exports['xt-notify']:Alert("ÔNG TRÙM", "Bạn không đủ "..QBCore.Shared.Items['tienban'].label, 5000, 'error')
                end
            end, 'tienban', ton)
        else
            TriggerEvent('xt-traphouse:client:muadomenu')
        end
    end
end)
-- NUI
RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isBankOpened = false
		SetNuiFocus(false, false)
    elseif data.action == "atm" then
		SetNuiFocus(false, false)
		EnterTrapHouse()
    elseif data.action == "sai" then
        exports['xt-notify']:Alert("ZANG HỒ", "Mày là cớm hả?", 5000, 'error')
    end
end)
-- function









