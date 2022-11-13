-- Variables
local Plates = {}
local PlayerStatus = {}
local Casings = {}
local BloodDrops = {}
local FingerDrops = {}
local Objects = {}
local QBCore = exports['qb-core']:GetCoreObject()

-- Functions
local function UpdateBlips()
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "police" or v.PlayerData.job.name == "ambulance") and v.PlayerData.job.onduty then
            local coords = GetEntityCoords(GetPlayerPed(v.PlayerData.source))
            local heading = GetEntityHeading(GetPlayerPed(v.PlayerData.source))
            dutyPlayers[#dutyPlayers+1] = {
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name,
                location = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                    w = heading
                }
            }
        end
    end
    TriggerClientEvent("police:client:UpdateBlips", -1, dutyPlayers)
end

local function CreateBloodId()
    if BloodDrops then
        local bloodId = math.random(10000, 99999)
        while BloodDrops[bloodId] do
            bloodId = math.random(10000, 99999)
        end
        return bloodId
    else
        local bloodId = math.random(10000, 99999)
        return bloodId
    end
end

local function CreateFingerId()
    if FingerDrops then
        local fingerId = math.random(10000, 99999)
        while FingerDrops[fingerId] do
            fingerId = math.random(10000, 99999)
        end
        return fingerId
    else
        local fingerId = math.random(10000, 99999)
        return fingerId
    end
end

local function CreateCasingId()
    if Casings then
        local caseId = math.random(10000, 99999)
        while Casings[caseId] do
            caseId = math.random(10000, 99999)
        end
        return caseId
    else
        local caseId = math.random(10000, 99999)
        return caseId
    end
end

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

local function IsVehicleOwned(plate)
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    return result
end

local function GetCurrentCops()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end

-- Commands
QBCore.Commands.Add("spikestrip", "Rải đinh.. (Cảnh sát)", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            TriggerClientEvent('police:client:SpawnSpikeStrip', src)
        end
    end
end)

