local GotHit = false
local CurrentBin = nil

CreateThread(function()
    while true do
        Wait(4)
        if LoggedIn then
            local ped = PlayerPedId()
            local StartShape = GetOffsetFromEntityInWorldCoords(ped, 0, 0.1, 0)
            local EndShape = GetOffsetFromEntityInWorldCoords(ped, 0, 1.8, -0.4)
            local RayCast = StartShapeTestRay(StartShape.x, StartShape.y, StartShape.z, EndShape.x, EndShape.y, EndShape.z, 16, ped, 0)
            local Retval, Hit, Coords, Surface, EntityHit = GetShapeTestResult(RayCast)
            local BinModel = 0
            GotHit = false
            if EntityHit then
                local BinModel = GetEntityModel(EntityHit)
                for k, v in pairs(Config.Dumpsters) do
                    if v['Model'] == BinModel then
                        GotHit = true
                        local pedCoords = GetEntityCoords(PlayerPedId())
                        CurrentBin = GetClosestObjectOfType(pedCoords, 2.5, BinModel, false)
                    end
                end
            end
            if not GotHit then
               Wait(1500)
               CurrentBin = nil
            end
        else
            Wait(1500)
        end
    end
end) 

RegisterNetEvent('xt-phelieu:client:search:trash', function()
    if CurrentBin ~= nil then
      if not Config.OpenedBins[CurrentBin] then
            local ped = PlayerPedId()
            TriggerEvent('inventory:client:set:busy', true)
            QBCore.Functions.Progressbar("search-trash", "Tìm kiếm", math.random(10000, 12500), false, true, {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'mini@repair',
                anim = 'fixing_a_ped',
                flags = 16,
            }, {}, {}, function() -- Done
                SetBinUsed(CurrentBin)
                QBCore.Functions.TriggerCallback('xt-phelieu:server:get:reward', function()
                end)
                StopAnimTask(ped, 'mini@repair', "fixing_a_ped", 1.0)
                TriggerEvent('inventory:client:set:busy', false)
            end, function() -- Cancel
                StopAnimTask(ped, 'mini@repair', "fixing_a_ped", 1.0)
                exports['xt-notify']:Alert("THÔNG BÁO", "Thất bại", 3000, 'error')
                TriggerEvent('inventory:client:set:busy', false)
            end)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã lục thùng rác rồi", 3000, 'error')
            TriggerEvent('inventory:client:set:busy', false)
        end
    end
end)

function SetBinUsed(BinNumber)
    if BinNumber ~= nil then
    Config.OpenedBins[BinNumber] = true
    SetTimeout((1000*120), function()
        Config.OpenedBins[BinNumber] = false
    end)
    else
    return false
    end
end