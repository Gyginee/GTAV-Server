QBCore = exports["qb-core"]:GetCoreObject()

--------------------------------------------------------------------------------
local PlayerData = {}
local HasOrder,FirstOrder,SecondOrderPayout,ThirdOrderPayout,PayoutForSeventhOrder = false,false,false,false,false
local number,FirstOrderBlip,Plate = nil,nil,nil
local Vehicle
local ThirdBlipp, ThirdOrderBlip, SeventhOrderBlip

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

Citizen.CreateThread(function()
	local ped_hash = GetHashKey(Config.illegalorders['BossSpawn'].Type)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossNPC = CreatePed(1, ped_hash, Config.illegalorders['BossSpawn'].Pos.x, Config.illegalorders['BossSpawn'].Pos.y, Config.illegalorders['BossSpawn'].Pos.z, Config.illegalorders['BossSpawn'].Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(BossNPC, true)
	SetPedDiesWhenInjured(BossNPC, false)
	SetPedCanPlayAmbientAnims(BossNPC, true)
	SetPedCanRagdollFromPlayerImpact(BossNPC, false)
	SetEntityInvincible(BossNPC, true)
	FreezeEntityPosition(BossNPC, true)
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local coordsNPC = GetEntityCoords(BossNPC)	
		if(GetDistanceBetweenCoords(coords,Config.illegalorders['BossSpawn'].Pos.x, Config.illegalorders['BossSpawn'].Pos.y, Config.illegalorders['BossSpawn'].Pos.z, true) < 5.5) then	
			sleep = 5
			if(GetDistanceBetweenCoords(coords,Config.illegalorders['BossSpawn'].Pos.x, Config.illegalorders['BossSpawn'].Pos.y, Config.illegalorders['BossSpawn'].Pos.z, true) < 1.5) then
				if not HasOrder then
					DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z+1.0, 'Nhấn [~g~E~s~] - Để nói chuyện với Lão Béo')
				elseif HasOrder and (SecondOrderPayout or ThirdOrderPayout or PayoutForSeventhOrder) then
					DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z+1.0, 'Nhấn [~g~E~s~] - Để nhận lương')
				end
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not HasOrder then
					HasOrder = true
					Order = Randomize(Config.Orders)
					Orders()
				elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and SecondOrderPayout then
					QBCore.Functions.TriggerCallback('inside-illegalordersType2:payout', function(money)
						exports['xt-notify']:Alert("LÃO BÉO", "Đụ má, đây là $"..money.." tiền công của mày", 5000, 'success')
					end)
					HasOrder = false
					SecondOrderPayout = false
					number = nil
					Vehicle = nil
				elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and ThirdOrderPayout then
					QBCore.Functions.TriggerCallback('inside-illegalordersType3:payout', function(money)
						exports['xt-notify']:Alert("LÃO BÉO", "Đụ má, đây là $"..money.." tiền công của mày", 5000, 'success')
					end)
					HasOrder = false
					ThirdOrderPayout = false
					number = nil
					Vehicle = nil
				elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and HasOrder and PayoutForSeventhOrder then
					QBCore.Functions.TriggerCallback('inside-illegalordersType7:payout', function(money)
						exports['xt-notify']:Alert("LÃO BÉO", "Đụ má, đây là $"..money.." tiền công của mày", 5000, 'success')
					end)
					HasOrder = false
					PayoutForSeventhOrder = false
					number = nil
					Vehicle = nil
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