QBCore.Commands.Add("grantlicense", "Cấp giấy phép", {{name = "id", help = "id"}, {name = "license", help = "Loại bằng (driver/weapon)"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= Config.LicenseRank then
        if args[2] == "driver" or args[2] == "weapon" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
            if licenseTable[args[2]] then
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Người chơi đã sở hữu giấy phép", 5000, 'error')
                return
            end
            licenseTable[args[2]] = true
            SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
            TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Bạn đã được cấp giấy phép", 5000, 'success')
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Người chơi đã cấp giấy phép", 5000, 'success')
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Loại giấy phép không xác định", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn không đủ quyền hạn để cấp giấy phép", 5000, 'error')
    end
end)

QBCore.Commands.Add("revokelicense", "Thu hồi giấy phép", {{name = "id", help = "ID"}, {name = "license", help = "Loại bằng (driver/weapon)"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.grade.level >= Config.LicenseRank then
        if args[2] == "driver" or args[2] == "weapon" then
            local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
            if not licenseTable[args[2]] then
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Người chơi không có giấy phép", 5000, 'error')
                return
            end
            licenseTable[args[2]] = false
            SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
            TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Bạn đã bị thu hồi giấy phép", 5000, 'error')
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn bị tịch thu giấy phép", 5000, 'success')
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Loại giấy phép không xác định", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn không đủ quyền hạn để cấp giấy phép", 5000, 'error')
    end
end)

QBCore.Commands.Add("pobject", "Đặt vật thể", {{name = "type",help = "Loại (cone, barrier, roadsign, tent, light) | delete để xoá"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local type = args[1]:lower()
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if type == "cone" then
            TriggerClientEvent("police:client:spawnCone", src)
        elseif type == "barrier" then
            TriggerClientEvent("police:client:spawnBarrier", src)
        elseif type == "roadsign" then
            TriggerClientEvent("police:client:spawnRoadSign", src)
        elseif type == "tent" then
            TriggerClientEvent("police:client:spawnTent", src)
        elseif type == "light" then
            TriggerClientEvent("police:client:spawnLight", src)
        elseif type == "delete" then
            TriggerClientEvent("police:client:deleteObject", src)
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("cuff", "Còng tay", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayer", src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)
QBCore.Commands.Add("uncuff", "Bỏ còng tay", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:GetUnCuffed", src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)
QBCore.Commands.Add("escort", "Hộ tống", {}, false, function(source, args)
    local src = source
    TriggerClientEvent("police:client:EscortPlayer", src)
end)

QBCore.Commands.Add("callsign", "Mã hiệu", {{name = "name", help = "Tên"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

QBCore.Commands.Add("clearcasings", "Xoá mã hiệu", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("jail", "Bắt giam", {{name = "id", help = "ID"}, {name = "time", help = "Thời gian"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            TriggerClientEvent("police:client:JailCommand", src, playerId, time)
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Thời gian giam giữ cần phải lớn hơn 0", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("unjail", "Thả tạm giam", {{name = "id", help = "ID"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("clearblood", "Xoá máu", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("seizecash", "Thu giữ tiền mặt", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("sc", "Còng tay tạm thời", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("cam", "Kiểm tra camera", {{name = "camid", help = "Mã camera"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ActiveCamera", src, tonumber(args[1]))
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("flagplate", "Theo dõi biển số", {{name = "plate", help = "Biển số xe"}, {name = "reason", help = "Lý do"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local reason = {}
        for i = 2, #args, 1 do
            reason[#reason+1] = args[i]
        end
        Plates[args[1]:upper()] = {
            isflagged = true,
            reason = table.concat(reason, " ")
        }
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện "..args[1]:upper().." bị gắn thiết bị theo dõi với lý do "..table.concat(reason, " ").." !", 5000, 'info')
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("unflagplate", "Bỏ theo dõi", {{name = "plate", help = "biển số"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if Plates and Plates[args[1]:upper()] then
            if Plates[args[1]:upper()].isflagged then
                Plates[args[1]:upper()].isflagged = false
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện "..args[1]:upper().." được huỷ theo dõi !", 5000, 'info')
            else
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện không được theo dõi", 5000, 'error')
            end
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện không được theo dõi", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("ktbienso", "Kiểm tra biển số", {{name = "plate", help = "Biển số"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if Plates and Plates[args[1]:upper()] then
            if Plates[args[1]:upper()].isflagged then
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện "..args[1]:upper().." được theo dõi với lý do "..Plates[args[1]:upper()].reason.." !", 5000, 'success')
            else
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện không được theo dõi", 5000, 'error')
            end
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện không được theo dõi", 5000, 'error')
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("phatxe", "Giam giữ phương tiện theo mức phạt", {{name = "price", help = "mức phạt"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ImpoundVehicle", src, false, tonumber(args[1]))
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("giamxe", "Giam giữ phương tiện", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:ImpoundVehicle", src, true)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("paylawyer", "Chi trả cho luật sư", {{name = "id", help = "ID"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "judge" then
        local playerId = tonumber(args[1])
        local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
        if OtherPlayer then
            if OtherPlayer.PlayerData.job.name == "lawyer" then
                OtherPlayer.Functions.AddMoney("bank", Config.feeLawyer, "police-lawyer-paid")
                TriggerClientEvent('xt-notify:client:Alert', OtherPlayer.PlayerData.source, "THÔNG BÁO", "Bạn đã chi trả "..Config.feeLawyer.."$ ", 5000, 'success')
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn đã chi trả cho luật sư", 5000, 'info')
            else
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Người chơi không phải là luật sư", 5000, 'error')
            end
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("anklet", "Gắn vòng theo dõi", {}, false, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CheckDistance", src)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("ankletlocation", "Vị trí đối tượng theo dõi", {{name = "cid", help = "Mã công dân"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if args[1] then
            local citizenid = args[1]
            local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)
            if Target then
                if Target.PlayerData.metadata["tracker"] then
                    TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, src)
                else
                    TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Nghi phạm không đeo vòng chân", 5000, 'error')
                end
            end
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("removeanklet", "Bỏ vòng theo dõi", {{name = "cid", help = "Mã công dân"}}, true,function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if args[1] then
            local citizenid = args[1]
            local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)
            if Target then
                if Target.PlayerData.metadata["tracker"] then
                    TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, src)
                else
                    TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Nghi phạm không đeo vòng chân", 5000, 'error')
                end
            end
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)

QBCore.Commands.Add("thubl", "Thu giữ bằng lái", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeDriverLicense", source)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)
QBCore.Commands.Add("capbvk", "Cấp bằng sử dụng vũ khí", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:Capbangvukhi", source)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)
QBCore.Commands.Add("thubvk", "Thu bằng sử dụng vũ khí", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:thubangvukhi", source)
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Chỉ cho phép cảnh sát đang trong ca trực", 5000, 'error')
    end
end)
QBCore.Commands.Add("takedna", "Lấy DNA", {{name = "id", help = "ID"}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) and OtherPlayer then
        if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
            local info = {
                label = "Mẫu DNA",
                type = "dna",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid)
            }
            if Player.Functions.AddItem("filled_evidence_bag", 1, false, info) then
                TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            end
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn phải có túi chứng cứ trống", 5000, 'error')
        end
    end
end)

RegisterNetEvent('police:server:SendTrackerLocation', function(coords, requestId)
    local Target = QBCore.Functions.GetPlayer(source)
    local msg = "Vị trí của "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.." đã được đánh dấu trên map"
    local alertData = {
        title = "Vị trí vòng theo dõi",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = msg
    }
    TriggerClientEvent("police:client:TrackerMessage", requestId, msg, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", requestId, alertData)
end)

-- Items
QBCore.Functions.CreateUseableItem("handcuffs", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    end
end)

QBCore.Functions.CreateUseableItem("moneybag", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        if item.info and item.info ~= "" then
            if Player.PlayerData.job.name ~= "police" then
                if Player.Functions.RemoveItem("moneybag", 1, item.slot) then
                    Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
                end
            end
        end
    end
end)

-- Callbacks
QBCore.Functions.CreateCallback('police:server:isPlayerDead', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    local statList = {}
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList+1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end
    cb(statList)
end)

QBCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = QBCore.Functions.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo then
        if itemInfo.info and itemInfo.info.attachments then
            for k, v in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetDutyPlayers', function(source, cb)
    local dutyPlayers = {}
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            dutyPlayers[#dutyPlayers+1] = {
                source = Player.PlayerData.source,
                label = Player.PlayerData.metadata["callsign"],
                job = Player.PlayerData.job.name
            }
        end
    end
    cb(dutyPlayers)
end)

QBCore.Functions.CreateCallback('police:GetImpoundedVehicles', function(source, cb)
    local vehicles = {}
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE state = ?', {2}, function(result)
        if result[1] then
            vehicles = result
        end
        cb(vehicles)
    end)
end)

QBCore.Functions.CreateCallback('police:IsPlateFlagged', function(source, cb, plate)
    local retval = false
    if Plates and Plates[plate] then
        if Plates[plate].isflagged then
            retval = true
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('police:server:IsPoliceForcePresent', function(source, cb)
    local retval = false
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.grade.level >= 2 then
            retval = true
            break
        end
    end
    cb(retval)
end)

-- Events
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            MySQL.Async.execute("DELETE FROM stashitems WHERE stash='policetrash'")
        end)
    end
end)

RegisterNetEvent('police:server:policeAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = QBCore.Functions.GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            local alertData = {title = "Cuộc gọi mới", coords = {coords.x, coords.y, coords.z}, description = text}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, text)
        end
    end
end)

RegisterNetEvent('police:server:TakeOutImpound', function(plate)
    local src = source
    MySQL.Async.execute('UPDATE player_vehicles SET state = ? WHERE plate  = ?', {0, plate})
    TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện được thả", 5000, 'success')
    
end)

RegisterNetEvent('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CuffedPlayer = QBCore.Functions.GetPlayer(playerId)
    if CuffedPlayer then
        if Player.Functions.GetItemByName("handcuffs") or Player.PlayerData.job.name == "police" then
            TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)
        end
    end
end)

RegisterNetEvent('police:server:EscortPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Công dân không bị còng hoặc đã tử vong", 5000, 'success')
        end
    end
end)

RegisterNetEvent('police:server:KidnapPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or
            EscortPlayer.PlayerData.metadata["inlaststand"] then
            TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
            TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Công dân không bị còng hoặc đã tử vong", 5000, 'success')
        end
    end
end)

RegisterNetEvent('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Công dân không bị còng hoặc đã tử vong", 5000, 'success')
        end
    end
end)

RegisterNetEvent('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local EscortPlayer = QBCore.Functions.GetPlayer(playerId)
    if EscortPlayer then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Công dân không bị còng hoặc đã tử vong", 5000, 'success')
        end
    end
end)

RegisterNetEvent('police:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local currentDate = os.date("*t")
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    if Player.PlayerData.job.name == "police" then
        if OtherPlayer then
            OtherPlayer.Functions.SetMetaData("injail", time)
            OtherPlayer.Functions.SetMetaData("criminalrecord", {
                ["hasRecord"] = true,
                ["date"] = currentDate
            })
            TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn đã bắt giam nghi phạm trong vòng "..time.." tháng", 5000, 'success')
        end
    end
end)

RegisterNetEvent('police:server:SetHandcuffStatus', function(isHandcuffed)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
    end
end)

RegisterNetEvent('heli:spotlight', function(state)
    local serverID = source
    TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

RegisterNetEvent('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Đã tìm thấy "..SearchedPlayer.PlayerData.money["cash"].." trên người công dân", 5000, 'info')
        TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Bạn đang bị kiểm tra", 5000, 'info')
    end
end)

RegisterNetEvent('police:server:SeizeCash', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
        local info = { cash = moneyAmount }
        SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
        Player.Functions.AddItem("moneybag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["moneybag"], "add")
        TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Bạn đang bị kiểm tra", 5000, 'info')
    end
end)

RegisterNetEvent('police:server:SeizeDriverLicense', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
        if driverLicense then
            local licenses = {["driver"] = false, ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]}
            SearchedPlayer.Functions.SetMetaData("licences", licenses)
            TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Giấy phép lái xe của bạn đã bị tịch thu", 5000, 'info')
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Không có bằng lái xe", 5000, 'error')
        end
    end
end)
RegisterNetEvent('police:server:thubangvukhi', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local weaponLicense = SearchedPlayer.PlayerData.metadata["licences"]["weapon"]
        if weaponLicense then
            local licenses = {["weapon"] = false, ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]}
            SearchedPlayer.Functions.SetMetaData("licences", licenses)
            TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Giấy phép sử dụng vũ khí của bạn đã bị tịch thu", 5000, 'info')
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Không có giấy phép sử dụng vũ khí", 5000, 'error')
        end
    end
end)
RegisterNetEvent('police:server:Capbangvukhi', function(playerId)
    local src = source
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local weaponLicense = SearchedPlayer.PlayerData.metadata["licences"]["weapon"]
        if weaponLicense == false then
            local licenses = {["weapon"] = true, ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]}
            SearchedPlayer.Functions.SetMetaData("weaponlicense", licenses)
            local info = {
                firstname = SearchedPlayer.PlayerData.charinfo.firstname,
                lastname = SearchedPlayer.PlayerData.charinfo.lastname,
                birthdate = SearchedPlayer.PlayerData.charinfo.birthdate,
                serial = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
            }
            SearchedPlayer.Functions.AddItem("weaponlicense", 1, false, info)
            TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Bạn đã được cung cấp bằng sử dụng súng", 5000, 'info')
        else
            TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Công dân đã có bằng sử dụng súng", 5000, 'error')
        end
    end
end)
RegisterNetEvent('police:server:RobPlayer', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local SearchedPlayer = QBCore.Functions.GetPlayer(playerId)
    if SearchedPlayer then
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('xt-notify:client:Alert', SearchedPlayer.PlayerData.source, "THÔNG BÁO", "Bạn bị cướp mất "..money.."$", 5000, 'info')
        TriggerClientEvent('xt-notify:client:Alert', Player.PlayerData.source, "Bạn đã cướp được "..money.."$", 5000, 'info')
    end
end)
RegisterNetEvent('police:server:StoreRobberyCall', function(coords, message, streetLabel)
    local src = source
    local alertData = {
        title = "Cướp Tạp hoá",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = message
    }
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
    TriggerClientEvent('police:client:send:alert:store', -1, coords, streetLabel)
end)

RegisterNetEvent('police:server:DonghoRobberyCall', function(coords, message, streetLabel)
    local src = source
    local alertData = {
        title = "Cướp Đồng Hồ",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = message
    }
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
    TriggerClientEvent('police:client:send:meter:alert', -1, coords, streetLabel)
end)
RegisterNetEvent('police:server:HouseRobberyCall', function(coords, message, streetLabel)
    local src = source
    local alertData = {
        title = "Cướp Nhà",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = message
    }
    TriggerClientEvent("qb-phone:client:addPoliceAlert", -1, alertData)
    TriggerClientEvent('police:client:send:house:alert', -1, coords, streetLabel)
end)
RegisterNetEvent('police:server:UpdateBlips', function()
end)

RegisterNetEvent('police:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", src, objectId, type, src)
end)

RegisterNetEvent('police:server:deleteObject', function(objectId)
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterNetEvent('police:server:Impound', function(plate, fullImpound, price, body, engine, fuel)
    local src = source
    local price = price and price or 0
    if IsVehicleOwned(plate) then
        if not fullImpound then
            MySQL.Async.execute(
                'UPDATE player_vehicles SET state = ?, depotprice = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {0, price, body, engine, fuel, plate})
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện được tạm giam với mức phạt "..price.."$", 5000, 'info')
        else
            MySQL.Async.execute(
                'UPDATE player_vehicles SET state = ?, body = ?, engine = ?, fuel = ? WHERE plate = ?',
                {2, body, engine, fuel, plate})
                TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Phương tiện bị thu giữ", 5000, 'info')
        end
    end
end)

RegisterNetEvent('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterNetEvent('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {
        dna = citizenid,
        bloodtype = bloodtype
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterNetEvent('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterNetEvent('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList and next(blooddropList) then
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn phải có túi chứng cứ trống", 5000, 'error')
    end
end)

RegisterNetEvent('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn phải có túi chứng cứ trống", 5000, 'error')
    end
end)

RegisterNetEvent('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local casingId = CreateCasingId()
    local weaponInfo = QBCore.Shared.Weapons[weapon]
    local serieNumber = nil
    if weaponInfo then
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem then
            if weaponItem.info and weaponItem.info ~= "" then
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterNetEvent('police:server:UpdateCurrentCops', function()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
end)

RegisterNetEvent('evidence:server:ClearCasings', function(casingList)
    if casingList and next(casingList) then
        for k, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem("empty_evidence_bag", 1) then
        if Player.Functions.AddItem("filled_evidence_bag", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Bạn phải có túi chứng cứ trống", 5000, 'error')
    end
end)

RegisterNetEvent('police:server:showFingerprint', function(playerId)
    local src = source
    TriggerClientEvent('police:client:showFingerprint', playerId, src)
    TriggerClientEvent('police:client:showFingerprint', src, playerId)
end)

RegisterNetEvent('police:server:showFingerprintId', function(sessionId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid)
    TriggerClientEvent('police:client:showFingerprintId', src, fid)
end)

RegisterNetEvent('police:server:SetTracker', function(targetId)
    local src = source
    local Target = QBCore.Functions.GetPlayer(targetId)
    local TrackerMeta = Target.PlayerData.metadata["tracker"]
    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('xt-notify:client:Alert', targetId, "THÔNG BÁO", "Thiết bị theo dõi đã được gỡ bỏ", 5000, 'success')
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Thiết bị theo dõi đã được gỡ bỏ khỏi "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.." !", 5000, 'success')
        TriggerClientEvent('police:client:SetTracker', targetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('xt-notify:client:Alert', targetId, "THÔNG BÁO", "Bạn đã bị gắn thiết bị theo dõi", 5000, 'success')
        TriggerClientEvent('xt-notify:client:Alert', src, "THÔNG BÁO", "Thiết bị theo dõi được gắn trên đối tượng "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.." !", 5000, 'success')
        TriggerClientEvent('police:client:SetTracker', targetId, true)
    end
end)

RegisterNetEvent('police:server:SyncSpikes', function(table)
    TriggerClientEvent('police:client:SyncSpikes', -1, table)
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        UpdateBlips()
    end
end)
