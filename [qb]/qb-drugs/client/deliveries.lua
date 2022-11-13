local currentDealer = nil
local dealerIsHome = false
local waitingDelivery = nil
local activeDelivery = nil
local interacting = false
local deliveryTimeout = 0
local isHealingPerson = false
local healAnimDict = "mini@cpr@char_a@cpr_str"
local healAnim = "cpr_pumpchest"

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-drugs:server:RequestConfig', function(DealerConfig)
        Config.Dealers = DealerConfig
    end)
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

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        nearDealer = false

        for id, dealer in pairs(Config.Dealers) do
            local dealerDist = #(pos - vector3(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"]))

            if dealerDist <= 6 then
                nearDealer = true

                if dealerDist <= 1.5 and not isHealingPerson then
                    if not interacting then
                        if not dealerIsHome then
                            DrawText3D(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"], "[~g~E~s~] - Gõ")

                            if IsControlJustPressed(0, 38) then
                                currentDealer = id
                                knockDealerDoor()
                            end
                        elseif dealerIsHome then
                            if dealer["name"] == "Mystery man" then
                                DrawText3D(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"], "[~g~E~w~] Mua / [~g~G~w~] Giúp anh ta ($5000)")
                            else
                                DrawText3D(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"], "[~g~E~w~] Mua / [~g~G~w~] Bắt đầu nhiệm vụ")
                            end
                            if IsControlJustPressed(0, 38) then
                                buyDealerStuff()
                            end

                            if IsControlJustPressed(0, 47) then
                                if dealer["name"] == "Mystery man" then
                                    local player, distance = GetClosestPlayer()
                                    if player ~= -1 and distance < 5.0 then
                                        local playerId = GetPlayerServerId(player)
                                        isHealingPerson = true
                                        QBCore.Functions.Progressbar("hospital_revive", "Giúp đỡ", 5000, false, true, {
                                            disableMovement = false,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = healAnimDict,
                                            anim = healAnim,
                                            flags = 16,
                                        }, {}, {}, function() -- Done
                                            isHealingPerson = false
                                            StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                                            exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã giúp đỡ người đó", 5000, 'success')
                                            TriggerServerEvent("hospital:server:RevivePlayer", playerId, true)
                                        end, function() -- Cancel
                                            isHealingPerson = false
                                            StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                                        end)
                                    else
                                        exports['xt-notify']:Alert("THÔNG BÁO", "Không có ai ở gần", 5000, 'error')
                                    end
                                else
                                    if waitingDelivery == nil then
                                        TriggerEvent("chatMessage", "Tay buôn "..Config.Dealers[currentDealer]["name"], "info", "Đây là những sản phẩm, tôi sẽ giữ liên lạc qua email")
                                        requestDelivery()
                                        interacting = false
                                        dealerIsHome = false
                                    else
                                        TriggerEvent("chatMessage", "Tay buôn "..Config.Dealers[currentDealer]["name"], "error", "Bạn vẫn cần phải hoàn thành giao hàng,còn chờ gì nữa?!")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if not nearDealer then
            dealerIsHome = false
            Wait(2000)
        end

        Wait(3)
    end
end)

function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

function knockDealerDoor()
    local hours = GetClockHours()
    local min = Config.Dealers[currentDealer]["time"]["min"]
    local max = Config.Dealers[currentDealer]["time"]["max"]

    if max < min then
        if hours <= max then
            knockDoorAnim(true)
        elseif hours >= min then
            knockDoorAnim(true)
        else
            knockDoorAnim(false)
        end
    else
        if hours >= min and hours <= max then
            knockDoorAnim(true)
        else
            knockDoorAnim(false)
        end
    end
end

function buyDealerStuff()
    local repItems = {}
    repItems.label = Config.Dealers[currentDealer]["name"]
    repItems.items = {}
    repItems.slots = 30

    for k, v in pairs(Config.Dealers[currentDealer]["products"]) do
        if QBCore.Functions.GetPlayerData().metadata["dealerrep"] >= Config.Dealers[currentDealer]["products"][k].minrep then
            repItems.items[k] = Config.Dealers[currentDealer]["products"][k]
        end
    end

    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Dealer_"..Config.Dealers[currentDealer]["name"], repItems)
end

function knockDoorAnim(home)
    local knockAnimLib = "timetable@jimmy@doorknock@"
    local knockAnim = "knockdoor_idle"
    local PlayerPed = PlayerPedId()
    local myData = QBCore.Functions.GetPlayerData()

    if home then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Wait(100)
        end
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        Wait(1000)
        dealerIsHome = true
        if Config.Dealers[currentDealer]["name"] == "Mystery man" then
            TriggerEvent("chatMessage", "Tay buôn "..Config.Dealers[currentDealer]["name"], "info", "Xin chào ,tao có thể giúp gì cho mày?")
        elseif Config.Dealers[currentDealer]["name"] == "Fred" then
            dealerIsHome = false
            TriggerEvent("chatMessage", "Tay buôn "..Config.Dealers[currentDealer]["name"], "info", "Thật không may, tôi không còn kinh doanh nữa ... Bạn nên đối xử với tôi tốt hơn")
        else
            local name = myData.charinfo.firstname.." "..myData.charinfo.lastname
            TriggerEvent("chatMessage", "Tay buôn "..Config.Dealers[currentDealer]["name"], "info", "What's up "..name..", tôi có thể giúp gì cho bro")
        end
        -- knockTimeout()
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Wait(100)
        end
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        Wait(1000)
        exports['xt-notify']:Alert("THÔNG BÁO", "Không có ai ở gần", 5000, 'error')
    end
end

RegisterNetEvent('qb-drugs:client:updateDealerItems', function(itemData, amount)
    TriggerServerEvent('qb-drugs:server:updateDealerItems', itemData, amount, currentDealer)
end)

RegisterNetEvent('qb-drugs:client:setDealerItems', function(itemData, amount, dealer)
    Config.Dealers[dealer]["products"][itemData.slot].amount = Config.Dealers[dealer]["products"][itemData.slot].amount - amount
end)

function requestDelivery()
    local location = math.random(1, #Config.DeliveryLocations)
    local amount = math.random(1, 3)
    local item = randomDeliveryItemOnRep()
    waitingDelivery = {
        ["coords"] = Config.DeliveryLocations[location]["coords"],
        ["locationLabel"] = Config.DeliveryLocations[location]["label"],
        ["amount"] = amount,
        ["dealer"] = currentDealer,
        ["itemData"] = Config.DeliveryItems[item]
    }
    TriggerServerEvent('qb-drugs:server:giveDeliveryItems', amount)
    SetTimeout(2000, function()
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[currentDealer]["name"],
            subject = "Địa điểm giao dịch",
            message = "Thông tin giao hàng, <br>Vật phẩm: <br> "..amount.."x "..QBCore.Shared.Items[waitingDelivery["itemData"]["item"]]["label"].."<br><br>",
            button = {
                enabled = true,
                buttonEvent = "qb-drugs:client:setLocation",
                buttonData = waitingDelivery
            }
        })
    end)
end

function randomDeliveryItemOnRep()
    local myRep = QBCore.Functions.GetPlayerData().metadata["dealerrep"]
    retval = nil
    for k, v in pairs(Config.DeliveryItems) do
        if Config.DeliveryItems[k]["minrep"] <= myRep then
            local availableItems = {}
            availableItems[#availableItems+1] = k

            local item = math.random(1, #availableItems)

            retval = item
        end
    end
    return retval
end

function setMapBlip(x, y)
    SetNewWaypoint(x, y)
    exports['xt-notify']:Alert("THÔNG BÁO", "Tuyến đường đã được thiết lập", 5000, 'success')
end

RegisterNetEvent('qb-drugs:client:setLocation', function(locationData)
    if activeDelivery == nil then
        activeDelivery = locationData
    else
        setMapBlip(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"])
        exports['xt-notify']:Alert("THÔNG BÁO", "Bạn chưa giao hàng xong", 5000, 'success')
        return
    end

    deliveryTimeout = 300

    deliveryTimer()

    setMapBlip(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"])

    CreateThread(function()
        while activeDelivery do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inDeliveryRange = false
            local dist = #(pos - vector3(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"], activeDelivery["coords"]["z"]))
            if dist < 15 then
                inDeliveryRange = true
                if dist < 1.5 then
                    DrawText3D(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"], activeDelivery["coords"]["z"], "[~g~E~w~] Giao hàng x"..activeDelivery["amount"].." "..QBCore.Shared.Items[activeDelivery["itemData"]["item"]]["label"])
                    if IsControlJustPressed(0, 38) then
                        deliverStuff(activeDelivery)
                        activeDelivery = nil
                        waitingDelivery = nil
                        break
                    end
                end
            end
            if not inDeliveryRange then
                Wait(1500)
            end
            Wait(3)
        end
    end)
end)

function deliveryTimer()
    CreateThread(function()
        while deliveryTimeout - 1 > 0 do
            deliveryTimeout -= 1
            Wait(1000)
        end
        deliveryTimeout = 0
    end)
end

function deliverStuff(activeDelivery)
    if deliveryTimeout > 0 then
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        Wait(500)
        TriggerEvent('animations:client:EmoteCommandStart', {"bumbin"})
        checkPedDistance()
        QBCore.Functions.Progressbar("work_dropbox", "Giao hàng", 3500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('qb-drugs:server:succesDelivery', activeDelivery, true)
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
        end)
    else
        TriggerServerEvent('qb-drugs:server:succesDelivery', activeDelivery, false)
    end
    deliveryTimeout = 0
end

function checkPedDistance()
    local PlayerPeds = {}
    if next(PlayerPeds) == nil then
        for _, player in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(player)
            PlayerPeds[#PlayerPeds+1] = ped
        end
    end
	local coords = GetEntityCoords(player)
    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)

    if closestDistance < 40 and closestPed ~= 0 then
        local callChance = math.random(1, 100)

        if callChance < 15 then
            doPoliceAlert()
        end
    end
end

function doPoliceAlert()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then
        streetLabel = streetLabel .. " " .. street2
    end
    TriggerServerEvent('qb-drugs:server:callCops', streetLabel, pos)
end

RegisterNetEvent('qb-drugs:client:robberyCall', function(msg, streetLabel, coords)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerEvent("chatMessage", "911-ALERT", "error", msg)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 458)
    SetBlipColour(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("113: Có đối tượng buôn bán chất cấm")
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        if transG == 0 then
            SetBlipSprite(blip, 2)
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('qb-drugs:client:sendDeliveryMail', function(type, deliveryData)
    if type == 'perfect' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Giao hàng",
            message = "Mày làm rất tốt, Sau lại đến nữa nhé ☺️<br><br>Xi chào, "..Config.Dealers[deliveryData["dealer"]]["name"]
        })
    elseif type == 'bad' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Giao hàng",
            message = "Tao đã nhận được khiếu nại về việc giao hàng của mày, đừng để điều này xảy ra lần nữa"
        })
    elseif type == 'late' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Giao hàng",
            message = "Mày đã không đúng giờ. Mày có nhiều việc quan trọng phải làm hơn là kinh doanh?"
        })
    end
end)

RegisterNetEvent('qb-drugs:client:CreateDealer', function(dealerName, minTime, maxTime)
    local ped = PlayerPedId()
    local loc = GetEntityCoords(ped)
    local DealerData = {
        name = dealerName,
        time = {
            min = minTime,
            max = maxTime,
        },
        pos = {
            x = loc.x,
            y = loc.y,
            z = loc.z,
        }
    }

    TriggerServerEvent('qb-drugs:server:CreateDealer', DealerData)
end)

RegisterNetEvent('qb-drugs:client:RefreshDealers', function(DealerData)
    Config.Dealers = DealerData
end)

RegisterNetEvent('qb-drugs:client:GotoDealer', function(DealerData)
    local ped = PlayerPedId()
    SetEntityCoords(ped, DealerData["coords"]["x"], DealerData["coords"]["y"], DealerData["coords"]["z"])
    exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã dịch chuyển đến "..DealerData["name"], 5000, 'success')
end)