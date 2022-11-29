QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}
local inUse = false
local CurrentCops = 0
local inUse = false
local location = nil
local enroute
local ganmaybay
local sanbay
local delivering
local hangar
local pilot
local airplane
local planehash
local blip1
local blip2
local blip3
local Plate = nil
deathTime = 0
-- thread
local ongtrum
local pedcoords = Config.Ped
CreateThread(function()
    while true do
        sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local ongtrumped = "csb_tomcasino"
                local dist = #(pos - vector3(pedcoords.x, pedcoords.y, pedcoords.z))
                if dist <= 25.0  then
                    sleep = 5
                    if not DoesEntityExist(ongtrum) then
                        RequestModel(ongtrumped)
                    while not HasModelLoaded(ongtrumped) do
                        Wait(10)
                    end
                    ongtrum = CreatePed(26, ongtrumped, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.w, false, false)
                    SetEntityHeading(ongtrum, pedcoords.w)
                    FreezeEntityPosition(ongtrum, true)
                    SetEntityInvincible(ongtrum, true)
                    SetBlockingOfNonTemporaryEvents(ongtrum, true)
                    TaskStartScenarioInPlace(ongtrum, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, false)
                    end
                else
                    sleep = 1500
                end
                if dist <= 5.0 then
                    DrawText3D(pedcoords.x, pedcoords.y, pedcoords.z + 1.9, "~r~ÔNG TRÙM")
                end
    Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        QBCore.Functions.TriggerCallback('xt-coke:startcoords', function(servercoords)
            coord = servercoords
        end)
	end
end)
local function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
      Wait(0)
    end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
local function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

--[[ CreateThread(function()
    while true do
		Wait(30 * 60000)
		print('xt-coke') -- debug
		TriggerServerEvent('xt-coke:updateTable', false)
	end
end) ]]

CreateThread(function()
	while true do
		Wait(0)
		if startCountDown then
			deathTime = Config.RunTime
			Timer()
		elseif not startCountDown then
			deathTime = 0
		end
	end
end)
CreateThread(function()
    while true do
        Wait(4)
            local player = GetPlayerPed(-1)
            local pos = GetEntityCoords(player)
            local NearAnything = false
            local danglam = false
            local dist = #(pos - vector3(Config.DongGoi.x, Config.DongGoi.y, Config.DongGoi.z))
                if dist < 2 and not danglam then
                    NearAnything = true
                        DrawText3D(Config.DongGoi.x, Config.DongGoi.y, Config.DongGoi.z, '[~g~E~s~] - Đóng gói')
                        DrawMarker(25, Config.DongGoi.x, Config.DongGoi.y, Config.DongGoi.z-0.90, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
                        if IsControlJustPressed(0, 38) and NearAnything then
                            if CurrentCops >= Config.PoliceNeeded then
                                local docan = {'coke_brick', 'plastic-bag'}
                                local thoigianlam = math.random(8000, 12000)
                                QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                    if result then
	                                    playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", thoigianlam)
                                        danglam = true
                                        QBCore.Functions.Progressbar("dong-goi", "Đóng gói", thoigianlam, false, false, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                            disableAll = true,
                                        }, {}, {}, {}, function() -- Done
                                            TriggerServerEvent('xt-coke:server:donggoi')
                                            danglam = false
                                        end)
                                    else
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ nguyên liệu (Cần "..QBCore.Shared.Items['coke_brick'].label.." và "..QBCore.Shared.Items['plastic-bag'].label, 5000, 'error')
                                    end
                                end, docan)
                            else
                                exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ cảnh sát (Cần "..Config.PoliceNeeded.." cảnh sát)", 5000, 'error')
                            end
                        end
                else
                    NearAnything = false
                end
            if not NearAnything then
                Wait(2500)
            end
        end
end)
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        sleep = 1000
            local dist = #(pos - vector3(Config.CuaVao.x, Config.CuaVao.y, Config.CuaVao.z))
            if dist < 1.5 then
                sleep = 3
                DrawText3D(Config.CuaVao.x, Config.CuaVao.y, Config.CuaVao.z, "[~g~E~w~] - Vào phòng thí nghiệm")
                if IsControlJustReleased(0, 38) then
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
            end

            local dist1 = #(pos - vector3(Config.CuaRa.x, Config.CuaRa.y, Config.CuaRa.z))
            if dist1 < 1.5 then
                sleep = 3
                DrawText3D(Config.CuaRa.x, Config.CuaRa.y, Config.CuaRa.z, "[~g~E~w~] - Ra ngoài")
                if IsControlJustReleased(0, 38) then
                    DoScreenFadeOut(500)
                    while not IsScreenFadedOut() do
                        Wait(10)
                    end
                    local coords1 = Config.CuaVao
                    SetEntityCoords(ped, coords1.x, coords1.y, coords1.z, 0, 0, 0, false)
                    SetEntityHeading(ped, coords1.w)
                    Wait(100)
                    DoScreenFadeIn(1000)
                end
            end
        Wait(sleep)
    end
