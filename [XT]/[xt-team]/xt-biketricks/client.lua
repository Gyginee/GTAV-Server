local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["SHIFT"] = 155, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 111, ["N9"] = 118
}

QBCore = exports['qb-core']:GetCoreObject()
local anims={
    animations = {
    dict = "rcmextreme2atv",
    [1] = "idle_b",
    [2] = "idle_c",
    [3] = "idle_a", 
    [4] = "idle_d", 
    [5] = "idle_e",
    }
}
Utils = {
    LeftNacNac = function()
        local ped = GetPlayerPed()
        local ad = anims.animations.dict
        local anim = anims.animations[1]
        Utils.loadAnimDict(ad)
        Utils.PlayAnim(ped, ad, anim,0.0, 0.0, 1000, 01, 0, 0, 0, 0)
        ClearPedSecondaryTask(ped)
    end,
    RightNacNac = function()
        local ped = GetPlayerPed()
        local ad = anims.animations.dict
        local anim = anims.animations[2]
        Utils.loadAnimDict(ad)
        Utils.PlayAnim(ped, ad, anim,0.0, 0.0, 1000, 01, 0, 0, 0, 0)
        ClearPedSecondaryTask(ped)
    end,
    NoHandZone = function()
        local ped = GetPlayerPed()
        local ad = anims.animations.dict
        local anim = anims.animations[3]
        Utils.loadAnimDict(ad)
        Utils.PlayAnim(ped, ad, anim,0.0, 0.0, 1000, 01, 0, 0, 0, 0)
        ClearPedSecondaryTask(ped)
    end,
    HopScotch = function()
        local ped = GetPlayerPed()
        local ad = anims.animations.dict
        local anim = anims.animations[4]
        Utils.loadAnimDict(ad)
        Utils.PlayAnim(ped, ad, anim,0.0, 0.0, 1000, 01, 0, 0, 0, 0)
        ClearPedSecondaryTask(ped)
    end,
    Egyptian = function()
        local ped = GetPlayerPed()
        local ad = anims.animations.dict
        local anim = anims.animations[5]
        Utils.loadAnimDict(ad)
        Utils.PlayAnim(ped, ad, anim,0.0, 0.0, 1000, 01, 0, 0, 0, 0)
        ClearPedSecondaryTask(ped)
    end,
    loadAnimDict = function(dict)
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            Citizen.Wait(0)
        end
    end,
    PlayAnim = function(ped, ad, anim,...)
        TaskPlayAnim(ped,ad,anim,...)
    end,
    Sleep = function(wait)
        Wait(wait)
    end,
    toboolean = function(bool)
        if bool then
            return true
        else
            return false
        end
    end,
};

fnTable = {
    [1] = Utils.LeftNacNac,
    [2] = Utils.RightNacNac,
    [3] = Utils.NoHandZone,
    [4] = Utils.HopScotch,
    [5] = Utils.Egyptian,
    [6] = Utils.toboolean(true),
    [7] = 1000
};

Citizen.CreateThread(function()
    while true do
        if fnTable[6] then
        local ped = GetPlayerPed()
        local veh = GetVehiclePedIsIn(ped, false)
        local model = GetEntityModel(veh)
        local ragdoll = IsPedRagdoll(ped)
        local bicycle = IsThisModelABicycle(model)
        local motorcycle = IsThisModelABike(model)
        local veh = GetVehiclePedIsIn(ped, false)
        if (motorcycle and not ragdoll) or (not ragdoll and bicycle) then
        if IsControlPressed(0, Keys["SHIFT"]) then

            if IsControlJustReleased(0, Keys["N6"]) then -- Left Nac Nac! | numpad 6
                repeat
                fnTable[1]();
                Utils.Sleep(fnTable[7]);
                exports['xt-notify']:Alert("HỆ THỐNG", "Dân chơi: Sol Nac Nac !!", 5000, 'info')
                until not IsControlJustReleased(0, Keys["N6"])

            elseif IsControlJustReleased(0, Keys["N4"]) then -- Right Nac Nac | numpad 4
                repeat
                fnTable[2]();
                Utils.Sleep(fnTable[7]);
                exports['xt-notify']:Alert("HỆ THỐNG", "Dân chơi: Sol Nac Nac !!", 5000, 'info')
                until not IsControlJustReleased(0, Keys["N4"])

            elseif IsControlJustReleased(0, Keys["N5"]) then -- No Hand Zone | numpad 5
                repeat
                fnTable[3]();
                Utils.Sleep(fnTable[7]);
                exports['xt-notify']:Alert("HỆ THỐNG", "Dân chơi: Buông đôi tay nhau ra !!", 5000, 'info')
                until not IsControlJustReleased(0, Keys["N5"])

            elseif IsControlJustReleased(0, Keys["N8"]) then -- numpad 8
                repeat
                fnTable[4]();
                Utils.Sleep(fnTable[7]);
                exports['xt-notify']:Alert("HỆ THỐNG", "Dân chơi: Nhảy, nhảy đi!!", 5000, 'info')
               
                until not IsControlJustReleased(0, Keys["N8"])
                
            elseif IsControlJustReleased(0, Keys["N7"]) then -- numpad 7
                repeat
                fnTable[5]();
                Utils.Sleep(fnTable[7]);
                exports['xt-notify']:Alert("HỆ THỐNG", "Dân chơi: Sol Nac Nac !!", 5000, 'info')
                
                until not IsControlJustReleased(0, Keys["N7"])
            end
        end
        end
        end
        Citizen.Wait(25)
    end
end)