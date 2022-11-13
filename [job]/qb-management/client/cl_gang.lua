local QBCore = exports['qb-core']:GetCoreObject()
local PlayerGang = {}
local shownGangMenu = false

-- UTIL
local function CloseMenuFullGang()
    exports['qb-menu']:closeMenu()
    shownGangMenu = false
end

local function DrawText3DGang(v, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(v, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 0)
    ClearDrawOrigin()
end

local function comma_valueGang(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

--//Events
AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerGang = QBCore.Functions.GetPlayerData().gang
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(InfoGang)
    PlayerGang = InfoGang
end)

RegisterNetEvent('qb-gangmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerGang.name, {
        maxweight = 4000000,
        slots = 100,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerGang.name)
end)

RegisterNetEvent('qb-gangmenu:client:Warbobe', function()
    TriggerEvent('qb-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qb-gangmenu:client:OpenMenu', function()
    shownGangMenu = true
    local gangMenu = {
        {
            header = "Quản lý Băng Đảng  - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
        {
            header = "📋 Quản lý thành viên",
            txt = "Thăng chức hoặc đuổi đi",
            params = {
                event = "qb-gangmenu:client:ManageGang",
            }
        },
        {
            header = "💛 Tuyển thành viên",
            txt = "Tuyển thêm thành viên vào Băng đảng",
            params = {
                event = "qb-gangmenu:client:HireMembers",
            }
        },
        {
            header = "📦 Kho",
            txt = "Mở kho",
            params = {
                event = "qb-gangmenu:client:Stash",
            }
        },
        {
            header = "👕 Trang phục",
            txt = "Thay đổi trang phục",
            params = {
                event = "qb-gangmenu:client:Warbobe",
            }
        },
        {
            header = "💰 Quỹ",
            txt = "Kiểm tra quỹ Băng đảng",
            params = {
                event = "qb-gangmenu:client:SocietyMenu",
            }
        },
        {
            header = "🚪 Thoát",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    }
    exports['qb-menu']:openMenu(gangMenu)
end)

RegisterNetEvent('qb-gangmenu:client:ManageGang', function()
    local GangMembersMenu = {
        {
            header = "Quản lý thành viên - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
    }
    QBCore.Functions.TriggerCallback('qb-gangmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            GangMembersMenu[#GangMembersMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                params = {
                    event = "qb-gangmenu:lient:ManageMember",
                    args = {
                        player = v,
                        work = PlayerGang
                    }
                }
            }
        end
        GangMembersMenu[#GangMembersMenu + 1] = {
            header = "< Quay lại",
            params = {
                event = "qb-gangmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(GangMembersMenu)
    end, PlayerGang.name)
end)

RegisterNetEvent('qb-gangmenu:lient:ManageMember', function(data)
    local MemberMenu = {
        {
            header = "Quản lý" .. data.player.name.. " - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
    }
    for k, v in pairs(QBCore.Shared.Gangs[data.work.name].grades) do
        MemberMenu[#MemberMenu + 1] = {
            header = v.name,
            txt = "Vai vế: " .. k,
            params = {
                isServer = true,
                event = "qb-gangmenu:server:GradeUpdate",
                args = {
                    cid = data.player.empSource,
                    degree = tonumber(k),
                    named = v.name
                }
            }
        }
    end
    MemberMenu[#MemberMenu + 1] = {
        header = "Đuổi",
        params = {
            isServer = true,
            event = "qb-gangmenu:server:FireMember",
            args = data.player.empSource
        }
    }
    MemberMenu[#MemberMenu + 1] = {
        header = "< Quay lại",
        params = {
            event = "qb-gangmenu:client:ManageGang",
        }
    }
    exports['qb-menu']:openMenu(MemberMenu)
end)

RegisterNetEvent('qb-gangmenu:client:HireMembers', function()
    local HireMembersMenu = {
        {
            header = "Tuyển thành viên - " .. string.upper(PlayerGang.label),
            isMenuHeader = true,
        },
    }
    QBCore.Functions.TriggerCallback('qb-gangmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMembersMenu[#HireMembersMenu + 1] = {
                    header = v.name,
                    txt = "Số CMND: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    params = {
                        isServer = true,
                        event = "qb-gangmenu:server:HireMember",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMembersMenu[#HireMembersMenu + 1] = {
            header = "< Quay lại",
            params = {
                event = "qb-gangmenu:client:OpenMenu",
            }
        }
        exports['qb-menu']:openMenu(HireMembersMenu)
    end)
end)

RegisterNetEvent('qb-gangmenu:client:SocietyMenu', function()
    QBCore.Functions.TriggerCallback('qb-gangmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Số dư: $" .. comma_valueGang(cb) .. " - " .. string.upper(PlayerGang.label),
                isMenuHeader = true,
            },
            {
                header = "💸 Gửi tiền",
                txt = "Gửi tiền vào quỹ",
                params = {
                    event = "qb-gangmenu:client:SocietyDeposit",
                    args = comma_valueGang(cb)
                }
            },
            {
                header = "💸 Rút tiền",
                txt = "Rút tiền ra khỏi quỹ",
                params = {
                    event = "qb-gangmenu:client:SocietyWithdraw",
                    args = comma_valueGang(cb)
                }
            },
            {
                header = "< Quay lại",
                params = {
                    event = "qb-gangmenu:client:OpenMenu",
                }
            },
        }
        exports['qb-menu']:openMenu(SocietyMenu)
    end, PlayerGang.name)
end)

RegisterNetEvent('qb-gangmenu:client:SocietyDeposit', function(saldoattuale)
    local deposit = exports['qb-input']:ShowInput({
        header = "Gửi tiền <br> Số dư khả dụng: $" .. saldoattuale,
        submitText = "Xác nhận",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        TriggerServerEvent("qb-gangmenu:server:depositMoney", tonumber(deposit.amount))
    end
end)

RegisterNetEvent('qb-gangmenu:client:SocietyWithdraw', function(saldoattuale)
    local withdraw = exports['qb-input']:ShowInput({
        header = "Rút tiền Money <br> Số dư khả dụng: $" .. saldoattuale,
        submitText = "Xác nhận",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = '$'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("qb-gangmenu:server:withdrawMoney", tonumber(withdraw.amount))
    end
end)

-- MAIN THREAD
CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local inRangeGang = false
        local nearGangmenu = false
        for k, v in pairs(Config.Gangs) do
            if k == PlayerGang.name and PlayerGang.isboss then
                if #(pos - v) < 5.0 then
                    inRangeGang = true
                    if #(pos - v) <= 1.5 then
                        if not shownGangMenu then DrawText3DGang(v, "Nhấn [~b~E~w~] - Quản lý Băng đảng") end
                        nearGangmenu = true
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("qb-gangmenu:client:OpenMenu")
                        end
                    end
                    
                    if not nearGangmenu and shownGangMenu then
                        CloseMenuFullGang()
                        shownGangMenu = false
                    end
                end
            end
        end
        if not inRangeGang then
            Wait(1500)
            if shownGangMenu then
                CloseMenuFullGang()
                shownGangMenu = false
            end
        end
        Wait(5)
    end
end)
