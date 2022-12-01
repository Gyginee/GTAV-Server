local QBCore = exports["qb-core"]:GetCoreObject()
PlayerData = {}
local pedList = {}
local cam = nil
local name = ''
local waitMore = true
local inMenu = false
local hasEntered = false

Citizen.CreateThread(function()
	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = QBCore.Functions.GetPlayerData()
end)

-- CREATE NPCs

Citizen.CreateThread(function()
	local pedInfo = {}
	local camCoords = nil
	local camRotation = nil
	for k, v in pairs(Config.TalkToNPC) do
		RequestModel(GetHashKey(v.npc))
		while not HasModelLoaded(GetHashKey(v.npc)) do
			Wait(1)
		end
		RequestAnimDict("mini@strip_club@idles@bouncer@base")
		while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
			Wait(1)
		end

		ped = CreatePed(4, v.npc, v.coordinates[1], v.coordinates[2], v.coordinates[3], v.heading, false, true)
		SetEntityHeading(ped, v.heading)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

		if Config.AutoCamPosition then
			local px, py, pz = table.unpack(GetEntityCoords(ped, true))
			local x, y, z = px + GetEntityForwardX(ped) * 1.2, py + GetEntityForwardY(ped) * 1.2, pz + 0.52

			camCoords = vector3(x, y, z)
		end

		if Config.AutoCamRotation then
			local rx = GetEntityRotation(ped, 2)

			camRotation = rx + vector3(0.0, 0.0, 181)
		end

		pedInfo = {
			name = v.name,
			model = v.npc,
			pedCoords = v.coordinates,
			entity = ped,
			camCoords = camCoords,
			camRotation = camRotation,
		}

		table.insert(pedList, pedInfo)
	end
end)

-- CHECK DISTANCE & JOB

Citizen.CreateThread(function()
	local inZone = false
	local hasSetName = false
	local nearPed = false
	local checkedJob = false
	local hasJob = false
	local npcModel = nil
	local npcName = nil
	local npcKey = 0
	
	while true do
		Citizen.Wait(20)
		local playerCoords = GetEntityCoords(PlayerPedId())
		
		inZone = false
		nearPed = false

		if npcName == nil and npcModel == nil then
			for k,v in pairs(Config.TalkToNPC) do
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
			
				if v.jobs[1] ~= nil then

					if distance < v.interactionRange + 2 then
						npcName = v.name
						npcModel = v.npc
						npcKey = k
						nearPed = true

					elseif not waitMore and not nearPed then
						waitMore = true
					elseif checkedJob then
						checkedJob = false
					end
				else
					if distance < v.interactionRange + 2 then
						npcName = v.name
						npcModel = v.npc
						npcKey = k
						nearPed = true
						if not inMenu then
							waitMore = false
						end
						
					elseif not waitMore and not nearPed then
						waitMore = true
					end
				end
			end
		else
			v = Config.TalkToNPC[npcKey]
			if v ~= nil then
				local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, v.coordinates[1], v.coordinates[2], v.coordinates[3])
				local zDistance = playerCoords.z - v.coordinates[3]
				
				if zDistance < 0 then
					zDistance = zDistance * -1
				end
				if zDistance < 2 then
					if v.jobs[1] ~= nil then

						if distance < v.interactionRange + 3 then
							if not checkedJob then
								hasJob = false
								checkedJob = true
								for k2,v2 in pairs(v.jobs) do
									if PlayerData.job.name == v2 then
										hasJob = true
									end
								end
							end
							
							if hasJob then
								if not nearPed then
									nearPed = true
								end
								if not inMenu then
									waitMore = false
								end
								if distance < v.interactionRange then
									if not hasSetName then
										name = v.uiText
										hasSetName = true
									end
									if not inZone then
										inZone = true
									end
									if not Config.UseOkokTextUI and not inMenu then
										QBCore.Functions.Notify('[E] Để nói chuyện với '..name, 'success')
									end
									if IsControlJustReleased(0, Config.Key) then
										inMenu = true
										waitMore = true
										StartCam(v.coordinates, v.camOffset, v.camRotation, v.npc, v.name)
										if Config.UseOkokTextUI then
											exports['okokTextUI']:Close()
										end
										Citizen.Wait(500)
										if Config.HideMinimap then
											DisplayRadar(false)
										end
										SetNuiFocus(true, true)
										SendNUIMessage({
											action = 'openDialog',
											name = v.name,
											dialog = v.dialog,
											options = v.options,
										})
									end
								elseif hasSetName then
									hasSetName = false
								end
							end
						elseif not waitMore and not nearPed then
							waitMore = true
						elseif checkedJob then
							checkedJob = false
						end
						if distance > v.interactionRange + 2 and npcName ~= nil and npcModel ~= nil then
							npcModel = nil
							npcName = nil
							npcKey = 0
						end
					else
						if distance < v.interactionRange + 3 then
							if not nearPed then
								nearPed = true
							end
							if not inMenu then
								waitMore = false
							end
							if distance < v.interactionRange then
								if not hasSetName then
									name = v.uiText
									hasSetName = true
								end
								if not inZone then
									inZone = true
								end
								if not Config.UseOkokTextUI and not inMenu then
									QBCore.Functions.Notify('[E] Để nói chuyện với '..name, 'success')
								end
								if IsControlJustReleased(0, Config.Key) then
									inMenu = true
									waitMore = true
									StartCam(v.coordinates, v.camOffset, v.camRotation, v.npc, v.name)
									if Config.UseOkokTextUI then
										exports['okokTextUI']:Close()
									end
									Citizen.Wait(500)
									if Config.HideMinimap then
										DisplayRadar(false)
									end
									SetNuiFocus(true, true)
									SendNUIMessage({
										action = 'openDialog',
										header = v.header,
										name = v.name,
										dialog = v.dialog,
										options = v.options,
									})
								end
							elseif hasSetName then
								hasSetName = false
							end
						elseif not waitMore and not nearPed then
							waitMore = true
						end
						if distance > v.interactionRange + 2 and npcName ~= nil and npcModel ~= nil then
							npcModel = nil
							npcName = nil
							npcKey = 0
						end
					end
				end
			end
		end

		

		if inZone and not hasEntered then
			if Config.UseOkokTextUI then
				exports['okokTextUI']:Open('[E] Để nói chuyện với '..name, 'darkblue', 'left') 
			end
			hasEntered = true
		elseif not inZone and hasEntered then
			if Config.UseOkokTextUI then
				exports['okokTextUI']:Close()
			end
			hasEntered = false
		end 

		if waitMore then
			Citizen.Wait(1000)
		end
	end
