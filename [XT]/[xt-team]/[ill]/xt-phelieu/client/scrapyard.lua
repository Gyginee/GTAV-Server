local CurrentCops = 0

CreateThread(function()
    while true do
        Wait(4)
        if LoggedIn then
            local ped = PlayerPedId()
            local PlayerCoords = GetEntityCoords(ped)
            for k, v in pairs(Config.ScrapyardLocations) do
                local Area = #(PlayerCoords - v.dis)
                if Area < 7.5 then
                    DrawText3D(v.dis.x, v.dis.y, v.dis.z, "[~g~E~s~] - Rã xe")
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent('xt-phelieu:client:scrap:vehicle')
                    end
                end
            end
        end
    end
end)
local function RequestAnimationDict(AnimDict)
    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Wait(1)
    end
  end
local function ScrapVehicleAnim(time)
    time = (time / 1000)
    local ped = PlayerPedId()
    RequestAnimationDict("mp_car_bomb")
    TaskPlayAnim(ped, "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    Scrapping = true
    CreateThread(function()
        while Scrapping do
            TaskPlayAnim(ped, "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
			time = time - 2
            if time <= 0 then
                Scrapping = false
                StopAnimTask(ped, "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end
RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(Amount)
    CurrentCops = Amount
end)

RegisterNetEvent('xt-phelieu:client:scrap:vehicle', function()
    local ped = PlayerPedId()
    local Vehicle = GetVehiclePedIsIn(ped, true)
    local driver = GetPedInVehicleSeat(Vehicle, -1)
    if driver == ped then
        if CurrentCops >= Config.PoliceNeeded then
            if Config.CanScrap then
                local Time = math.random(55000, 65000)
                Config.CanScrap = false
                ScrapVehicleAnim(Time)
                TriggerEvent('inventory:client:set:busy', true)
                QBCore.Functions.Progressbar("scrap-vehicle", "Rã phương tiện", Time, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    QBCore.Functions.DeleteVehicle(Vehicle)
                    StopAnimTask(ped, "mp_car_bomb", "car_bomb_mechanic", 1.0)
                    TriggerServerEvent('xt-phelieu:server:scrap:reward')
                    TriggerEvent('inventory:client:set:busy', false)
                    SetTimeout(((1000 * 60) * tonumber(Config.ScrapTime)), function()
                        Config.CanScrap = true
                    end)
                end)
            else
                exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải chờ "..Config.ScrapTime.." phút để rã xe tiếp", 3000, 'error')
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Phải có "..Config.PoliceNeeded.." cảnh sát mới có thể rã xe. Hiện tại có: "..CurrentCops.."cảnh sát", 3000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn phải ngồi ở vị trí tài xế", 3000, 'error')
    end
end)