QBCore = exports["qb-core"]:GetCoreObject()

--------------------------------------------------------------------------------
local Shipments, PickupBlip, GatePoint
local PlayerData = {}
local JobStarted,Gate,work,haspackage,TrunkOpen = false,false,false,false,false
local custormersdone = 0


Citizen.CreateThread(function()
	local StartJobBlip = AddBlipForCoord(Config.Courier['Jobstart'].Pos.x, Config.Courier['Jobstart'].Pos.y, Config.Courier['Jobstart'].Pos.z)
	SetBlipSprite (StartJobBlip, 408)
	SetBlipDisplay(StartJobBlip, 4)
	SetBlipScale  (StartJobBlip, 0.8)
	SetBlipColour (StartJobBlip, 0)
	SetBlipAsShortRange(StartJobBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Giao Hàng')
	EndTextCommandSetBlipName(StartJobBlip)
end)


--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords, Config.Courier['Jobstart'].Pos.x, Config.Courier['Jobstart'].Pos.y, Config.Courier['Jobstart'].Pos.z, true) < 8.0) then
				sleep = 5
				DrawMarker(Config.Courier['Jobstart'].Type, Config.Courier['Jobstart'].Pos.x, Config.Courier['Jobstart'].Pos.y, Config.Courier['Jobstart'].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Courier['Jobstart'].Size.x, Config.Courier['Jobstart'].Size.y, Config.Courier['Jobstart'].Size.z, Config.Courier['Jobstart'].Color.r, Config.Courier['Jobstart'].Color.g, Config.Courier['Jobstart'].Color.b, 100, false, true, 2, false, false, false, false)
				DrawMarker(29, Config.Courier['Jobstart'].Pos.x, Config.Courier['Jobstart'].Pos.y, Config.Courier['Jobstart'].Pos.z+0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 143, 235, 77, 100, false, true, 2, false, false, false, false)
				if(GetDistanceBetweenCoords(coords, Config.Courier['Jobstart'].Pos.x, Config.Courier['Jobstart'].Pos.y, Config.Courier['Jobstart'].Pos.z, true) < 1.5) then
					if not JobStarted then
						DrawText3Ds(Config.Courier['Jobstart'].Pos.x, Config.Courier['Jobstart'].Pos.y, Config.Courier['Jobstart'].Pos.z+1.4, 'Nhấn ~g~[E]~s~ Để bắt đầu công việc')
						if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
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
								else
									SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
									SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) 
									SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0)
									SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0)
									SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0)
								end
								exports['xt-notify']:Alert("THÔNG BÁO", 'Đã bắt đầu làm việc, hãy tới điểm nhận hàng', 5000, 'info')
								JobStarted = true
								CreatePickupBlip()
							end)    				
						elseif IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
							exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn phải ra khỏi phương tiện', 5000, 'error')
						end
					else
						DrawText3Ds(Config.Courier['Jobstart'].Pos.x, Config.Courier['Jobstart'].Pos.y, Config.Courier['Jobstart'].Pos.z+1.4, 'Nhấn ~r~[E]~s~ Để kết thúc công việc và trả xe')
						if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
							local health = GetEntityHealth(ped)
                            local maxhealth = GetEntityMaxHealth(ped)
							local xe = GetVehiclePedIsIn(GetPlayerPed(-1), true)
							if GetEntityModel(xe) == GetHashKey(Config.Vehicle) then
								QBCore.Functions.TriggerCallback('inside-Courier:server:CheckBail', function(DidBail)
									if DidBail then
										QBCore.Functions.Progressbar("thay-do", "Thay đồ", 3000, false, true, {
											disableMovement = true,
											disableCarMovement = false,
											disableMouse = false,
											disableCombat = true,
										}, {}, {}, {}, function() -- Done
											TriggerServerEvent("qb-clothes:loadPlayerSkin")
										exports['xt-notify']:Alert("THÔNG BÁO", 'Đã kết thúc công việc', 5000, 'success')
										QBCore.Functions.DeleteVehicle(Vehicle)
										JobStarted = false
										Gate = false
										haspackage = false
										TrunkOpen = false
										Shipments = nil 
										PickupBlip = nil 
										GatePoint = nil
										Vehicle = nil
										custormersdone = 0
										RemoveBlip(PickupBlip)
										RemoveBlip(GateBlip)
										for i, v in pairs(Config.Courier['Customers']) do
											RemoveBlip(v.blip)
											v.done = false
											ClearPedTasksImmediately(v.ped)
											DeletePed(v.ped)
										end
										ClearPedTasks(ped)
										DeleteEntity(pack)
										DeleteEntity(pack2)
										end) 
										SetPedMaxHealth(PlayerId(), maxhealth)
                                        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
                                        SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
                                        Citizen.Wait(3000) -- Safety Delay
                                        SetEntityHealth(PlayerPedId(), health)
									else
										exports['xt-notify']:Alert("THÔNG BÁO", "Bạn chưa trả tiền cho phương tiện này", 5000, 'error') 
									end
								end)
							else
								exports['xt-notify']:Alert("THÔNG BÁO", "Đây không phải xe của chúng tôi", 5000, 'error')
							end									
						elseif IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
							exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn phải ra khỏi phương tiện', 5000, 'error')
						end
					end
				end	
			elseif(GetDistanceBetweenCoords(coords, Config.Courier['Pickup'].Pos.x, Config.Courier['Pickup'].Pos.y, Config.Courier['Pickup'].Pos.z, true) < 8.0) and JobStarted and not Shipments then
				sleep = 5
				DrawMarker(Config.Courier['Pickup'].Type, Config.Courier['Pickup'].Pos.x, Config.Courier['Pickup'].Pos.y, Config.Courier['Pickup'].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Courier['Pickup'].Size.x, Config.Courier['Pickup'].Size.y, Config.Courier['Pickup'].Size.z, Config.Courier['Pickup'].Color.r, Config.Courier['Pickup'].Color.g, Config.Courier['Pickup'].Color.b, 100, false, true, 2, false, false, false, false)
				DrawMarker(30, Config.Courier['Pickup'].Pos.x, Config.Courier['Pickup'].Pos.y, Config.Courier['Pickup'].Pos.z+0.90, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if(GetDistanceBetweenCoords(coords, Config.Courier['Pickup'].Pos.x, Config.Courier['Pickup'].Pos.y, Config.Courier['Pickup'].Pos.z, true) < 1.5) then
					DrawText3Ds(Config.Courier['Pickup'].Pos.x, Config.Courier['Pickup'].Pos.y, Config.Courier['Pickup'].Pos.z+1.4, 'Nhấn ~g~[E]~s~ Để lấy xe và đơn hàng')
					if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
						QBCore.Functions.TriggerCallback('inside-Courier:server:HasMoney', function(HasMoney)
							if HasMoney then
								if IsSpawnPointClear(Config.Courier['Carspawn'].Pos, 2) then					
									Shipments = math.random(Config.MinShipments,Config.MaxShipments)
									exports['xt-notify']:Alert("THÔNG BÁO", 'Đã nhận đơn hàng, cần chất '..Shipments..' gói hàng!', 5000, 'success')
									RemoveBlip(PickupBlip)
									SpawnVehicle()							
								else
									exports['xt-notify']:Alert("THÔNG BÁO", 'Điểm lấy xe đã bị chặn!', 5000, 'warning')
								end
							else
								exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ tiền cọc xe", 5000, 'error')
							end
						end)
					elseif IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
						exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn phải ra khỏi phương tiện', 5000, 'error')
					end
				end
			end
	Citizen.Wait(sleep)
	end
end)