end)

-- ACTIONS

RegisterNUICallback('action', function(data, cb)
	if data.action == 'close' then
		SetNuiFocus(false, false)
		exports['xt-notify']:Alert("HỆ THỐNG", "Chúc bạn một ngày tốt lành", 5000, 'info')
		if Config.HideMinimap then
			DisplayRadar(true)
		end
		hasEntered = true
		if Config.UseOkokTextUI then
			exports['okokTextUI']:Open('[E] Để nói chuyện với '..name..'', 'darkblue', 'left') 
		end
		EndCam()
		inMenu = false
		waitMore = false
	elseif data.action == 'option' then
		SetNuiFocus(false, false)
		if Config.HideMinimap then
			DisplayRadar(true)
		end
		hasEntered = true
		if Config.UseOkokTextUI then
			exports['okokTextUI']:Open('[E] Để nói chuyện với '..name..'', 'darkblue', 'left')
		end
		EndCam()
		inMenu = false
		waitMore = false

		if data.options[3] == 'c' then
			TriggerEvent(data.options[2])
		elseif data.options[3] ~= nil then
			TriggerServerEvent(data.options[2])
		end
	end
end)

-- CAMERA

function StartCam(coords, offset, rotation, model, name)
	ClearFocus()

	if Config.AutoCamRotation then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					rotation = v.camRotation
				end
			end
		end
	end

	if Config.AutoCamPosition then
		for k,v in pairs(pedList) do
			if v.pedCoords == coords then
				if v.name == name and v.model == model then
					coords = v.camCoords
				end
			end
		end
	else
		coords = coords + offset
	end

	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords, rotation, GetGameplayCamFov())

	SetCamActive(cam, true)
	RenderScriptCams(true, true, Config.CameraAnimationTime, true, false)
end

function EndCam()
	ClearFocus()

	RenderScriptCams(false, true, Config.CameraAnimationTime, true, false)
	DestroyCam(cam, false)

	cam = nil
end








-- EXAMPLE EVENTS CALLED ON CONFIG.LUA

RegisterNetEvent("okokTalk:toilet")
AddEventHandler("okokTalk:toilet", function()
	exports['xt-notify']:Alert("BANK", "On your right, sir.", 5000, 'info')
end)

RegisterNetEvent("okokTalk:rob")
AddEventHandler("okokTalk:rob", function()
	exports['xt-notify']:Alert("BANK", "Please stop joking, sir.", 5000, 'warning')
end)

RegisterNetEvent("okokTalk:safe")
AddEventHandler("okokTalk:safe", function()
	exports['xt-notify']:Alert("BANK", "You don't have a safe, sir.", 5000, 'error')
end)

RegisterNetEvent("okokTalk:card")
AddEventHandler("okokTalk:card", function()
	exports['xt-notify']:Alert("BANK", "You'll have to wait for Jennifer, sir.", 5000, 'info')
end)

RegisterNetEvent("okokTalk:lost")
AddEventHandler("okokTalk:lost", function()
	exports['xt-notify']:Alert("BANK", "No problem, we'll send a new one to your home.", 5000, 'success')
end)

RegisterNetEvent("okokTalk:jennifer")
AddEventHandler("okokTalk:jennifer", function()
	exports['xt-notify']:Alert("BANK", "Not at the moment, she starts at 1 PM.", 5000, 'info')
end)

