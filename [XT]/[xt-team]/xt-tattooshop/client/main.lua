local currentTattoos = {}
local cam = nil
local back = 1
local opacity = 1
local scaleType = nil
local scaleString = ""
QBCore = exports['qb-core']:GetCoreObject()
CreateThread(function()
    for k, v in pairs(Config.Shops) do
        local blip = AddBlipForCoord(v)
        SetBlipDisplay(blip, 4)
        SetBlipSprite(blip, 75)
        SetBlipColour(blip, 14)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true) 
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentSubstringPlayerName("Tiệm xăm")
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    TriggerServerEvent('Select:Tattoos')
end)
local function Checkdo(collection , hash, tattoo, tattooList, price, tattooName)
    local hasitem = false
    local hasitem2 = false
    local indx = 0
    local countitem = 0
    local sl = 0
    local o = 0
    QBCore.Functions.TriggerCallback('qb-inventory:server:GetStashItems', function(StashItems)
        for k,v in pairs(StashItems) do
            if v.name == 'muc' then
                hasitem = true
                if v.amount >= 2 then
                    countitem = v.amount
                    indx = k
                end
            elseif v.name == 'kim' then
                if v.amount >= 1 then
                    hasitem2 = true
                    sl = v.amount
                    o = k
                end
            end
        end
        if hasitem and countitem >= 2 and hasitem2 and sl >= 1 then
            QBCore.Functions.Progressbar("repair_part", "Xăm mình", 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                if (countitem - 2) == 0 then
                    StashItems[indx] = nil
                else
                    countitem = (countitem - 2)
                    StashItems[indx].amount = countitem
                end
                if (sl - 1) == 0 then
                    StashItems[o] = nil
                else
                    sl = (sl - 1)
                    StashItems[o].amount = sl
                end
                SetPedDecoration(PlayerPedId(), collection, hash)
                TriggerServerEvent('xt-tatooshop:server:xam', tattoo, tattooList, price, tattooName)
                TriggerServerEvent('qb-inventory:server:SaveStashItems', "boss_xam", StashItems)
            end, function()
                exports['xt-notify']:Alert("THÔNG BÁO", "Huỷ bỏ", 5000, 'error')
            end)
        else
            exports['xt-notify']:Alert("THÔNG BÁO", "Kho xăm không đủ đồ, hãy liên hệ chủ cửa hàng", 5000, 'error')
        end
    end, "boss_xam")