--##############################

function IsSpawnPointClear(coords, radius)
	local vehicles = GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetClosestVehicle(coords)
	local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function GetVehiclesInArea(coords, area)
	local vehicles       = GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

--##############################

function CreatePickupBlip()
	PickupBlip = AddBlipForCoord(Config.Courier['Pickup'].Pos.x, Config.Courier['Pickup'].Pos.y, Config.Courier['Pickup'].Pos.z)
  
	SetBlipSprite (PickupBlip, 478)
	SetBlipDisplay(PickupBlip, 4)
	SetBlipScale  (PickupBlip, 0.8)
	SetBlipColour (PickupBlip, 0)
	SetBlipAsShortRange(PickupBlip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Điểm lấy hàng')
	EndTextCommandSetBlipName(PickupBlip)
end

function SpawnVehicle()
	Wait(1500)
	if not Vehicle then
		QBCore.Functions.SpawnVehicle(Config.Courier['Carspawn'].Model, function(vehicle)
			SetVehicleNumberPlateText(vehicle, "SHIP"..tostring(math.random(1000, 9999)))
			SetEntityHeading(vehicle, Config.Courier['Carspawn'].Heading)
			TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
			SetEntityAsMissionEntity(vehicle, true, true)
			exports['lj-fuel']:SetFuel(vehicle, 100.0)
			exports['xt-vehiclekeys']:SetVehicleKey(GetVehicleNumberPlateText(vehicle), true)
			SetVehicleEngineOn(vehicle, true, true)
			Vehicle = vehicle
			exports['xt-notify']:Alert("THÔNG BÁO", 'Đi tới điểm lấy hàng thôi nào', 5000, 'info')
			CreateGate()
		end, Config.Courier['Carspawn'].Pos, true)
	else
		CreateGate()
	end
end


function CreateGate()
	Gate = true
	GatePoint = Randomize(Config.Courier['Gate'])
	GateBlip = AddBlipForCoord(GatePoint.x, GatePoint.y, GatePoint.z)
	SetBlipSprite (GateBlip, 478)
	SetBlipDisplay(GateBlip, 4)
	SetBlipScale  (GateBlip, 0.8)
	SetBlipColour (GateBlip, 0)
	SetBlipAsShortRange(GateBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Điểm lấy hàng')
	EndTextCommandSetBlipName(GateBlip)
end

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
			if Gate and JobStarted then
				if(GetDistanceBetweenCoords(coords, GatePoint.x, GatePoint.y, GatePoint.z, true) < 12.0) then
					sleep = 5
					DrawMarker(21, GatePoint.x, GatePoint.y, GatePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					if(GetDistanceBetweenCoords(coords, GatePoint.x, GatePoint.y, GatePoint.z, true) < 3.0) then
						DrawText3Ds(GatePoint.x, GatePoint.y, GatePoint.z+1.4, 'Nhấn ~g~[E]~s~ Để chất hàng lên xe')
						if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
							local veh = GetVehiclePedIsIn(ped, false)
							local vheading = GetEntityHeading(veh)
							local namecar = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
							if namecar == 'BENSON' then
								if (GatePoint.h<361 and GatePoint.h>340) or (GatePoint.h<21 and GatePoint.h>=0) then 
									if (vheading<361 and vheading>340) or (vheading<21 and vheading>=0) then
										Gate = false
										TrunkOpen = true
										local time = (Shipments * 1500)
										QBCore.Functions.Progressbar("chat-hang", "Chất hàng", time, false, true, {
											disableMovement = true,
											disableCarMovement = false,
											disableMouse = false,
											disableCombat = true,
										}, {}, {}, {}, function() -- Done
										exports['xt-notify']:Alert("THÔNG BÁO", 'Phương tiện đã được chất đầy, hãy giao đến cho khách hàng', 5000, 'info')
										RemoveBlip(GateBlip)
										StartWork()	
										end) 
									else
										exports['xt-notify']:Alert("THÔNG BÁO", 'Xe của bạn cần đối diện cánh cổng ', 5000, 'warning')
									end
								else
									if (vheading<GatePoint.h and vheading>GatePoint.h-20.0) or (vheading>GatePoint.h and vheading<GatePoint.h+20.0) then
										Gate = false
										TrunkOpen = true
										local time1 = (Shipments * 1500)
										QBCore.Functions.Progressbar("chat-hang", "Chất hàng", time, false, true, {
											disableMovement = true,
											disableCarMovement = false,
											disableMouse = false,
											disableCombat = true,
										}, {}, {}, {}, function() -- Done
											exports['xt-notify']:Alert("THÔNG BÁO", 'Phương tiện đã được chất, hãy giao đến cho khách hàng', 5000, 'info')
											RemoveBlip(GateBlip)
											StartWork()	
										end) 								
									else
										exports['xt-notify']:Alert("THÔNG BÁO", 'Xe của bạn cần đối diện cánh cổng', 5000, 'info')
									end
								end
							else
								exports['xt-notify']:Alert("THÔNG BÁO", 'Đây không phải phương tiện cần được giao', 5000, 'warning')
							end
						elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
							exports['xt-notify']:Alert("THÔNG BÁO", 'Lên xe và đi thôi', 5000, 'info')
						end
					end
				end
			end
		Citizen.Wait(sleep)
	end
end)

function StartWork()
	for i, v in pairs(Config.Courier['Customers']) do
		if Shipments and i > Shipments then break end
		v.blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (v.blip, 128)
		SetBlipDisplay(v.blip, 4)
		SetBlipScale  (v.blip, 0.8)
		SetBlipColour (v.blip, 5)
		SetBlipAsShortRange(v.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Khách hàng')
		EndTextCommandSetBlipName(v.blip)
		local ped_hash = GetHashKey(Config.Courier['Peds'][math.random(1,#Config.Courier['Peds'])].ped)
		RequestModel(ped_hash)
		while not HasModelLoaded(ped_hash) do
			Citizen.Wait(1)
		end
		v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.5, v.h, false, true)
		SetBlockingOfNonTemporaryEvents(v.ped, true)
		SetPedDiesWhenInjured(v.ped, false)
		SetPedCanPlayAmbientAnims(v.ped, true)
		SetPedCanRagdollFromPlayerImpact(v.ped, false)
		SetEntityInvincible(v.ped, true)
  		FreezeEntityPosition(v.ped, true)
	end
	work = true
end

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
				if Vehicle and not IsPedInAnyVehicle(ped, false) and JobStarted and Shipments and TrunkOpen then
					local trunkpos = GetOffsetFromEntityInWorldCoords(Vehicle, 0, -3.8, 0)
						if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 1.5 then
							sleep = 5
							if not haspackage then
								DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 1.15, "Nhấn ~g~[E]~s~ Để lấy hàng ra khỏi xe")
							else
								DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 1.15, "Nhấn ~r~[E]~s~ Để chất hàng lên xe")
							end
							if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 1.5 then
								if IsControlJustReleased(0, Keys["E"]) and not haspackage then
									haspackage = true
									SetVehicleDoorsLocked(Vehicle, 2)
									RequestAnimDict("anim@heists@box_carry@")
									while (not HasAnimDictLoaded("anim@heists@box_carry@")) do
										Citizen.Wait(7)
									end
									TaskPlayAnim(GetPlayerPed(-1), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
									pack = CreateObject(GetHashKey('prop_cs_cardbox_01'), coords.x, coords.y, coords.z,  true,  true, true)
									AttachEntityToEntity(pack, ped, GetPedBoneIndex(ped, 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
									Citizen.Wait(500)
								elseif IsControlJustReleased(0, Keys["E"]) and haspackage then
									haspackage = false
									SetVehicleDoorsLocked(Vehicle, 1)
									ClearPedTasks(ped)
									TaskPlayAnim(ped, 'anim@heists@box_carry@', "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)
									DeleteEntity(pack)
									Citizen.Wait(500)
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
		if AnimLoop then
			sleep = 5
			TaskPlayAnim(GetPlayerPed(-1), "anim@heists@box_carry@" ,"idle", 5.0, -1, -1, 50, 0, false, false, false)
		end
	Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
				if work then
					sleep = 5
					for i, v in ipairs(Config.Courier['Customers']) do
						if Shipments and i > Shipments then break end
						if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) and not v.done then
							DrawText3Ds(v.x, v.y, v.z+0.5, 'Nhấn ~g~[E]~s~ Để đưa hàng')
							if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5) and not v.done then
								if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and haspackage then
									v.done = true
									time = math.random(3000,5000)
									QBCore.Functions.Progressbar("chat-hang", "Giao hàng", time, false, true, {
										disableMovement = true,
										disableCarMovement = false,
										disableMouse = false,
										disableCombat = true,
									}, {}, {}, {}, function() -- Done
										haspackage = false
										SetVehicleDoorsLocked(Vehicle, 1)
										ClearPedTasks(ped)
										TaskPlayAnim(ped, 'anim@heists@box_carry@', "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)
										DeleteEntity(pack)

										FreezeEntityPosition(v.ped, false)
										TaskTurnPedToFaceEntity(v.ped, PlayerPedId(), 0.2)
										local coordsPED = GetEntityCoords(v.ped)
										startAnim(v.ped, 'anim@heists@box_carry@', 'idle')
										pack2 = CreateObject(GetHashKey('prop_cs_cardbox_01'), coordsPED.x, coordsPED.y, coordsPED.z,  true,  true, true)
										AttachEntityToEntity(pack2, v.ped, GetPedBoneIndex(v.ped, 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
										Citizen.Wait(1000)
										TaskGoStraightToCoord(v.ped, v.gotoX, v.gotoY, v.gotoZ, 1.0, 1.0, v.gotoH, 1)
										local displaying = true
										local RandomText = Config.Courier['Text'][math.random(1,#Config.Courier['Text'])].text
										Citizen.CreateThread(function()
											Wait(5000)
											displaying = false
										end)
										while displaying do
											Wait(0)
											local coordsPed = GetEntityCoords(v.ped, false)
											local coords = GetEntityCoords(PlayerPedId(), false)
											local dist = Vdist2(coordsPed, coords)
											if dist < 150 then                
												DrawText3Ds(coordsPed['x'], coordsPed['y'], coordsPed['z'] + 1.2, RandomText)
											end
										end														
										ClearPedTasksImmediately(v.ped)
										DeleteEntity(pack2)
										DeletePed(v.ped)
										RemoveBlip(v.blip)
										custormersdone = custormersdone + 1
										QBCore.Functions.TriggerCallback('inside-Courier:payout', function(money)
											exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã nhận được '..money..'$', 5000, 'success')
										end)
										if custormersdone >= Shipments then
											haspackage = false
											ClearPedTasks(ped)
											DeleteEntity(pack)
											work = false
											custormersdone = 0
											RemoveBlip(PickupBlip)
											RemoveBlip(GateBlip)
											for i, v in pairs(Config.Courier['Customers']) do
												RemoveBlip(v.blip)
												v.done = false
											end
											Shipments = nil
											Gate = false
											TrunkOpen = false
											CreatePickupBlip()
											Citizen.Wait(1000)
											exports['xt-notify']:Alert("THÔNG BÁO", 'Bạn đã giao hết, hãy trở về trụ sở', 5000, 'info')
										else
											Citizen.Wait(1000)
											exports['xt-notify']:Alert("THÔNG BÁO", 'Hãy đến địa điểm khách hàng tiếp theo ('..custormersdone..'/'..Shipments..')', 5000, 'info')
										end
									end)
								elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not haspackage then
									exports['xt-notify']:Alert("THÔNG BÁO", 'Hãy lấy gói hàng ra khỏi xe', 5000, 'info')
								end
							end
						end
					end
				end
		Citizen.Wait(sleep)
	end
end)

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
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


