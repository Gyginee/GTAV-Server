QBCore = exports['qb-core']:GetCoreObject()
local Time = 15
local thongbao = false
local devMode = false
local renderBanner = false

RegisterNetEvent('cuchi_adbanner:client:thongbao')
AddEventHandler('cuchi_adbanner:client:thongbao', function()
    thongbao = true
    Time = 30
    while thongbao do
        if Time > 0 then
            print(Time)
            Citizen.Wait(1000)
        end
        if Time > 5 then
            TriggerServerEvent('InteractSound_SV:PlayOnAll',"thongbao", 0.5)
            TriggerServerEvent("cadBanner:callServer", true, {102, 194, 255, 255},"Thành phố MAFIA TOWN xin thông báo: " ..Time.. " phút nữa Thành phố sẽ cúp điện" , {255, 255, 255, 255}, 12)
            Time = Time - 5
            Citizen.Wait(60000 * 5)
        elseif Time <= 5 and Time > 0 then
            TriggerServerEvent('InteractSound_SV:PlayOnAll',"thongbao", 0.5)
            TriggerServerEvent("cadBanner:callServer", true, {102, 194, 255, 255},"Thành phố MAFIA TOWN xin thông báo: " ..Time.. " phút nữa Thành phố sẽ cúp điện" , {255, 255, 255, 255}, 12)
            Time = Time - 1
            Citizen.Wait(60000)
        elseif time == 0 then    
            TriggerServerEvent("cadBanner:callServer", true, {102, 194, 255, 255},"Thành phố MAFIA TOWN xin thông báo: Thành phố cúp điện" , {255, 255, 255, 255}, 12)
            Time = Time - 1
        else
            thongbao = false
        end
    end
end)
RegisterNetEvent('cuchi_adbanner:client:huy')
AddEventHandler('cuchi_adbanner:client:huy', function()
    Time = 0
    thongbao = false
end)
RegisterNetEvent('cuchi_adbanner:client:test')
AddEventHandler('cuchi_adbanner:client:test', function()
    TriggerServerEvent('InteractSound_SV:PlayOnAll',"thongbao", 0.5)
    TriggerServerEvent("cadBanner:callServer", true, {255, 10, 10, 255},"Có chạy" , {255, 255, 255, 255}, 5)
    Citizen.Wait(60000)
end)
local currentScreenPosition = nil
local position = { x = 0.0, y = 0.0 }
local currentIndex = 0
function DrawBanner(topOfScreen, rgbaColor, text, textColor, _currentIndex)
    CreateThread(function() 
        local cIndex = _currentIndex
        while not NetworkIsSessionStarted() do Wait(100) end
        if topOfScreen then position = { x = 1.0, y = 0.0075 } else position = { x = 1.0, y = 0.960 } end
        while renderBanner do
            Wait(0)
            if topOfScreen then
                currentScreenPosition = "top"
                DrawRect(0.5, 0.0, 1.0, 0.1, rgbaColor[1], rgbaColor[2], rgbaColor[3], rgbaColor[4])
                DrawTexts(position, text, textColor)
                UpdatePosition()
            else
                currentScreenPosition = "bottom"
                DrawRect(0.5, 1.0, 1.0, 0.1, rgbaColor[1], rgbaColor[2], rgbaColor[3], rgbaColor[4])
                DrawTexts(position, text, textColor)
                UpdatePosition()
            end

            if cIndex ~= currentIndex then
                break
            end
        end
    end)
end

function UpdatePosition()
    if position.x <= 0.0 then 
        position.x = 1.0 
    else
        position.x = position.x - 0.0015
    end
end

function DrawTexts(_position, text, color)
    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_position.x, _position.y)
end

RegisterNetEvent("cadBanner:Draw")
AddEventHandler("cadBanner:Draw", function(data, _currentIndex)
    renderBanner = true
    currentIndex = _currentIndex
    DrawBanner(data.topOfScreen, data.bannerColor, data.text, data.textColor, _currentIndex) 
end)

RegisterNetEvent("cadBanner:Destruct")
AddEventHandler("cadBanner:Destruct", function()
    renderBanner = false
end)
