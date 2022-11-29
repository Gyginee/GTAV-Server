--------------------
QBCore = exports['qb-core']:GetCoreObject()

local pedcoords =  Config.Ped
local cped

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
end

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local ped = "csb_thornton"
                local dist = #(pos - vector3(pedcoords.x, pedcoords.y, pedcoords.z))
                if dist <= 25.0  then
                    sleep = 5
                    if not DoesEntityExist(cped) then
                        RequestModel(ped)
                    while not HasModelLoaded(ped) do
                        Wait(10)
                    end
                    cped = CreatePed(26, ped, pedcoords.x, pedcoords.y, pedcoords.z, pedcoords.w, false, false)
                    SetEntityHeading(cped, pedcoords.w)
                    FreezeEntityPosition(cped, true)
                    SetEntityInvincible(cped, true)
                    SetBlockingOfNonTemporaryEvents(cped, true)
                    TaskStartScenarioInPlace(cped, "WORLD_HUMAN_CLIPBOARD", 0, false)
                    end
                else
                    sleep = 1500
                end
                if dist <= 5.0 then
                    DrawText3D(pedcoords.x, pedcoords.y, pedcoords.z + 1.9, "~o~Nhân Viên")
                end
    Wait(sleep)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    exports['qb-target']:AddCircleZone("giayto", vector3(pedcoords.x, pedcoords.y, pedcoords.z), 2.0, {
        name="giayto",
        debugPoly=false,
        useZ=true,
        }, {
        options = {
        {
        type = "client",
        event = "xt-driverlicense:client:requestID",
        icon = "fa-solid fa-id-card",
        label = "Nhận CCCD",
        },
        {
        type = "client",
        event = "xt-driverlicense:client:requestDL",
        icon = "fa-solid fa-file-certificate",
        label = "Nhận bằng lái xe",
        },
    },
    distance = 2.0
    })
end)
RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('xt-driverlicense:client:requestID')
AddEventHandler('xt-driverlicense:client:requestID', function()
    TriggerServerEvent('xt-driverlicense:server:requestId',id_card)
    exports['xt-notify']:Alert("THÔNG BÁO", "Đã nhận x1 thẻ căn cước công dân", 5000, 'success')


end)
RegisterNetEvent('xt-driverlicense:client:requestDL')
AddEventHandler('xt-driverlicense:client:requestDL', function()
    TriggerServerEvent('xt-driverlicense:server:requestId',driver_license)
    exports['xt-notify']:Alert("THÔNG BÁO", "Đã nhạn được bằng lái xe!", 5000, 'success')
end)