end)
-- event

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

RegisterNetEvent('xt-xt-coke:syncTable', function(bool)
    inUse = bool
end)

RegisterNetEvent('xt-coke:checktien')
AddEventHandler('xt-coke:checktien', function()
    if CurrentCops >= Config.PoliceNeeded then
        if not inUse then
            QBCore.Functions.TriggerCallback('xt-coke:pay', function(success)
                if success then
                    Main()
                end
            end)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Có ai đó đang dùng vận chuyển rồi", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Không đủ cảnh sát (Cần "..Config.PoliceNeeded.." cảnh sát)", 5000, 'error')
    end
end)

-- function
DrawText3D = function(x, y, z, text)
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

function Main()
	playAnim("gestures@f@standing@casual", "gesture_point", 3000)
	Wait(2000)
	TriggerServerEvent('xt-coke:updateTable', true)
    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã thuê máy bay", 5000, 'success')
	rand = math.random(1,#Config.locations)
	location = Config.locations[1]
	blip1 = AddBlipForCoord(location.parking.x, location.parking.y, location.parking.z)
	SetBlipRoute(blip1, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Máy bay')
    EndTextCommandSetBlipName(blip1)
	enroute = true
 	CreateThread(function()
		while enroute do
			sleep = 5
			local player = GetPlayerPed(-1)
			playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(location.parking.x,location.parking.y,location.parking.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord <= 50 then
				PlaneSpawn(location)
                enroute = false
			else
				sleep = 1500
			end
			Wait(sleep)
		end
	end)
end
function PlaneSpawn(location)
	if DoesEntityExist(airplane) then
	    SetVehicleHasBeenOwnedByPlayer(airplane,false)
		SetEntityAsNoLongerNeeded(airplane)
		DeleteEntity(airplane)
	end
	local planehash = GetHashKey("dodo")
    RequestModel(planehash)
    while not HasModelLoaded(planehash) do
        Wait(0)
    end
    airplane = CreateVehicle(planehash, location.parking.x, location.parking.y, location.parking.z, 100, true, false)
	SetVehicleHasBeenOwnedByPlayer(airplane,true)
 	SetEntityHeading(airplane, location.parking.h)
	Plate = GetVehicleNumberPlateText(airplane)
    exports['xt-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(airplane), true)
    exports['ps-fuel']:SetFuel(airplane, 100.0)
    ganmaybay = true
 	CreateThread(function()
		while ganmaybay do
			sleep = 5
			local player = GetPlayerPed(-1)
			playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(location.parking.x,location.parking.y,location.parking.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord <= 5 then
                RemoveBlip(blip1)
                SetBlipRoute(blip1, false)
                blip2 = AddBlipForCoord(location.delivery.x, location.delivery.y, location.delivery.z)
                SetBlipRoute(blip2, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('Điểm lấy hàng')
                EndTextCommandSetBlipName(blip2)
                delivering = true
                Delivery()
                ganmaybay = false
			else
				sleep = 1500
			end
			Wait(sleep)
		end
	end)
    while true do
    	Wait(1)
		if startCountDown == true then
			DrawText3D(location.parking.x, location.parking.y, location.parking.z, "Máy bay vận chuyển Coke")
			if #(GetEntityCoords(PlayerPedId()) - vector3(location.parking.x, location.parking.y, location.parking.z)) < 8.0 then
				return
			end
		end
	end
end
deathTime = Config.RunTime
secs = 60

function Timer()
    while true do
        Wait(1000)
        deathTime = deathTime - 1
        if deathTime < 0 then
            break
        end
		if deathTime ~= 0 then
            if secs ~= 0 then
                secs = secs - 1
            else
                secs = 60
                secs = secs - 1
            end
		end
            if deathTime == 0  then
            secs = 0
		end
    end
end

function Delivery()
	local pickup = GetHashKey("hei_prop_hei_drug_case")
	RequestModel(pickup)
	while not HasModelLoaded(pickup) do
		Wait(0)
	end
	local pickupSpawn = CreateObject(pickup, location.delivery.x,location.delivery.y,location.delivery.z, true, true, true)
	FreezeEntityPosition(pickupSpawn, true)
	local player = GetPlayerPed(-1)
	CreateThread(function()
		while delivering do
			sleep = 5
			local playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(location.delivery.x,location.delivery.y,location.delivery.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord <= 15 then
				RemoveBlip(blip)
				SetBlipRoute(blip, false)
				DrawText3D(location.delivery.x,location.delivery.y,location.delivery.z-1, 'Nhấn ~g~[E]~w~ - Nhặt gói hàng')
				if IsControlJustPressed(1, 51) then
                    local Vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                    local driver = GetPedInVehicleSeat(Vehicle, -1)
                    if driver == PlayerPedId() then                  
                        FreezeEntityPosition(airplane, true)
                        QBCore.Functions.Progressbar("picking_", "Nhặt gói hàng", 20000, false, false, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            delivering = false
                            DeleteEntity(pickupSpawn)
                            FreezeEntityPosition(airplane, false)
                            Wait(2000)
                            exports['xt-notify']:Alert("THÔNG BÁO", "Đã nhận được hàng, hãy quay lại sân bay", 5000, 'success')
                            sanbay = true
                            Final()
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
	startCountDown = true
    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    while startCountDown do
	drawTxt('~o~Thời gian lấy gói hàng còn lại:~s~ ~r~' ..deathTime.. "~s~ Giây ",4,0.5,0.93,0.50,255,255,255,180)
        local ped = GetPlayerPed(-1)
        Wait(1)	
        if deathTime == 1 then
            DeleteEntity(airplane)
            SetEntityCoords(PlayerPedId(), lastPlayerCoords)
            startCountDown = false
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã quá chậm, gói hàng đã bị người khác cướp mất", 5000, 'error')
			TriggerServerEvent('xt-coke:updateTable', false)
            RemoveBlip(blip2)
            SetBlipRoute(blip2, false)
            RemoveBlip(blip3)
            SetBlipRoute(blip3, false)
            DeleteEntity(pickupSpawn)
            delivering = false
			break
        end
    end
end

function Final()
    RemoveBlip(blip2)
    SetBlipRoute(blip2, false)
    blip3 = AddBlipForCoord(location.hangar.x,location.hangar.y,location.hangar.z)
    SetBlipRoute(blip3, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Sân bay')
    EndTextCommandSetBlipName(blip3)
    CreateThread(function()
        while sanbay do
            local player = GetPlayerPed(-1)
			playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(location.hangar.x,location.hangar.y,location.hangar.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if disttocoord <= 20 then
                sleep = 5
                RemoveBlip(blip3)
                SetBlipRoute(blip3, false)
                sanbay = false
			else
				sleep = 1500
			end

            Wait(sleep)
		end
	end)
	hangar = true
	local player = GetPlayerPed(-1)
	CreateThread(function()
		while hangar do
			sleep = 5
			local playerpos = GetEntityCoords(player)
			local disttocoord = #(vector3(location.hangar.x,location.hangar.y,location.hangar.z)-vector3(playerpos.x,playerpos.y,playerpos.z))
			if IsPedInAnyPlane(GetPlayerPed(-1)) and disttocoord <= 10 then
				RemoveBlip(blip)
				SetBlipRoute(blip, false)
				DrawText3D(location.hangar.x,location.hangar.y,location.hangar.z-1, 'Nhấn ~g~[E]~w~ - Cất máy bay')
                layhang = false
				DrawMarker(27, location.hangar.x,location.hangar.y,location.hangar.z-0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 3, 252, 152, 100, false, true, 2, false, false, false, false)
				if IsControlJustPressed(1, 51) then
                    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                    if GetVehicleNumberPlateText(vehicle) == Plate then
                        local Vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                        local driver = GetPedInVehicleSeat(Vehicle, -1)
                        if driver == PlayerPedId() then
                            hangar = false
                            FreezeEntityPosition(airplane, true)
                            QBCore.Functions.Progressbar("lockpick_vehicledoor", "Cất máy bay", 5000, false, false, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                DeleteEntity(airplane)
                            end)
                            startCountDown = false
                            Wait(2000)
                            TriggerServerEvent('xt-coke:server:reward')
                            if deathTime ~= 0 then
                                deathTime = 0
                            end
                            TaskLeaveVehicle(player, airplane, 0)
                            SetVehicleDoorsLocked(airplane, 2)
                            Wait(1000)
                            TriggerServerEvent('xt-coke:updateTable', false)
                        else
                            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ngồi ở vị trí tài xế", 3000, 'error')
                        end
                    else
                        exports['xt-notify']:Alert("THÔNG BÁO", 'Đây không phải máy bay bạn thuê', 5000, 'error')
                    end
				end
			else
				sleep = 1500
			end
			Wait(sleep)
		end
	end)
end


