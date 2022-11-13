
QBCore = nil
LoggedIn = false

QBCore = exports['qb-core']:GetCoreObject()


-- local 
local notifIn = false
local notifOut = false



-- Code
-- Citizen.CreateThread(function()
-- Citizen.Wait(200)
    -- local vungsang = AddBlipForRadius(2045.88, 3438.16, 43.9, 200.0)  -- -- X Y Z  VÀ H ( H LÀ ĐỘ RỘNG ) 
    -- SetBlipRotation(vungsang, 0)
    -- SetBlipColour(vungsang, 1)
    -- SetBlipAlpha(vungsang,100)
	-- local blips = AddBlipForCoord(2045.88, 3438.16, 43.9)
	-- SetBlipSprite(blips, 403)
	-- SetBlipDisplay(blips, 2)
	-- SetBlipScale(blips, 0.5)
	-- SetBlipAsShortRange(blips, true)
	-- SetBlipColour(blips, 1)
	-- BeginTextCommandSetBlipName("STRING")
	-- AddTextComponentSubstringPlayerName("Địa Bàn Bãi Đá")
	-- EndTextCommandSetBlipName(blips)
    -- while true do
        -- local inRange = false

        -- local PlayerPed = PlayerPedId()
        -- local PlayerPos = GetEntityCoords(PlayerPed)

        -- local distance = #(PlayerPos - vector3(-122.22, 987.36, 235.75))
        --------------ZONE NOTI-----------------

			-- local distancekhuvuc = #(PlayerPos - vector3(-122.22, 987.36, 235.75))
			-- if distancekhuvuc < 50.0 then
				-- if not notifIn then
				-- exports['okokNotify']:Alert("KHU VỰC GANG!", "Bạn bước vào vùng tệ nạn. Bạn có thể bị cảnh sát kiểm tra người. Cảnh sát buộc phải bật còi", 5000, 'error')
				-- notifIn = true
				-- notifOut = false
				-- end
			-- else
				-- if not notifOut then
				-- exports['okokNotify']:Alert("KHU VỰC GANG!", "Bạn rời khỏi vùng căng thẳng. Nhưng vẫn có nguy cơ bị khám xét", 5000, 'success')
				-- notifOut = true
				-- notifIn = false
				-- end
			-- end
        -- if not inRange then
            -- Citizen.Wait(2000)
        -- end
        -- Citizen.Wait(3)
    -- end
-- end)


Citizen.CreateThread(function()
Citizen.Wait(200)
    local vungsang1 = AddBlipForRadius(2053.85, 5109.1, 46.09, 200.0)  -- -- X Y Z  VÀ H ( H LÀ ĐỘ RỘNG ) 
    SetBlipRotation(vungsang1, 0)
    SetBlipColour(vungsang1, 1)
    SetBlipAlpha(vungsang1,100)
	local blips = AddBlipForCoord(2053.85, 5109.1, 46.09)
	SetBlipSprite(blips, 403)
	SetBlipDisplay(blips, 2)
	SetBlipScale(blips, 0.5)
	SetBlipAsShortRange(blips, true)
	SetBlipColour(blips, 1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Địa Bàn Nông Trại")
	EndTextCommandSetBlipName(blips)
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance = #(PlayerPos - vector3(-122.22, 987.36, 235.75))
        ----------------ZONE NOTI-----------------

			local distancekhuvuc = #(PlayerPos - vector3(-122.22, 987.36, 235.75))
			if distancekhuvuc < 50.0 then
				if not notifIn then
				exports['xt-notify']:Alert("KHU VỰC GANG!", "Bạn bước vào vùng tệ nạn. Bạn có thể bị cảnh sát kiểm tra người. Cảnh sát buộc phải bật còi", 5000, 'error')
				notifIn = true
				notifOut = false
				end
			else
				if not notifOut then
				exports['xt-notify']:Alert("KHU VỰC GANG!", "Bạn rời khỏi vùng căng thẳng. Nhưng vẫn có nguy cơ bị khám xét", 5000, 'success')
				notifOut = true
				notifIn = false
				end
			end
        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)


function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end