RegisterNetEvent("okokTalk:muado")
AddEventHandler("okokTalk:muado", function()
	TriggerEvent("qg-stores:server:open:shop")
end)
RegisterNetEvent("okokTalk:nganhang")
AddEventHandler("okokTalk:nganhang", function()
	TriggerEvent("okokBanking:client:OpenBank")
end)
RegisterNetEvent("okokTalk:nhapvien")
AddEventHandler("okokTalk:nhapvien", function()
	TriggerEvent("hospital:client:nhapvien")
end)
RegisterNetEvent("okokTalk:bslayxe")
AddEventHandler("okokTalk:bslayxe", function()
	TriggerEvent("hospital:client:gara")
end)
RegisterNetEvent("okokTalk:vaoca")
AddEventHandler("okokTalk:vaoca", function()
	TriggerEvent("hospital:client:vaoca")
end)
RegisterNetEvent("okokTalk:donganh")
AddEventHandler("okokTalk:donganh", function()
	TriggerEvent("hospital:client:donganh")
end)
RegisterNetEvent("okokTalk:bstructhang")
AddEventHandler("okokTalk:bstructhang", function()
	TriggerEvent("hospital:client:tructhang")
end)
RegisterNetEvent("okokTalk:xerac")
AddEventHandler("okokTalk:xerac", function()
	TriggerEvent("qb-garbagejob:client:layxe")
end)
RegisterNetEvent("okokTalk:luongrac")
AddEventHandler("okokTalk:luongrac", function()
	TriggerEvent("qb-garbagejob:client:layluong")
end)
RegisterNetEvent("okokTalk:csdiemdanh")
AddEventHandler("okokTalk:csdiemdanh", function()
	TriggerEvent("police:client:diemdanh")
end)
RegisterNetEvent("okokTalk:cstudo1")
AddEventHandler("okokTalk:cstudo1", function()
	TriggerEvent("police:client:cstudo1")
end)
RegisterNetEvent("okokTalk:cstudo2")
AddEventHandler("okokTalk:cstudo2", function()
	TriggerEvent("police:client:cstudo2")
end)
RegisterNetEvent("okokTalk:cstudo3")
AddEventHandler("okokTalk:cstudo3", function()
	TriggerEvent("police:client:cstudo3")
end)
RegisterNetEvent("okokTalk:csthungrac")
AddEventHandler("okokTalk:csthungrac", function()
	TriggerEvent("police:client:csthungrac")
end)
RegisterNetEvent("okokTalk:csdonganh")
AddEventHandler("okokTalk:csdonganh", function()
	TriggerEvent("police:client:csdonganh")
end)
RegisterNetEvent("okokTalk:cstudo")
AddEventHandler("okokTalk:cstudo", function()
	TriggerEvent("police:client:cstudo")
end)
RegisterNetEvent("okokTalk:csxenganh")
AddEventHandler("okokTalk:csxenganh", function()
	TriggerEvent("police:client:csxenganh")
end)
RegisterNetEvent("okokTalk:csxegiam")
AddEventHandler("okokTalk:csxegiam", function()
	TriggerEvent("police:client:csxegiam")
end)
RegisterNetEvent("okokTalk:cstructhang")
AddEventHandler("okokTalk:cstructhang", function()
	TriggerEvent("police:client:cstructhang")
end)
RegisterNetEvent("okokTalk:shipxe")
AddEventHandler("okokTalk:shipxe", function()
	TriggerEvent("qg-trucker:client:layxe")
end)
RegisterNetEvent("okokTalk:shipluong")
AddEventHandler("okokTalk:shipluong", function()
	TriggerEvent("qg-trucker:client:layluong")
end)
RegisterNetEvent("okokTalk:bandofarm")
AddEventHandler("okokTalk:bandofarm", function()
	TriggerEvent("qg-bando:client:bando")
end)
RegisterNetEvent("okokTalk:garalayxe")
AddEventHandler("okokTalk:garalayxe", function()
	TriggerEvent("qg-garages:client:gara")
end)
RegisterNetEvent("okokTalk:garachuocxe")
AddEventHandler("okokTalk:garachuocxe", function()
	TriggerEvent("qg-garages:client:depot")
end)
RegisterNetEvent("okokTalk:gymdangki")
AddEventHandler("okokTalk:gymdangki", function()
	TriggerEvent("qg-gym:dangki")
end)
RegisterNetEvent("okokTalk:thioto")
AddEventHandler("okokTalk:thioto", function()
	TriggerServerEvent('osm-drivetest:server:JoinRace', 'issi2')
end)
RegisterNetEvent("okokTalk:thixm")
AddEventHandler("okokTalk:thixm", function()
	TriggerServerEvent('osm-drivetest:server:JoinRace', 'bati')
end)
RegisterNetEvent("okokTalk:doikeo")
AddEventHandler("okokTalk:doikeo", function()
	TriggerServerEvent("inventory:server:OpenInventory", "crafting_doikeo", math.random(1, 99), Crating)
end)