end
RegisterNetEvent('Apply:Tattoo', function(tattoo, tattooList, price, tattooName)
    QBCore.Functions.TriggerCallback('SmallTattoos:GetPlayerTattoos', function(tattooList1)
        if tattooList1 then
            for k, v in pairs(tattooList1) do
                Checkdo(v.collection, v.nameHash, tattoo, tattooList, price, tattooName)
            end
            currentTattoos = tattooList1
        end
    end)
end)
RegisterNetEvent('xt-tattooshop:client:loadxam', function(tats)
    QBCore.Functions.TriggerCallback('SmallTattoos:GetPlayerTattoos', function(tattooList)
        if tattooList then
            for k, v in pairs(tattooList) do
                SetPedDecoration(PlayerPedId(),v.collection, v.nameHash)
            end
            currentTattoos = tattooList
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(300000)
        if not IsMenuOpen() then
            QBCore.Functions.TriggerCallback('SmallTattoos:GetPlayerTattoos', function(tattooList)
                if tattooList then
                    ClearPedDecorations(PlayerPedId())
                    for k, v in pairs(tattooList) do
                        if v.Count ~= nil then
                            for i = 1, v.Count do
                                SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
                            end
                        else
                            SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
                        end
                    end
                    currentTattoos = tattooList
                end
            end)
        end
    end
end)
function DrawTattoo(collection, name)
    ClearPedDecorations(PlayerPedId())
    for k, v in pairs(currentTattoos) do
        if v.Count ~= nil then
            for i = 1, v.Count do
                SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
            end
        else
            SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
        end
    end
    for i = 1, opacity do
        SetPedDecoration(PlayerPedId(), collection, name)
    end
end

function GetNaked()
    TriggerEvent('skinchanger:getSkin', function()
        if GetEntityModel(PlayerPedId()) == 'mp_m_freemode_01' then
            TriggerEvent('skinchanger:loadSkin', {
                sex = 0,
                tshirt_1 = 15,
                tshirt_2 = 0,
                arms = 15,
                torso_1 = 91,
                torso_2 = 0,
                pants_1 = 14,
                pants_2 = 0,
                shoes_1 = 5,
                glasses_1 = 0
            })
        else
            TriggerEvent('skinchanger:loadSkin', {
                sex = 1,
                tshirt_1 = 34,
                tshirt_2 = 0,
                arms = 15,
                torso_1 = 101,
                torso_2 = 1,
                pants_1 = 16,
                pants_2 = 0,
                shoes_1 = 5,
                glasses_1 = 5
            })
        end
    end)
end

function ResetSkin()
    ClearPedDecorations(PlayerPedId())
    for k, v in pairs(currentTattoos) do
        if v.Count ~= nil then
            for i = 1, v.Count do
                SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
            end
        else
            SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
        end
    end
end

function ReqTexts(text, slot)
    RequestAdditionalText(text, slot)
    while not HasAdditionalTextLoaded(slot) do
        Wait(0)
    end
end

function OpenTattooShop()
    JayMenu.OpenMenu("tattoo")
    FreezeEntityPosition(PlayerPedId(), true)
    ReqTexts("TAT_MNU", 9)
end

function CloseTattooShop()
    ClearAdditionalText(9, 1)
    FreezeEntityPosition(PlayerPedId(), false)
    EnableAllControlActions(0)
    back = 1
    opacity = 1
    return true
end

function ButtonPress()
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
end

function IsMenuOpen()
    return (JayMenu.IsMenuOpened('tattoo') or string.find(tostring(JayMenu.CurrentMenu() or ""), "ZONE_"))
end

function BuyTattoo(collection, name, label, price)
    QBCore.Functions.TriggerCallback('SmallTattoos:PurchaseTattoo', function(success)
        if success then
            table.insert(currentTattoos, {collection = collection, nameHash = name, Count = opacity})
        end
    end, currentTattoos, price, {collection = collection, nameHash = name, Count = opacity}, GetLabelText(label))
end

RegisterCommand('loadxam', function(source)
    TriggerServerEvent('Select:Tattoos')
end)

function RemoveTattoo(name, label)
    for k, v in pairs(currentTattoos) do
        if v.nameHash == name then
            table.remove(currentTattoos, k)
        end
    end
    TriggerServerEvent("SmallTattoos:RemoveTattoo", currentTattoos)
    --print("Bạn đã xoá xăm ~y~" .. GetLabelText(label) .. "~s~")
end

function CreateScale(sType)
    if scaleString ~= sType and sType == "OpenShop" then
        scaleType = setupScaleform("instructional_buttons", "Xam", 47)
        scaleString = sType
    elseif scaleString ~= sType and sType == "Control" then
        scaleType = setupScaleform2("instructional_buttons", "Doi goc nhin", 21, "Thay doi do dam nhat", {90, 89}, "Xam/Xoa xam", 191)
        scaleString = sType
    end
end

CreateThread(function()
    JayMenu.CreateMenu("tattoo", "Tiệm xăm", function()
        return CloseTattooShop()
    end)
    JayMenu.SetSubTitle('tattoo', "Categories")

    for k, v in ipairs(Config.TattooCats) do
        JayMenu.CreateSubMenu(v[1], "tattoo", v[2])
        JayMenu.SetSubTitle(v[1], v[2])
    end
    while true do
        Wait(0)
        local CanSleep = true
        if not IsMenuOpen() then
            for _, interiorId in ipairs(Config.interiorIds) do
                if GetInteriorFromEntity(PlayerPedId()) == interiorId then
                    CanSleep = false
                    if not IsPedInAnyVehicle(PlayerPedId(), false) then
                        CreateScale("OpenShop")
                        DrawScaleformMovieFullscreen(scaleType, 255, 255, 255, 255, 0)
                        if IsControlJustPressed(0, 47) then
                            OpenTattooShop()
                        end
                    end
                end
            end
        end
        if IsMenuOpen() then
            DisableAllControlActions(0)
            CanSleep = false
        end   
        if JayMenu.IsMenuOpened('tattoo') then
            CanSleep = false
            for k, v in ipairs(Config.TattooCats) do
                JayMenu.MenuButton(v[2], v[1])
            end
            ClearPedDecorations(PlayerPedId())
            for k, v in pairs(currentTattoos) do
                if v.Count ~= nil then
                    for i = 1, v.Count do
                        SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
                    end
                else
                    SetPedDecoration(PlayerPedId(), v.collection, v.nameHash)
                end
            end
            if DoesCamExist(cam) then
                DetachCam(cam)
                SetCamActive(cam, false)
                RenderScriptCams(false, false, 0, 1, 0)
                DestroyCam(cam, false)
            end
            JayMenu.Display()
        end
        for k, v in ipairs(Config.TattooCats) do
            if JayMenu.IsMenuOpened(v[1]) then
                CanSleep = false
                if not DoesCamExist(cam) then
                    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
                    SetCamActive(cam, true)
                    RenderScriptCams(true, false, 0, true, true)
                    StopCamShaking(cam, true)
                end
                CreateScale("Control")
                DrawScaleformMovieFullscreen(scaleType, 255, 255, 255, 255, 0)
                if IsDisabledControlJustPressed(0, 21) then
                    ButtonPress()
                    if back == #v[3] then
                        back = 1
                    else
                        back = back + 1
                    end
                end
                if IsDisabledControlJustPressed(0, 90) then
                    ButtonPress()
                    if opacity == 10 then
                        opacity = 10
                    else
                        opacity = opacity + 1
                    end
                end
                if IsDisabledControlJustPressed(0, 89) then
                    ButtonPress()
                    if opacity == 1 then
                        opacity = 1
                    else
                        opacity = opacity - 1
                    end
                end
                if GetCamCoord(cam) ~= GetOffsetFromEntityInWorldCoords(PlayerPedId(), v[3][back]) then
                    SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(PlayerPedId(), v[3][back]))
                    PointCamAtCoord(cam, GetOffsetFromEntityInWorldCoords(PlayerPedId(), v[4]))
                end
                for _, tattoo in pairs(Config.AllTattooList) do
                    if tattoo.Zone == v[1] then
                        if GetEntityModel(PlayerPedId()) == 'mp_m_freemode_01' then
                            if tattoo.HashNameMale ~= '' then
                                local found = false
                                for k, v in pairs(currentTattoos) do
                                    if v.nameHash == tattoo.HashNameMale then
                                        found = true
                                        break
                                    end
                                end
                                if found then
                                    local clicked, hovered = JayMenu.SpriteButton(GetLabelText(tattoo.Name), "commonmenu", "shop_tattoos_icon_a", "shop_tattoos_icon_b")
                                    if clicked then
                                        RemoveTattoo(tattoo.HashNameMale, tattoo.Name)
                                    end
                                else
                                    local price = math.ceil(tattoo.Price / 20) == 0 and 100 or math.ceil(tattoo.Price / 20)
                                    local clicked, hovered = JayMenu.Button(GetLabelText(tattoo.Name), "~HUD_COLOUR_GREENDARK~$" .. price)
                                    if clicked then
                                        BuyTattoo(tattoo.Collection, tattoo.HashNameMale, tattoo.Name, price)
                                    elseif hovered then
                                        DrawTattoo(tattoo.Collection, tattoo.HashNameMale)
                                    end
                                end
                            end
                        else
                            if tattoo.HashNameFemale ~= '' then
                                local found = false
                                for k, v in pairs(currentTattoos) do
                                    if v.nameHash == tattoo.HashNameFemale then
                                        found = true
                                        break
                                    end
                                end
                                if found then
                                    local clicked, hovered = JayMenu.SpriteButton(GetLabelText(tattoo.Name), "commonmenu", "shop_tattoos_icon_a", "shop_tattoos_icon_b")
                                    if clicked then
                                        RemoveTattoo(tattoo.HashNameFemale, tattoo.Name)
                                    end
                                else
                                    local price = math.ceil(tattoo.Price / 2) == 0 and 100 or math.ceil(tattoo.Price / 2)
                                    local clicked, hovered = JayMenu.Button(GetLabelText(tattoo.Name), "~HUD_COLOUR_GREENDARK~$" .. price)
                                    if clicked then
                                        BuyTattoo(tattoo.Collection, tattoo.HashNameFemale, tattoo.Name, price)
                                    elseif hovered then
                                        DrawTattoo(tattoo.Collection, tattoo.HashNameFemale)
                                    end
                                end
                            end
                        end
                    end
                end
                JayMenu.Display()
            end
        end
        if CanSleep then
            Wait(3000)
        end
    end
end)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

