Settings = {
    KeepEngineOn = false, ---Keeps The engine on after leaving the vehicle if the engine is on,
    NPCCheck = true --- Adds NPC Check to the code(Checks if there is any ped inside vehicle or not)
}
local function CanSit(veh)
    if not Settings.NPCCheck then 
        return true 
    end
    for i = -1, 15 do
        if IsEntityAPed(GetPedInVehicleSeat(veh, i)) then return false end
    end
    return true
end

CreateThread(function()
    local dist, index,ped
    while true do
        if IsControlJustPressed(0, 75) then
            ped = PlayerPedId()
            if IsPedInAnyVehicle(ped) then
                if Settings.KeepEngineOn then
                    local veh = GetVehiclePedIsIn(ped)
                    if GetIsVehicleEngineRunning(veh) then
                        TaskLeaveVehicle(ped, veh, 0)
                        Wait(1000)
                        SetVehicleEngineOn(veh, true, true, true)
                    end
                end
            else
                local veh = GetVehiclePedIsTryingToEnter(ped)
                if veh ~= 0 then
                    if CanSit(veh) then
                        local coords = GetEntityCoords(ped)
                        if #(coords - GetEntityCoords(veh)) <= 3.5 then
                            ClearPedTasks(ped)
                            ClearPedSecondaryTask(ped)
                            for i = 0, GetNumberOfVehicleDoors(veh), 1 do
                                local coord = GetEntryPositionOfDoor(veh, i)
                                if (IsVehicleSeatFree(veh, i - 1) and
                                    GetVehicleDoorLockStatus(veh) ~= 2) then
                                    if dist == nil then
                                        dist = #(coords - coord)
                                        index = i
                                    end
                                    if #(coords - coord) < dist then
                                        dist = #(coords - coord)
                                        index = i
                                    end
                                end
                            end
                            if index then
                                TaskEnterVehicle(ped, veh, 10000, index - 1,1.0, 1, 0)
                            end
                            index, dist = nil, nil
                        end
                    end
                end
            end
        end
        Wait(1)
    end
end)
-- Khi bắn súng trong xe sẽ tự đổi góc nhìn thứ nhất
local shot = false
local check = false
local check2 = false
local count = 0

CreateThread(function()
    while true do
        SetBlackout(false)
        Wait(1)
        if IsPlayerFreeAiming(PlayerId()) then
            if GetFollowPedCamViewMode() == 4 and check == false then
                check = false
            else
                SetFollowVehicleCamViewMode(4)
                check = true
            end
        else
            if check == true then
                SetFollowVehicleCamViewMode(1)
                check = false
            end
        end
    end
end)



CreateThread(function()
    while true do
        SetBlackout(false)
        Wait(1)

        if IsPedShooting(PlayerPedId()) and shot == false and GetFollowPedCamViewMode() ~= 4 then
            check2 = true
            shot = true
            SetFollowVehicleCamViewMode(4)
        end

        if IsPedShooting(PlayerPedId()) and shot == true and GetFollowPedCamViewMode() == 4 then
            count = 0
        end

        if not IsPedShooting(PlayerPedId()) and shot == true then
            count = count + 1
        end

        if not IsPedShooting(PlayerPedId()) and shot == true then
            if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
                if check2 == true then
                    check2 = false
                    shot = false
                    SetFollowVehicleCamViewMode(1)
                end
            end
        end
    end
end)


-- Tàu chạy trong thành phố
CreateThread(function()
    SwitchTrainTrack(0, true)
    SwitchTrainTrack(3, true)
    N_0x21973bbf8d17edfa(0, 120000)
    SetRandomTrains(1)
  end)