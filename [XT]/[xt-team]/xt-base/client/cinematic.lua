local isRunning = false
local runningSize = 0

local function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
    HideHudComponentThisFrame(1)
    HideHudComponentThisFrame(2)
    HideHudComponentThisFrame(3)
    HideHudComponentThisFrame(4)
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(13)
    HideHudComponentThisFrame(11)
    HideHudComponentThisFrame(12)
    HideHudComponentThisFrame(15)
    HideHudComponentThisFrame(18)
    HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
end

RegisterNetEvent('xt-base:client:cinematic', function(size) --size value from 1 to 10(0 remove the bar)
    local size= size/10 --drawrect need value from 0.0 to 1
    if isRunning and size==0 then --kill process if is running and size==0 to prevent memory consumption
        isRunning = false
    else
        if isRunning then 
            runningSize = size --change size if is already running
        else --create process if is not already running
            runningSize = size
            isRunning = true
            while isRunning do
                Wait(2)
                HideHUDThisFrame()
                DrawRect(1.0, 1.0, 2.0, runningSize, 0, 0, 0, 255)
                DrawRect(1.0, 0.0, 2.0, runningSize, 0, 0, 0, 255)
            end
        end
    end  
end)