function setupScaleform2(scaleform, message, button, message2, buttons, message3, button2)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, buttons[1], true))
    Button(GetControlInstructionalButton(2, buttons[2], true))
    ButtonMessage(message2)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, button, true))
    ButtonMessage(message)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(2, button2, true))
    ButtonMessage(message3)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    
    return scaleform
end

function setupScaleform(scaleform, message, button)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, button, true))
    ButtonMessage(message)
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    
    return scaleform
end

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        Wait(0) 
        for i = 1, #Config.Shops, 1 do
            local player = PlayerPedId()
            local playerloc = GetEntityCoords(player, 0)
            local coordinates = Config.Shops[i]
            local dist = GetDistanceBetweenCoords(coordinates['x'], coordinates['y'], coordinates['z'], playerloc['x'], playerloc['y'], playerloc['z'], true)
            if dist <= 8 then
                --DrawText3Ds(coordinates.x, coordinates.y, coordinates.z + 0.10, "/removealltattoo to remove all tattoos.")
            end
        end
    end
end)


RegisterCommand('removealltattoo', function(source, args, rawCommand)
    for i = 1, #Config.Shops, 1 do
        local player = PlayerPedId()
        local playerloc = GetEntityCoords(player, 0)
        local coordinates = Config.Shops[i]
        local dist = GetDistanceBetweenCoords(coordinates['x'], coordinates['y'], coordinates['z'], playerloc['x'], playerloc['y'], playerloc['z'], true)
        
        if dist <= 3 then
            TriggerServerEvent('remover:all')
            ClearPedDecorationsLeaveScars(player)
        else
            --print('you need to be at a tattoo shop to use this command!!!')
        end
    end
end)

RegisterNetEvent('remover:tudo')
AddEventHandler('remover:tudo', function()
    local ped = PlayerPedId()
    ClearPedDecorationsLeaveScars(ped)
end)
