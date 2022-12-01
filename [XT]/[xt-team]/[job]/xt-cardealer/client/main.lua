QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
inRange = false
local vehicleCategorys = {
    ["coupes"] = {
        label = "Coupes",
        vehicles = {}
    },
    ["sedans"] = {
        label = "Sedans",
        vehicles = {}
    },
    ["muscle"] = {
        label = "Muscle",
        vehicles = {}
    },
    ["suvs"] = {
        label = "SUVs",
        vehicles = {}
    },
    ["compacts"] = {
        label = "Compacts",
        vehicles = {}
    },
    ["vans"] = {
        label = "Vans",
        vehicles = {}
    },
    ["super"] = {
        label = "Super",
        vehicles = {}
    },
    ["sports"] = {
        label = "Sports",
        vehicles = {}
    },
    ["sportsclassics"] = {
        label = "Sports Classics",
        vehicles = {}
    },
    ["motorcycles"] = {
        label = "Motorcycles",
        vehicles = {}
    },
    ["offroad"] = {
        label = "Offroad",
        vehicles = {}
    },
    ["emergency"] = {
        label = "Emergency",
        vehicles = {}
    },
}
local function DrawText3D(x, y, z, text)
	SetTextScale(0.3, 0.3)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
local function noSpace(str)
    local normalisedString = string.gsub(str, "%s+", "")
    return normalisedString
end
local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end
	return nearbyEntities
end
local GetVehiclesInArea = function(coords, maxDistance)
	return EnumerateEntitiesWithinDistance(QBCore.Functions.GetVehicles(), false, coords, maxDistance)
end

CreateThread(function()
    Wait(1000)
    for k, v in pairs(QBCore.Shared.Vehicles) do
        if v["shop"] == "pdm" then
            for cat,_ in pairs(vehicleCategorys) do
                if QBCore.Shared.Vehicles[k]["category"] == cat then
                    table.insert(vehicleCategorys[cat].vehicles, QBCore.Shared.Vehicles[k])
                end
            end
        end
    end
end)
CreateThread(function()
    while true do
        local sleep = 1000
        if isLoggedIn then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k, v in pairs(Config.ShowroomLocation) do
                local dist = #(pos - v.dist)
                if dist < 2.5 then
                    sleep = 5
                    DrawText3D(v.dist.x, v.dist.y, v.dist.z, "[~g~E~s~] - Chọn xe")
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent('xt-cardealer:client:ShowroomVehicleCategories', v.spawn)
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

-- show menus

RegisterNetEvent("xt-cardealer:client:SpawnShowroom", function(data)
    local model = data.tenxe
    local display = data.vitri
    local vehinarea = GetVehiclesInArea(vector3(display.x,display.y,display.z), 1)
    if #vehinarea ~= 0 then
        QBCore.Functions.DeleteVehicle(vehinarea[1])
    end
    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetEntityCoords(veh, display.x, display.y, display.z)
        SetEntityHeading(veh, display.w)
        SetVehicleNumberPlateText(veh, "XEBAN")
        FreezeEntityPosition(veh, true)
    end)
end)

RegisterNetEvent("xt-cardealer:client:ClearShowroom", function(vitri)
        local vehicles = GetGamePool('CVehicle')
        for z, x in pairs(vehicles) do
            if #(vector3(vitri.x, vitri.y, vitri.z) - GetEntityCoords(x)) <= 5.0 then
                SetEntityAsMissionEntity(x, true, true)
                TriggerEvent('persistent-vehicles/forget-vehicle', x)
                DeleteVehicle(x)
            end
        end
    exports['xt-notify']:Alert("THÔNG BÁO", "Đã dọn Showroom", 5000, 'success')
end)

RegisterNetEvent("xt-cardealer:client:ShowroomVehicleCategories", function(data)
    local VehicleCategoryOptions = {
        {
            header = "Danh sách loại xe",
            txt = "📝 Danh sách các loại xe có trong cửa hàng",
            isMenuHeader = true
        },
    }

    VehicleCategoryOptions[#VehicleCategoryOptions+1] = {
        header = "Dọn Showroom",
        txt = "🔧 Cất phương tiện ở vị trí này",
        params = {
            event = "xt-cardealer:client:ClearShowroom",
            args = data
        }
    }

    for k, v in pairs(vehicleCategorys) do
        VehicleCategoryOptions[#VehicleCategoryOptions+1] = {
            header = v.label,
            txt = "",
            params = {
                event = "xt-cardealer:client:ShowroomVehicleList",
                args = {
                   class =  k,
                   vitri = data}
            }
        }
    end

    VehicleCategoryOptions[#VehicleCategoryOptions+1] = {
        header = "❌ Thoát",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    }
    exports['qb-menu']:openMenu(VehicleCategoryOptions)

end)



