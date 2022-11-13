local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = nil
local thoigianonline = 0
local day1 = nil
local day2 = nil
local day3 = nil
local day4 = nil
local day5 = nil
local day6 = nil
local day7 = nil
local day8 = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        QBCore = exports['qb-core']:GetCoreObject()
        Citizen.Wait(0)
    end
    if PlayerData == nil then 
       PlayerData = QBCore.Functions.GetPlayerData()
    end
    QBCore.Functions.TriggerCallback('onemore_onlinenhanqua:retrievetime', function(time, day1, day2, day3, day4, day5, day6, day7, day8)
        checkra(time, day1, day2, day3, day4, day5, day6, day7, day8)
    end)
end)

function checkra(v, a, b, c, d, g, h, k, l)
    thoigianonline = v
    day1 = a
    day2 = b
    day3 = c
    day4 = d
    day5 = g
    day6 = h
    day7 = k
    day8 = l
    SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('onemore_onlinenhanqua:restartdiem')
AddEventHandler('onemore_onlinenhanqua:restartdiem', function()
    thoigianonline = 0
    day1 = nil
    day2 = nil
    day3 = nil
    day4 = nil
    day5 = nil
    day6 = nil
    day7 = nil
    day8 = nil
    SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
    QBCore.Functions.TriggerCallback('onemore_onlinenhanqua:retrievetime', function(time, day1, day2, day3, day4, day5, day6, day7, day8)
        checkra(time, day1, day2, day3, day4, day5, day6, day7, day8)
    end)
end)

Citizen.CreateThread(function()
	while true do
		Wait(60000)
		thoigianonline = thoigianonline + 1
        SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
        TriggerServerEvent('onemore_onlinenhanqua:updatetime', 1)
	end
end)
RegisterNetEvent('onemore_onlinenhanqua:open:ui')
AddEventHandler('onemore_onlinenhanqua:open:ui', function()
	toggle(true)
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) then
            toggle(false)
            SetNuiFocus(false, false)
		end
	end
end)
RegisterCommand('fixmenu', function()
    toggle(false)
    SetNuiFocus(false, false)
end)
RegisterNUICallback('closemenu', function(data, cb)
    SetNuiFocus(false, false)
	print(" Online Nhận Quà Make by OneMoreDilive l Nguyễn Bảo Toàn " )
end)

RegisterNUICallback('nhanqua1', function(data, cb)
    if day1 == "danhan" then 
        return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 30 then
        day1 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day1")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 30 phút", 2500, 'error')
    end
end)

RegisterNUICallback('nhanqua2', function(data, cb)
    if day2 == "danhan" then return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 120 then
        day2 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day2")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 120 phút", 2500, 'error')
    end
end)

RegisterNUICallback('nhanqua3', function(data, cb)
    if day3 == "danhan" then return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 180 then
        day3 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day3")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 180 phút", 2500, 'error')
    end
end)

RegisterNUICallback('nhanqua4', function(data, cb)
    if day4 == "danhan" then return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 240 then
        day4 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day4")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 240 phút", 2500, 'error')
    end
end)

RegisterNUICallback('nhanqua5', function(data, cb)
    if day5 == "danhan" then return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 300 then
        day5 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day5")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 300 phút", 2500, 'error')
    end
end)

RegisterNUICallback('nhanqua6', function(data, cb)
    if day6 == "danhan" then return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 360 then
        day6 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day6")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 360 phút", 2500, 'error')
    end
end)


RegisterNUICallback('nhanqua7', function(data, cb)
    if day7 == "danhan" then return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 420 then
        day7 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day7")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 420 phút", 2500, 'error')
    end
end)


RegisterNUICallback('nhanqua8', function(data, cb)
    if day8 == "danhan" then return exports['okokNotify']:Alert("THẤT BẠI", "Bạn đã nhận rồi", 2500, 'error') end
    if thoigianonline >= 500 then
        day8 = "danhan"
        open()
        TriggerServerEvent('onemore_onlinenhanqua:updateday', "day8")
        TriggerServerEvent('onemore_onlinenhanqua:nhanqua')
    else
        exports['okokNotify']:Alert("THẤT BẠI", "Bạn chưa đủ điền kiện online: 500 phút", 2500, 'error')
        ESX.ShowNotification('Bạn chưa đủ điền kiện online: 500 phút')
    end
end)


function open()
	PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
	SendNUIMessage({action = "update", online = thoigianonline, day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8})
end

function toggle(status)
    SendNUIMessage({
        action = "toggle", 
        show = status, 
        online = thoigianonline,
        day1 = day1, day2 = day2, day3 = day3, day4 = day4, day5 = day5, day6 = day6, day7 = day7, day8 = day8
    })
    SetNuiFocus(status, status)
end


local peds23 = {
        `a_m_y_smartcaspat_01`,
    }
    exports['qb-target']:AddTargetModel(peds23, {
        options = {
            {
                event = "onemore_onlinenhanqua:open:ui",
                icon = "fab fa-accusoft",
				type = "client",
                label = "Nhận Quà Hằng Ngày", 
            },
    },
    distance = 3.0
})

Citizen.CreateThread(function()
   
	print(GetHashKey(Config['NPCNAME']))
	RequestModel(GetHashKey(Config['NPCNAME']))
	while not HasModelLoaded(GetHashKey(Config['NPCNAME'])) do
		Wait(1)
	end
	
	for k,v in pairs(Config["Coords"]) do
		ped =  CreatePed(4, Config['NPCNAME'],v.coords.x,v.coords.y, v.coords.z-1, 3374176, false, true)
		SetEntityHeading(ped, v.coords.w)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		
		local dict = "abigail_mcs_2-4"
		while not HasAnimDictLoaded(dict) do
			RequestAnimDict(dict)
			Citizen.Wait(100)
		end
		TaskPlayAnim(ped, dict,"csb_abigail_dual-4", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		FreezeEntityPosition(ped, true)
		
		if v.HienBlip then 
			addBlip(v.coords, v.sprite, v.color, v.Name)
		end
		
	end	
end)



addBlip = function(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
	SetBlipScale(blip, 0.4)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end