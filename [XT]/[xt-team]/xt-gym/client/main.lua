QBCore = exports['qb-core']:GetCoreObject()

local training = false
local resting = false
local membership = false

local function CheckTraining()
	if resting == true then
        exports['xt-notify']:Alert( "HỆ THỐNG" ,"Bạn đang nghỉ ngơi" , 5000 , 'warning')
		resting = false
		Wait(60000)
		training = false
	end
	if resting == false then
        exports['xt-notify']:Alert( "HỆ THỐNG" ,"Bây giờ bạn có thể tập gym trở lại" , 5000 , 'success')
	end
end

RegisterNetEvent('xt-gym:dangki', function()
	TriggerServerEvent('xt-gym:buyMembership')
end)
CreateThread(function()
	blip = AddBlipForCoord(-1201.2257, -1568.8670, 4.6101)
	SetBlipSprite(blip, 311)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 7)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Gym')
	EndTextCommandSetBlipName(blip)
end)
RegisterNetEvent('xt-gym:trueMembership', function()
	membership = true
end)
RegisterNetEvent('xt-gym:falseMembership', function()
	membership = false
end)
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
local AllProps = {}
local HasProp = false

local function RemoveProp()
    for k, v in pairs(AllProps) do
       NetworkRequestControlOfEntity(v)
       SetEntityAsMissionEntity(v, true, true)
       DetachEntity(v, 1, 1)
       DeleteEntity(v)
       DeleteObject(v)
    end
      AllProps = {}
      HasProp = false
  end
CreateThread(function()
    while true do
        sleep = 1000
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k, v in pairs(Config.Locations) do
                local dist = #(pos - vector3(Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z))
                if dist < 4.5 then
                    if dist < Config.Locations[k].viewDistance then
                        sleep = 0
                        DrawText3D(Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z, Config.Locations[k].Text3D)
                        if IsControlJustReleased(0, 38) then
                            if training == false then
                                TriggerServerEvent('xt-gym:checkChip')
                                exports['xt-notify']:Alert( "HỆ THỐNG" ,"Chuẩn bị bài tập gym" , 5000 , 'success')
                                Wait(1000)
                                if membership == true then
                                    SetEntityHeading(ped, Config.Locations[k].heading)
                                    SetEntityCoords(ped, Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z - 1)
                                    TaskStartScenarioInPlace(ped, Config.Locations[k].animation, 0, true)
                                    Wait(30000)
                                    ClearPedTasksImmediately(ped)
									exports['xt-notify']:Alert( "HỆ THỐNG" ,"Bạn cần nghỉ 60 giây trước khi thực hiện bài tập khác " , 5000 , 'error')
                                    training = true
                                    resting = true
                                    CheckTraining()
									RemoveProp()
                                elseif membership == false then
                                    exports['xt-notify']:Alert( "HỆ THỐNG" ,"Bạn cần phải là thành viên để thực hiện bài tập này " , 5000 , 'error')
                                end
                            elseif training == true then
                                exports['xt-notify']:Alert( "HỆ THỐNG" ,"Bạn cần nghỉ một chút" , 5000 , 'error')
                                resting = true
                                CheckTraining()
                            end
                        end
                    end
                end
            end
		Wait(sleep)
    end
end)