function Orders()
	local ped = PlayerPedId()
	if Order.name == 'first' then
		exports['xt-notify']:Alert("LÃO BÉO", "Con chó nào ăn trộm xe của tao, mày hãy đi mang nó về đây", 5000, 'info')
		number = math.random(1,#Config.FirstOrder['CarSpawn'])
		FirstOrderBlip = AddBlipForCoord(Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z)	
		SetBlipSprite (FirstOrderBlip, 1)
		SetBlipDisplay(FirstOrderBlip, 4)
		SetBlipScale  (FirstOrderBlip, 1.0)
		SetBlipColour (FirstOrderBlip, 0)
		SetBlipAsShortRange(FirstOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Xe Lão Béo')
		EndTextCommandSetBlipName(FirstOrderBlip)
		Citizen.CreateThread(function()
			while true do
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				if(GetDistanceBetweenCoords(coords,Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z, true) < 50.0) then
					QBCore.Functions.SpawnVehicle(Config.FirstOrder['CarSpawn'][number].Type, function(vehicle)
						Vehicle = vehicle
						SetEntityHeading(vehicle, Config.FirstOrder['CarSpawn'][number].Pos.h)
						SetVehicleNumberPlateText(vehicle, "BOSS"..tostring(math.random(100, 999)))
						Plate = GetVehicleNumberPlateText(vehicle)
						exports['LegacyFuel']:SetFuel(vehicle, 100.0)
						for i, v in pairs(Config.FirstOrder['CarSpawn'][number].Peds['Peds']) do
							local ped_hash = GetHashKey('g_m_m_mexboss_01')
							RequestModel(ped_hash)
							while not HasModelLoaded(ped_hash) do
								Citizen.Wait(1)
							end
							v.ped = CreatePed(1, ped_hash, v.x, v.y, v.z-0.5, 0.0, false, true)
							SetEntityHeading(v.ped, v.h)
							SetPedFleeAttributes(v.ped, 0, 0)
							SetPedCombatAttributes(v.ped, 46, 1)
							SetPedCombatAbility(v.ped, 100)
							SetPedCombatMovement(v.ped, 2)
							SetPedCombatRange(v.ped, 2)
							SetPedKeepTask(v.ped, true)
							GiveWeaponToPed(v.ped, GetHashKey('weapon_pistol'),250,false,true)
							SetPedAsCop(v.ped, true)
							SetPedDropsWeaponsWhenDead(v.ped, false)
						end
						FirstOrder()
					end, vector3(Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z), true)
					break
				end
				Citizen.Wait(5)
			end
		end)
	elseif Order.name == 'second' then
		exports['xt-notify']:Alert("LÃO BÉO", "Đến gặp Cu Lì lấy túi ma tuý về cho tao", 5000, 'warning')
		number = math.random(1,#Config.SecondOrder['PedSpawn'])
		SecondOrderBlip = AddBlipForCoord(Config.SecondOrder['PedSpawn'][number].Pos.x, Config.SecondOrder['PedSpawn'][number].Pos.y, Config.SecondOrder['PedSpawn'][number].Pos.z)	
		SetBlipSprite (SecondOrderBlip, 1)
		SetBlipDisplay(SecondOrderBlip, 4)
		SetBlipScale  (SecondOrderBlip, 1.0)
		SetBlipColour (SecondOrderBlip, 0)
		SetBlipAsShortRange(SecondOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		SetBlipRoute(SecondOrderBlip, true)
		AddTextComponentString('Cu Lì')
		EndTextCommandSetBlipName(SecondOrderBlip)
		local ped_hash = GetHashKey(Config.SecondOrder['PedSpawn'][number].Type)
		RequestModel(ped_hash)
		while not HasModelLoaded(ped_hash) do
			Citizen.Wait(1)
		end
		DealerPed = CreatePed(1, ped_hash, Config.SecondOrder['PedSpawn'][number].Pos.x, Config.SecondOrder['PedSpawn'][number].Pos.y, Config.SecondOrder['PedSpawn'][number].Pos.z-0.5, 0.0, false, true)	
		SetEntityHeading(DealerPed, Config.SecondOrder['PedSpawn'][number].Pos.h)
		SetBlockingOfNonTemporaryEvents(DealerPed, true)
		SetPedCanPlayAmbientAnims(DealerPed, true)
		SetPedCanRagdollFromPlayerImpact(DealerPed, false)
		SetEntityInvincible(DealerPed, true)
		startAnim(DealerPed, "amb@world_human_cop_idles@female@idle_b", "idle_d")
		FreezeEntityPosition(DealerPed, true)
		SecondOrder()
	elseif Order.name == 'third' then
		exports['xt-notify']:Alert("LÃO BÉO", "Thằng công tố viên mới đang điều tra tao, hãy cho nó ngậm mồm", 5000, 'warning')
		number = math.random(1,#Config.ThirdOrder['PedSpawn'])
		ThirdBlipp = AddBlipForCoord(Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z)	
		SetBlipSprite (ThirdBlipp, 1)
		SetBlipDisplay(ThirdBlipp, 4)
		SetBlipScale  (ThirdBlipp, 1.0)
		SetBlipColour (ThirdBlipp, 0)
		SetBlipAsShortRange(ThirdBlipp, true)
		SetBlipRoute(ThirdBlipp , true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Công tố viên')
		EndTextCommandSetBlipName(ThirdBlipp)
		while true do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords,Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z, true) < 50.0) then
				RemoveBlip(ThirdBlipp)
				SetBlipRoute(ThirdBlipp , false)
				local ped_hash = GetHashKey(Config.ThirdOrder['PedSpawn'][number].Type)
				QBCore.Functions.SpawnVehicle(Config.ThirdOrder['PedSpawn'][number].Car, function(vehicle)
					SetEntityHeading(vehicle, Config.ThirdOrder['PedSpawn'][number].Pos.h)
					exports['LegacyFuel']:SetFuel(vehicle, 100.0)
					RequestModel(ped_hash)
					while not HasModelLoaded(ped_hash) do
						Citizen.Wait(1)
					end
					Vehicle = vehicle
					DealerPed = CreatePed(1, ped_hash, Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z+1.0, 0.0, false, true)
					SetPedIntoVehicle(DealerPed, vehicle, -1)
					TaskVehicleDriveWander(DealerPed, vehicle, 25.0, 1)
				end, vector3(Config.ThirdOrder['PedSpawn'][number].Pos.x, Config.ThirdOrder['PedSpawn'][number].Pos.y, Config.ThirdOrder['PedSpawn'][number].Pos.z), true)
				ThirdOrderBlip = AddBlipForEntity(DealerPed)
					SetBlipSprite (ThirdOrderBlip, 1)
					SetBlipDisplay(ThirdOrderBlip, 4)
					SetBlipScale  (ThirdOrderBlip, 1.0)
					SetBlipColour (ThirdOrderBlip, 0)
					SetBlipAsShortRange(ThirdOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Công tố viên')
					EndTextCommandSetBlipName(ThirdOrderBlip)
				while true do
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					if IsPedDeadOrDying(DealerPed, 1) then
						exports['xt-notify']:Alert("HỆ THỐNG", "Đi về gặp Lão béo", 5000, 'info')
						RemoveBlip(ThirdOrderBlip)
						Citizen.Wait(3000)
						DeletePed(DealerPed)
						ThirdOrderPayout = true
						break
					end
					Citizen.Wait(5)
				end
				break
			end
			Citizen.Wait(5)
		end
	elseif Order.name == 'fourth' then
		exports['xt-notify']:Alert("LÃO BÉO", "Hãy đến lấy cái xe ở địa chỉ này", 5000, 'warning')
		number = math.random(1,#Config.FourthOrder['CarSpawn'])
		FourthBlipp = AddBlipForCoord(Config.FourthOrder['CarSpawn'][number].Pos.x, Config.FourthOrder['CarSpawn'][number].Pos.y, Config.FourthOrder['CarSpawn'][number].Pos.z)	
		SetBlipSprite (FourthBlipp, 1)
		SetBlipDisplay(FourthBlipp, 4)
		SetBlipScale  (FourthBlipp, 1.0)
		SetBlipColour (FourthBlipp, 0)
		SetBlipAsShortRange(FourthBlipp, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Delivery vehicle')
		EndTextCommandSetBlipName(FourthBlipp)
		while true do
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].Pos.x, Config.FourthOrder['CarSpawn'][number].Pos.y, Config.FourthOrder['CarSpawn'][number].Pos.z, true) < 50.0) then
				RemoveBlip(FourthBlipp)
				QBCore.Functions.SpawnVehicle(Config.FourthOrder['CarSpawn'][number].Car, function(vehicle)
					Vehicle = vehicle
					SetEntityHeading(vehicle, Config.FourthOrder['CarSpawn'][number].Pos.h)
					exports['LegacyFuel']:SetFuel(vehicle, 100.0)
					SetVehicleNumberPlateText(vehicle, "BOSS"..tostring(math.random(100, 999)))
					Plate = GetVehicleNumberPlateText(vehicle)
				end, vector3(Config.FourthOrder['CarSpawn'][number].Pos.x, Config.FourthOrder['CarSpawn'][number].Pos.y, Config.FourthOrder['CarSpawn'][number].Pos.z), true)
				FourthOrderBlip = AddBlipForEntity(vehicle)
				SetBlipSprite (FourthOrderBlip, 1)
				SetBlipDisplay(FourthOrderBlip, 4)
				SetBlipScale  (FourthOrderBlip, 1.0)
				SetBlipColour (FourthOrderBlip, 0)
				SetBlipAsShortRange(FourthOrderBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Điểm cất')
				EndTextCommandSetBlipName(FourthOrderBlip)
				while true do
					local sleep = 250
					local ped = PlayerPedId()
					local coords = GetEntityCoords(ped)
					if IsPedInAnyVehicle(ped, false) then
						local vehicle2 = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if GetVehicleNumberPlateText(vehicle2) == Plate then
							RemoveBlip(FourthOrderBlip)
							FourthOrderBlip = AddBlipForCoord(Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z)	
							SetBlipSprite (FourthOrderBlip, 1)
							SetBlipDisplay(FourthOrderBlip, 4)
							SetBlipScale  (FourthOrderBlip, 1.0)
							SetBlipColour (FourthOrderBlip, 0)
							SetBlipAsShortRange(FourthOrderBlip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString('Delivery point')
							EndTextCommandSetBlipName(FourthOrderBlip)
							exports['xt-notify']:Alert("HỆ THỐNG", "Mang xe đến điểm cất", 5000, 'info')
							FourthOrder()
							break
						end
					end
					Citizen.Wait(sleep)
				end
				break
			end
			Citizen.Wait(5)
		end
	elseif Order.name == 'fifth' then
		exports['xt-notify']:Alert("LÃO BÉO", "Con lợn này lừa tiền tao, hãy đến nơi đó và khoắng sạch", 5000, 'warning')
		number = math.random(1,#Config.FifthOrder['PedSpawn'])
		local ped_hash = GetHashKey(Config.FifthOrder['PedSpawn'][number].Type)
		RequestModel(ped_hash)
		while not HasModelLoaded(ped_hash) do
			Citizen.Wait(1)
		end			
		StorePed = CreatePed(1, ped_hash, Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z-0.5, 0.0, false, true)	
		SetEntityHeading(StorePed, Config.FifthOrder['PedSpawn'][number].Pos.h)
		SetBlockingOfNonTemporaryEvents(StorePed, true)
		SetPedCanPlayAmbientAnims(StorePed, true)
		SetPedCanRagdollFromPlayerImpact(StorePed, false)
		SetEntityInvincible(StorePed, true)
		startAnim(StorePed, "amb@world_human_cop_idles@female@idle_b", "idle_d")
		FreezeEntityPosition(StorePed, true)

		FifthOrderBlip = AddBlipForCoord(Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z)	
		SetBlipSprite (FifthOrderBlip, 1)
		SetBlipDisplay(FifthOrderBlip, 4)
		SetBlipScale  (FifthOrderBlip, 1.0)
		SetBlipColour (FifthOrderBlip, 0)
		SetBlipAsShortRange(FifthOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Cửa hàng cần cướp')
		EndTextCommandSetBlipName(FifthOrderBlip)

		FifthOrder()
	elseif Order.name == 'sixth' then
		exports['xt-notify']:Alert("LÃO BÉO", "Đi đến thùng hàng và lấy đồ bình xăng", 5000, 'warning')
		number = math.random(1,#Config.SixthOrder['Place'])
		SixthOrderBlip = AddBlipForCoord(Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z)
		SetBlipSprite (SixthOrderBlip, 1)
		SetBlipDisplay(SixthOrderBlip, 4)
		SetBlipScale  (SixthOrderBlip, 1.0)
		SetBlipColour (SixthOrderBlip, 0)
		SetBlipAsShortRange(SixthOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Thùng đựng')
		EndTextCommandSetBlipName(SixthOrderBlip)

		SixthOrder()
	elseif Order.name == 'seventh' then
		exports['xt-notify']:Alert("LÃO BÉO", "Đi đến đây cắt điện rồi lấy tài liệu cho tôi", 5000, 'warning')
		number = math.random(1,#Config.SeventhOrder['Place'])
		SeventhOrderBlip = AddBlipForCoord(Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z)	
		SetBlipSprite (SeventhOrderBlip, 1)
		SetBlipDisplay(SeventhOrderBlip, 4)
		SetBlipScale  (SeventhOrderBlip, 1.0)
		SetBlipColour (SeventhOrderBlip, 0)
		SetBlipAsShortRange(SeventhOrderBlip, true)
		SetBlipRoute(SeventhOrderBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Cầu dao điện')
		EndTextCommandSetBlipName(SeventhOrderBlip)
		SeventhOrder()
	end
end

function FirstOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 5
			if(GetDistanceBetweenCoords(coords,Config.FirstOrder['CarSpawn'][number].Pos.x, Config.FirstOrder['CarSpawn'][number].Pos.y, Config.FirstOrder['CarSpawn'][number].Pos.z, true) < 10.5) then
				for i, v in pairs(Config.FirstOrder['CarSpawn'][number].Peds['Peds']) do
					TaskCombatPed(v.ped, ped, 0, 16)
				end
			end
			if IsPedInAnyVehicle(ped, false) then
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
				if GetVehicleNumberPlateText(vehicle) == Plate then
					exports['xt-notify']:Alert("HỆ THỐNG", "Đi tới chỗ LÃO BÉO", 5000, 'info')
					RemoveBlip(FirstOrderBlip)
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep2 = 500
							if(GetDistanceBetweenCoords(coords,Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z, true) < 25.0) then
								sleep2 = 0
								DrawMarker(25, Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z-0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z, true) < 2.0) then
									DrawText3Ds(Config.FirstOrder['BackCar'].Pos.x, Config.FirstOrder['BackCar'].Pos.y, Config.FirstOrder['BackCar'].Pos.z+1.4, 'Nhấn [~g~E~s~ - Cất xe]')
									if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
										local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
										if GetVehicleNumberPlateText(vehicle) == Plate then
											QBCore.Functions.DeleteVehicle(vehicle)
											QBCore.Functions.TriggerCallback('inside-illegalordersType1:payout', function(money)
												exports['xt-notify']:Alert("LÃO BÉO", "Đụ má, đây là $"..money.." tiền công của mày", 5000, 'success')
											end)
											Vehicle = nil
											for i, v in pairs(Config.FirstOrder['CarSpawn'][number].Peds['Peds']) do
												DeletePed(v.ped)
											end
											Plate = nil
											number = nil
											HasOrder = false
											break
										end
									end
								end
							end
						Citizen.Wait(sleep2)
					end
					break
				end
			end
		Citizen.Wait(sleep)
	end
end

function SecondOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local coordsNPC = GetEntityCoords(DealerPed)
		local sleep = 5
		local frezze = true
		if(GetDistanceBetweenCoords(coords, Config.SecondOrder['PedSpawn'][number].Pos.x, Config.SecondOrder['PedSpawn'][number].Pos.y, Config.SecondOrder['PedSpawn'][number].Pos.z, true) < 5.5) and frezze then
			FreezeEntityPosition(DealerPed, false)
			frezze = false
		end
		if(GetDistanceBetweenCoords(coords, coordsNPC.x, coordsNPC.y, coordsNPC.z, true) < 1.5) then
			local text = true
			if text then
				DrawText3Ds(coordsNPC.x, coordsNPC.y, coordsNPC.z + 1.2, "Nhấn [~g~E~s~] - Lấy gói đồ")
			end
			if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
				text = false
				TaskTurnPedToFaceEntity(DealerPed, PlayerPedId(), 0.2)	
				startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
				QBCore.Functions.Progressbar("lay-thuoc", "Lấy thuốc", 5000, false, false, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {}, {}, {}, function() -- Done
					ClearPedTasks(ped)
					ClearPedTasks(DealerPed)
					TaskGoToCoordAnyMeans(DealerPed, Config.SecondOrder['PedSpawn'][number].Pos.x+5, Config.SecondOrder['PedSpawn'][number].Pos.y+5, Config.SecondOrder['PedSpawn'][number].Pos.z, 1.3)
					exports['xt-notify']:Alert("HỆ THỐNG", "Đi tới trở về Lão Béo", 5000, 'info')
					SecondOrderPayout = true
					RemoveBlip(SecondOrderBlip)
					SetBlipRoute(SecondOrderBlip, false)
				end)
				Citizen.Wait(5000)
				local displaying = true
				Citizen.CreateThread(function()
					Wait(3000)
					displaying = false
				end)
				inspection = true
				while displaying do
					Wait(0)
					local coordsPed = GetEntityCoords(DealerPed, false)
					local coords = GetEntityCoords(PlayerPedId(), false)
					local dist = Vdist2(coordsPed, coords)
					if dist < 150 then                
						DrawText3Ds(coordsPed['x'], coordsPed['y'], coordsPed['z'] + 1.2, "Biến đi")
					end
				end	
				Citizen.Wait(3000)
				DeletePed(DealerPed)
				break
			end
		end
	Citizen.Wait(sleep)
	end
end

function ThirdOrder()
	--Done in the orders function
end

function FourthOrder()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 10.5) then
			sleep = 5
			if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 5.5) then
				DrawMarker(2, Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
				if(GetDistanceBetweenCoords(coords,Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z, true) < 2.5) then
					DrawText3Ds(Config.FourthOrder['CarSpawn'][number].DeliveryPos.x, Config.FourthOrder['CarSpawn'][number].DeliveryPos.y, Config.FourthOrder['CarSpawn'][number].DeliveryPos.z+1.0, 'To deliver the vehicle, press [~g~E~w~]')
					if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
						local vehicle2 = GetVehiclePedIsIn(GetPlayerPed(-1), true)
						if GetVehicleNumberPlateText(vehicle2) == Plate then
							RemoveBlip(FourthOrderBlip)
							Plate = nil
							number = nil
							HasOrder = false
							QBCore.Functions.TriggerCallback('inside-illegalordersType4:payout', function(money)
								exports['xt-notify']:Alert("LÃO BÉO", "Đụ má, đây là $"..money.." tiền công của mày", 5000, 'success')
							end)
							FreezeEntityPosition(Vehicle)
							TaskLeaveVehicle(ped, Vehicle)
							SetVehicleDoorShut(Vehicle)
							Citizen.Wait(3000)
							DeleteVehicle(Vehicle)
							Vehicle = nil
							break
						else 
							exports['xt-notify']:Alert("LÃO BÉO", "Đây không phải xe chúng tao cần", 5000, 'error')
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end

function FifthOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		local block = false
		if(GetDistanceBetweenCoords(coords,Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z, true) < 5.5) and not block then
			block = true
			FreezeEntityPosition(StorePed, false)	
			SetBlockingOfNonTemporaryEvents(StorePed, false)
			SetPedCanPlayAmbientAnims(StorePed, false)
			SetPedCanRagdollFromPlayerImpact(StorePed, true)
			SetEntityInvincible(StorePed, false)	
		end
		if(GetDistanceBetweenCoords(coords,Config.FifthOrder['PedSpawn'][number].Pos.x, Config.FifthOrder['PedSpawn'][number].Pos.y, Config.FifthOrder['PedSpawn'][number].Pos.z, true) < 10.5) then
			sleep = 5
			if IsPlayerFreeAiming(PlayerId()) then
				local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId())
				if IsPedFleeing(targetPed) and targetPed == StorePed then
					startAnim(StorePed, 'anim@mp_player_intuppersurrender', 'enter')
					local displaying = true
					Citizen.CreateThread(function()
						Wait(3000)
						displaying = false
					end)
					while displaying do
						Wait(0)
						local coordsPed = GetEntityCoords(StorePed, false)             
						DrawText3Ds(coordsPed['x'], coordsPed['y'], coordsPed['z'] + 1.2, "Đừng hấp diêm em, anh cứ lấy hết đi")
					end	
					exports['xt-notify']:Alert("HỆ THỐNG", "Khoắng sạch tiền", 5000, 'info')
					RemoveBlip(FifthOrderBlip)
					FifthOrderBlip = AddBlipForCoord(Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z)	
					SetBlipSprite (FifthOrderBlip, 1)
					SetBlipDisplay(FifthOrderBlip, 4)
					SetBlipScale  (FifthOrderBlip, 0.6)
					SetBlipColour (FifthOrderBlip, 0)
					SetBlipAsShortRange(FifthOrderBlip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString('Cash')
					EndTextCommandSetBlipName(FifthOrderBlip)
					while true do
						local ped2 = PlayerPedId()
						local coords3 = GetEntityCoords(ped2)
						if(GetDistanceBetweenCoords(coords3,Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z, true) < 6.5) then
							DrawMarker(25, Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
							if(GetDistanceBetweenCoords(coords3,Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z, true) < 1.5) then
								DrawText3Ds(Config.FifthOrder['PedSpawn'][number].PosToRob.x, Config.FifthOrder['PedSpawn'][number].PosToRob.y, Config.FifthOrder['PedSpawn'][number].PosToRob.z+1.4, 'Nhấn [~g~E~s~] - Lục tủ')
								if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
									SetEntityHeading(ped2, Config.FifthOrder['PedSpawn'][number].PosToRob.h)
									startAnim(ped2, "anim@gangops@facility@servers@bodysearch@", "player_search")
									QBCore.Functions.Progressbar("cuop", "Lục tủ", 5000, false, false, {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									}, {}, {}, {}, function() -- Done
										QBCore.Functions.TriggerCallback('inside-illegalordersType5:payout', function(money)
											exports['xt-notify']:Alert("LÃO BÉO", "Đụ má, đây là $"..money.." tiền công của mày", 5000, 'success')
										end)
										Vehicle = nil
										ClearPedTasks(ped2)
										RemoveBlip(FifthOrderBlip)	
										number = nil
										HasOrder = false
									end)
									Citizen.Wait(8000)
									DeletePed(StorePed)
									break
								end
							end
						end
						Citizen.Wait(5)
					end
					break
				end
			end
		end
		Citizen.Wait(sleep)
	end
end

function SixthOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z, true) < 10.5) then
			sleep = 5
			DrawMarker(25, Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z, true) < 1.5) then
				DrawText3Ds(Config.SixthOrder['Place'][number].Pos.x, Config.SixthOrder['Place'][number].Pos.y, Config.SixthOrder['Place'][number].Pos.z+1.4, 'Nhấn [~g~E~s~] - Lấy bình xăng')
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
					SetEntityHeading(ped, Config.SixthOrder['Place'][number].Pos.h)
					startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
					QBCore.Functions.Progressbar("luc-do", "Lấy đồ", 5000, false, false, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function() -- Done
						ClearPedTasks(ped)
						exports['xt-notify']:Alert("HỆ THỐNG", "Đi tới tòa nhà được chỉ định", 5000, 'info')
						RemoveBlip(SixthOrderBlip)
						SixthOrderBlip = AddBlipForCoord(Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z)	
						SetBlipSprite (SixthOrderBlip, 1)
						SetBlipDisplay(SixthOrderBlip, 4)
						SetBlipScale  (SixthOrderBlip, 1.0)
						SetBlipColour (SixthOrderBlip, 0)
						SetBlipAsShortRange(SixthOrderBlip, true)
						BeginTextCommandSetBlipName("STRING")
						SetBlipRoute(SixthOrderBlip, true)
						AddTextComponentString('Toà nhà')
						EndTextCommandSetBlipName(SixthOrderBlip)
					end)
					Citizen.Wait(5000)
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep = 500
							if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z, true) < 10.5) then
								sleep = 5
								DrawMarker(25, Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z, true) < 1.5) then
									DrawText3Ds(Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z+1.4, 'Nhấn [~g~E~s~] - Để đốt')
									if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
										startAnim(ped, "weapon@w_sp_jerrycan", "fire")
										local can = CreateObject(GetHashKey('w_am_jerrycan'), coords.x, coords.y, coords.z, true, false, false)
										AttachEntityToEntity(can, ped, GetPedBoneIndex(ped, 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
										QBCore.Functions.Progressbar("dot", "Đốt", 5000, false, false, {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										}, {}, {}, {}, function() -- Done
											RemoveBlip(SixthOrderBlip)
											SetBlipRoute(SixthOrderBlip, false)
											ClearPedTasks(ped)
											DeleteObject(can)
											exports['xt-notify']:Alert("HỆ THỐNG", "Chạy ngay đi", 5000, 'warning')
											Citizen.Wait(4000)
											currentFires = {}
											fire = StartScriptFire(Config.SixthOrder['Place'][number].PosFire.x, Config.SixthOrder['Place'][number].PosFire.y, Config.SixthOrder['Place'][number].PosFire.z+0.20, 24, false)
											table.insert(currentFires, fire)
											QBCore.Functions.TriggerCallback('inside-illegalordersType6:payout', function(money)
												exports['xt-notify']:Alert("LÃO BÉO", "Mày được việc lắm, đây là $"..money.." tiền công của mày", 5000, 'success')
											end)
											Vehicle = nil
											number = nil
											HasOrder = false
											StopFire()
										end)
										Citizen.Wait(5000)
										break
									end
								end
							end
						Citizen.Wait(sleep)
					end
					break
				end
			end
		end
		Citizen.Wait(sleep)			
	end
end

function SeventhOrder()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local sleep = 500
		if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z, true) < 10.5) then
			sleep = 5
			DrawMarker(25, Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
			if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z, true) < 1.5) then
				DrawText3Ds(Config.SeventhOrder['Place'][number].Pos.x, Config.SeventhOrder['Place'][number].Pos.y, Config.SeventhOrder['Place'][number].Pos.z+1.4, 'Nhấn [~g~E~s~] - Ngắt điện')
				if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
					SetEntityHeading(ped, Config.SeventhOrder['Place'][number].Pos.h)
					startAnim(ped, "mini@repair", "fixing_a_ped")
					QBCore.Functions.Progressbar("ngat-dien", "Ngắt điện", 5000, false, false, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {}, {}, {}, function() -- Done
						RemoveBlip(SeventhOrderBlip)
						SetBlipRoute(SeventhOrderBlip, false)
						exports['xt-notify']:Alert("HỆ THỐNG", "Mất điện rồi, cuỗm nhanh tài liệu nào", 5000, 'info')
						SeventhOrderBlip = AddBlipForCoord(Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z)	
						SetBlipSprite (SeventhOrderBlip, 1)
						SetBlipDisplay(SeventhOrderBlip, 4)
						SetBlipScale  (SeventhOrderBlip, 1.0)
						SetBlipColour (SeventhOrderBlip, 0)
						SetBlipAsShortRange(SeventhOrderBlip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString('Tài liệu')
						EndTextCommandSetBlipName(SeventhOrderBlip)
					end)
					Citizen.Wait(5000)
					while true do
						local ped = PlayerPedId()
						local coords = GetEntityCoords(ped)
						local sleep = 500
							if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z, true) < 10.5) then
								sleep = 5
								DrawMarker(25, Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								if(GetDistanceBetweenCoords(coords,Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z, true) < 1.5) then
									DrawText3Ds(Config.SeventhOrder['Place'][number].PosTake.x, Config.SeventhOrder['Place'][number].PosTake.y, Config.SeventhOrder['Place'][number].PosTake.z+1.4, 'Nhấn [~g~E~s~] - Tìm tài liệu')
									if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
										SetEntityHeading(ped, Config.SeventhOrder['Place'][number].PosTake.h)
										startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
										QBCore.Functions.Progressbar("giay-to", "Tìm tài liệu", 5000, false, false, {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										}, {}, {}, {}, function() -- Done
											ClearPedTasks(ped)
											RemoveBlip(SeventhOrderBlip)
											SetBlipAsShortRange(SeventhOrderBlip, false)
											exports['xt-notify']:Alert("HỆ THỐNG", "Đi tới chỗ Lão Béo", 5000, 'info')
											PayoutForSeventhOrder = true
										end)
										Citizen.Wait(5000)		
										break
									end
								end
							end
						Citizen.Wait(sleep)
					end
					break
				end
			end
		end
	Citizen.Wait(sleep)
	end
end

function StopFire()
	Wait(10000)
	for k, v in ipairs(currentFires) do
		RemoveScriptFire(v)
	end
end

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
    ClearDrawOrigin()
end

RegisterNetEvent('inside-illegalorders:removecars')
AddEventHandler('inside-illegalorders:removecars', function()
	DeleteVehicle(Vehicle)
end)