RegisterNetEvent("xt-cardealer:client:ShowroomVehicleList", function(data)
    local class = data.class
    local vitri = data.vitri
    local VehicleStockOptions = {
            {
                header = "Danh sách Xe",
                txt = "📝 Danh sách các xe có trong cửa hàng",
                    isMenuHeader = true
                },
            }

            for k, v in pairs(vehicleCategorys[class].vehicles) do
                VehicleStockOptions[#VehicleStockOptions + 1] = {
                    header = v.brand.." "..v.name,
                    txt = "💵 Giá bán : "..v.price.."$ ",
                    params = {
                        event = "xt-cardealer:client:SpawnShowroom",
                        args = {
                        tenxe =   v.model,
                        vitri=  vitri
                    },
                    }
                }
            end
            VehicleStockOptions[#VehicleStockOptions+1] = {
                header = "❌ Thoát",
                txt = "",
                params = {
                    event = "qb-menu:closeMenu",
                }
            }
            exports['qb-menu']:openMenu(VehicleStockOptions)

end)



-- SALE EVENTS/FUNCTIONS
RegisterNetEvent('xt-cardealer:client:banxe',function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    local model = GetEntityModel(veh)
    local plate = GetVehicleNumberPlateText(veh)
    local vehmodel
        if noSpace(plate) == "XEBAN" then
            for k,v in pairs(vehicleCategorys) do
                for _k, _v in pairs (v.vehicles) do
                    local hash = _v.hash
                    if hash == model then
                        vehmodel = _v.model
                        TriggerServerEvent('xt-cardealer:server:muaxe', vehmodel, _v.price)
                    end
                end
            end
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không thể mua phương tiện  này", 5000, 'error')
        end
end)



RegisterNetEvent('xt-cardealer:client:setOwner',function(plate)
    local coords = GetEntityCoords(PlayerPedId())
    local vehicle = QBCore.Functions.GetClosestVehicle(coords)
    exports['xt-vehiclekeys']:SetVehicleKey(plate, true)
    SetVehicleNumberPlateText(vehicle, plate:gsub("%s+", ""))
    FreezeEntityPosition(vehicle, false)
end)


--TESTDRIVE
local laithu = false
RegisterNetEvent('xt-cardealer:client:TestDrive', function()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    local plate = GetVehicleNumberPlateText(veh)
    if laithu == false then
        if noSpace(plate) == "XEBAN" then
            SetVehicleNumberPlateText(veh, "XETEST"..tostring(math.random(000, 999)))
            exports['ps-fuel']:SetFuel(veh, 100.0)
            exports['xt-vehiclekeys']:SetVehicleKey(QBCore.Functions.GetPlate(veh), true)
            SetVehicleEngineOn(veh, true, true)
            FreezeEntityPosition(veh, false)
            local props = QBCore.Functions.GetVehicleProperties(veh)
            local hash = props.model
            laithu = true
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn được lái thử chiếc xe này trong "..Config.TestDriveTimer.." giây", 5000, 'info')
            SetTimeout(Config.TestDriveTimer*1000, function()
                if DoesEntityExist(veh) then
                    QBCore.Functions.DeleteVehicle(veh)
                    laithu = false
                    exports['xt-notify']:Alert("THÔNG BÁO", "Đã hết thời gian lái thử", 5000, 'error')
                end
            end)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không thể làm thế với chiếc xe này", 5000, 'error')
        end
    else
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang trong thời gian lái thử xe khác", 5000, 'error')
    end
end)




CreateThread(function()
    local blip = AddBlipForCoord(126.64, -151.32, 54.8)
	SetBlipSprite(blip, 225)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.7)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 74)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("BIG-CarAuto")
	EndTextCommandSetBlipName(blip)
end)

