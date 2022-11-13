local labels = {}
local image = {}
local craftingQueue = {}
local job = ""
local grade = 0
QBCore = exports['qb-core']:GetCoreObject()
Citizen.CreateThread(function()
    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    job = QBCore.Functions.GetPlayerData().job.name
    grade = QBCore.Functions.GetPlayerData().job.grade.level
    for k, v in pairs(QBCore.Shared.Items) do
        labels[k] = v.label
        image[k] = v.image
    end
    for _, v in ipairs(Config.Workbenches) do
        if v.blip then
            local blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, Config.BlipSprite)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, Config.BlipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate",function(j)
        job = j.name
        grade = j.grade.level
end)

function isNearWorkbench()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local near = false
    for _, v in ipairs(Config.Workbenches) do
        local dst = #(coords - v.coords)
        if dst < v.radius then
            near = true
        end
    end
    if near then
        return true
    else
        return false
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if craftingQueue[1] ~= nil then
                if not Config.CraftingStopWithDistance or (Config.CraftingStopWithDistance and isNearWorkbench()) then
                    craftingQueue[1].time = craftingQueue[1].time - 1
                    SendNUIMessage(
                        {
                            type = "addqueue",
                            item = craftingQueue[1].item,
                            time = craftingQueue[1].time,
                            exp = craftingQueue[1].exp,
                            id = craftingQueue[1].id
                        }
                    )
                    if craftingQueue[1].time == 0 then
                        TriggerServerEvent("core_crafting:itemCrafted", craftingQueue[1].item, craftingQueue[1].count)
                        table.remove(craftingQueue, 1)
                    end
                end
            end
        end
    end
)

function openWorkbench(val)
    local inv = {}
    local recipes = {}
    SetNuiFocus(true, true)
    TriggerScreenblurFadeIn(1000)
    local player = QBCore.Functions.GetPlayerData()
    local xp = player.metadata['craftingrep']
    for _, v in ipairs(player.items) do
        inv[v.name] = v.amount
    end
    if #val.recipes > 0 then
        for _, g in ipairs(val.recipes) do
            recipes[g] = Config.Recipes[g]
        end
    else
        recipes = Config.Recipes
    end
    SendNUIMessage ({
        type = "open",
        recipes = recipes,
        names = labels,
        image = image,
        level = xp,
        inventory = inv,
        job = job,
        grade = grade,
        hidecraft = Config.HideWhenCantCraft,
        categories = Config.Categories
    })
end

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            for k, v in ipairs(Config.Workbenches) do
                local dst = #(coords - v.coords)
                if dst < 3 then
                    DrawText3D(v.coords[1], v.coords[2], v.coords[3] + 0.3, '[~b~E~s~] - Chế tạo')
                end
                if dst < 2 then
                    if IsControlJustReleased(0, 38) then
                        local open = false
                        for j, g in ipairs(v.jobs) do
                            if g == job then
                                for x, z in ipairs(v.grades) do
                                    if tostring(z) == tostring(grade) then
                                        open = true
                                    end
                                end
                            end
                        end

                        if open or #v.jobs == 0 or (#v.grades == 0 and #v.jobs ~= 0) then
                            openWorkbench(v)
                        else
                            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn không dùng được bán chế tạo này", 5000, 'error')
                        end
                    end
                end
            end
        end
    end)

RegisterNetEvent("open:workbench")
AddEventHandler("open:workbench", function()
    for _, v in ipairs(Config.Workbenches) do
        local open = false
        for _, g in ipairs(v.jobs) do
            if g == job then
                open = true
            end
        end

        if open or #v.jobs == 0 then
            openWorkbench(v)
        else
            exports['xt-notify']:Alert("HỆ THỐNG", "Bạn không dùng được bán chế tạo này", 5000, 'error')
        end
    end
end)

RegisterNetEvent("core_crafting:craftStart")
AddEventHandler(
    "core_crafting:craftStart",
    function(item, count)
        local id = math.random(000, 999)
        table.insert(craftingQueue, {time = Config.Recipes[item].Time, item = item, count = Config.Recipes[item].Amount, id = id})

        SendNUIMessage(
            {
                type = "crafting",
                item = item
            }
        )

        SendNUIMessage(
            {
                type = "addqueue",
                item = item,
                time = Config.Recipes[item].Time,
                id = id
            }
        )
    end
)

RegisterNUICallback(
    "close",
    function(data)
        TriggerScreenblurFadeOut(1000)
        SetNuiFocus(false, false)
    end
)

RegisterNUICallback(
    "craft",
    function(data)
        local item = data["item"]
        TriggerServerEvent("core_crafting:craft", item, false)
    end
)

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end