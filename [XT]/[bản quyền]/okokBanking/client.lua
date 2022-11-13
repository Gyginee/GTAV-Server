local PlayerData = {}
local trans = {}
local societyTrans = {}
local societyIdent, societyDays
local didAction = false
local isBankOpened = false
local canAccessSociety = false
local society = ''
local societyInfo
local closestATM, atmPos
local MoATM = false

local playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney
QBCore = exports['qb-core']:GetCoreObject()
CreateThread(function()
	while QBCore.Functions.GetPlayerData().job == nil do
		Wait(10)
	end
	PlayerData = QBCore.Functions.GetPlayerData()
end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    exports['qb-target']:AddTargetModel(Config.ATM,  {
          options = {
              {
                  event = "okokBanking:client:OpenATM",
                  icon = "fa-solid fa-credit-card",
                  label = "Dùng ATM",
              },
              },
          distance = 1.0
      })
end)
CreateThread(function()
	if Config.ShowBankBlips then
		Wait(2000)
		for k,v in ipairs(Config.BankLocations)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite (blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blipScale)
			SetBlipColour (blip, v.blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipText)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

function NearATM()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for i = 1, #Config.ATM do
        local atm = GetClosestObjectOfType(pos.x, pos.y, pos.z, Config.ATMDistance + 5, Config.ATM[i].model, false, false, false)
        if DoesEntityExist(atm) then
        	if atm ~= closestATM then
        		closestATM = atm
	        	atmPos = GetEntityCoords(atm)
	        end
	        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, atmPos.x, atmPos.y, atmPos.z, true)
	        if dist <= Config.ATMDistance then
	            return true
	        elseif dist <= Config.ATMDistance + 5 then
	        	return "update"
	        end
	    end
    end
end

function NearBank()
	local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    for k, v in pairs(Config.BankLocations) do
        local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)

        if dist <= v.BankDistance then
            return true
        elseif dist <= v.BankDistance + 5 then
        	return "update"
        end
    end
end

RegisterNetEvent("okokBanking:client:OpenBank", function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'loading_data',
	})
	Wait(500)
	openBank()
end)

RegisterNetEvent("okokBanking:client:OpenATM", function()
	local dict = 'anim@amb@prop_human_atm@interior@male@enter'
	local anim = 'enter'
	local ped = PlayerPedId()
	QBCore.Functions.TriggerCallback("okokBanking:GetPIN", function(pin)
		if pin then
			QBCore.Functions.Progressbar("dut-the", "Đút thẻ", 2000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				if not isBankOpened then
					isBankOpened = true
					RequestAnimDict(dict)
					while not HasAnimDictLoaded(dict) do
						Wait(7)
					end
					TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
					Wait(Config.AnimTime)
					ClearPedTasks(ped)
					SetNuiFocus(true, true)
					SendNUIMessage({
					action = 'atm',
					pin = pin,
					})
				end
			end, function() -- Cancel
				ClearPedTasks(ped)
				exports['xt-notify']:Alert("NGÂN HÀNG", "Huỷ", 5000, 'error')
			end)
		else
			exports['xt-notify']:Alert("NGÂN HÀNG", "Bạn không có thẻ ngân hàng", 5000, 'error')
		end
	end)
end)

function openBank()
	local hasJob = false
	local playeJob = PlayerData.job
	local playerJobName = ''
	local playerJobGrade = ''
	local jobLabel = ''
	isBankOpened = true
	canAccessSociety = false
	if playeJob ~= nil then
		hasJob = true
		playerJobName = playeJob.name
		playerJobGrade = playeJob.grade.name
		jobLabel = playeJob.label
		society = 'society_'..playerJobName
	end

	QBCore.Functions.TriggerCallback("okokBanking:GetPlayerInfo", function(data)
		QBCore.Functions.TriggerCallback("okokBanking:GetOverviewTransactions", function(cb, identifier, allDays)
			for k,v in pairs(Config.Societies) do
				if playerJobName == v then
					if json.encode(Config.SocietyAccessRanks) ~= '[]' then
						for k2,v2 in pairs(Config.SocietyAccessRanks) do
							if playerJobGrade == v2 then
								canAccessSociety = true
							end
						end
					else
						canAccessSociety = true
					end
				end
			end

			if canAccessSociety then
				QBCore.Functions.TriggerCallback("okokBanking:SocietyInfo", function(cb)
					if cb ~= nil then
						societyInfo = cb
					else
						local societyIban = Config.IBANPrefix..jobLabel
						TriggerServerEvent("okokBanking:CreateSocietyAccount", society, jobLabel, 0, societyIban)
						Wait(200)
						QBCore.Functions.TriggerCallback("okokBanking:SocietyInfo", function(cb)
							societyInfo = cb
						end, society)
					end
				end, society)
			end

			isBankOpened = true
			trans = cb
			playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney = data.playerName, data.playerBankMoney, data.playerIBAN, identifier, allDays, data.walletMoney
			QBCore.Functions.TriggerCallback("okokBanking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
				societyIdent = societyID
				societyDays = societyAllDays
				societyTrans = societyTranscb

				if data.playerIBAN ~= nil then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'bankmenu',
						playerName = data.playerName,
						playerSex = data.sex,
						playerBankMoney = data.playerBankMoney,
						walletMoney = walletMoney,
						playerIBAN = data.playerIBAN,
						db = trans,
						identifier = trsIdentifier,
						graphDays = allDaysValues,
						isInSociety = canAccessSociety,
					})
				else
					GenerateIBAN()
					Wait(1000)
					QBCore.Functions.TriggerCallback("okokBanking:GetPlayerInfo", function(data)
						SetNuiFocus(true, true)
						SendNUIMessage({
							action = 'bankmenu',
							playerName = data.playerName,
							playerSex = data.sex,
							playerBankMoney = data.playerBankMoney,
							walletMoney = walletMoney,
							playerIBAN = data.playerIBAN,
							db = trans,
							identifier = trsIdentifier,
							graphDays = allDaysValues,
							isInSociety = canAccessSociety,
						})
					end)
				end
			end, society)
		end)
	end)
end
local timer = 0
local sansang = true
CreateThread(function()
    while true do
        if sansang == false then
            if timer <= 0 then
                timer = 0
                sansang = true
            else
                timer = timer - 10
            end
        end
        Wait(10000)
    end
end)
RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isBankOpened = false
		SetNuiFocus(false, false)
	elseif data.action == "deposit" then
		if sansang then
			if tonumber(data.value) ~= nil then
				if tonumber(data.value) > 0 then
					if data.window == 'bankmenu' then
						TriggerServerEvent('okokBanking:DepositMoney', tonumber(data.value))
						sansang = false
					elseif data.window == 'societies' then
						TriggerServerEvent('okokBanking:DepositMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name)
						sansang = false
					end
				else
					exports['xt-notify']:Alert("NGÂN HÀNG", "Số tiền không hợp lệ", 5000, 'error')
				end
			else
				exports['xt-notify']:Alert("NGÂN HÀNG", "Đầu vào không hợp lệ", 5000, 'error')
			end
		else
			exports['xt-notify']:Alert("NGÂN HÀNG", "Bạn đang thao tác quá nhanh", 5000, 'error')
		end
	elseif data.action == "withdraw" then
		if sansang then 
			if tonumber(data.value) ~= nil then
				if tonumber(data.value) > 0 then
					if data.window == 'bankmenu' then
						TriggerServerEvent('okokBanking:WithdrawMoney', tonumber(data.value))
						sansang = false
					elseif data.window == 'societies' then
						TriggerServerEvent('okokBanking:WithdrawMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name, societyInfo.value)
						sansang = false
					end
				else
					exports['xt-notify']:Alert("NGÂN HÀNG", "Số tiền không hợp lệ", 5000, 'error')
				end
			else
				exports['xt-notify']:Alert("NGÂN HÀNG", "Đầu vào không hợp lệ", 5000, 'error')
			end
		else
			exports['xt-notify']:Alert("NGÂN HÀNG", "Bạn đang thao tác quá nhanh", 5000, 'error')
		end
	elseif data.action == "transfer" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				QBCore.Functions.TriggerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer, name)
					if isUsed ~= nil then
						if data.window == 'bankmenu' then
							if sansang then
								if isPlayer then
									TriggerServerEvent('okokBanking:TransferMoney', tonumber(data.value), data.iban:upper(), isUsed.citizenid, isUsed.money, name)
									sansang = false
								elseif not isPlayer then
									TriggerServerEvent('okokBanking:TransferMoneyToSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society)
									sansang = false
								end
							else
								exports['xt-notify']:Alert("NGÂN HÀNG", "Bạn đang thao tác quá nhanh", 5000, 'error')
							end
						elseif data.window == 'societies' then
							local toMyself = false
							if data.iban:upper() == playerIBAN then
								toMyself = true
							end
							if isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToPlayerFromSociety', tonumber(data.value), data.iban:upper(), isUsed.citizenid, isUsed.money, name, societyInfo.society, societyInfo.society_name, societyInfo.value, toMyself)
							elseif not isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToSocietyFromSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society, societyInfo.society, societyInfo.society_name, societyInfo.value)
							end
						end
					elseif isUsed == nil then
						exports['xt-notify']:Alert("NGÂN HÀNG", "IBAN này không tồn tại", 5000, 'error')
					end
				end, data.iban:upper())
			else
				exports['xt-notify']:Alert("NGÂN HÀNG", "Số tiền không hợp lệ", 5000, 'error')
			end
		else
			exports['xt-notify']:Alert("NGÂN HÀNG", "Đầu vào không hợp lệ", 5000, 'error')
		end
	elseif data.action == "overview_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'overview_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			playerIBAN = playerIBAN,
			db = trans,
			identifier = trsIdentifier,
			graphDays = allDaysValues,
			isInSociety = canAccessSociety,
		})
	elseif data.action == "transactions_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'transactions_page',
			db = trans,
			identifier = trsIdentifier,
			graph_values = allDaysValues,
			isInSociety = canAccessSociety,
		})
	elseif data.action == "society_transactions" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_transactions',
			db = societyTrans,
			identifier = societyIdent,
			graph_values = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "society_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			playerIBAN = playerIBAN,
			db = societyTrans,
			identifier = societyIdent,
			graphDays = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "settings_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'settings_page',
			isInSociety = canAccessSociety,
			ibanCost = Config.IBANChangeCost,
			ibanPrefix = Config.IBANPrefix,
			ibanCharNum = Config.CustomIBANMaxChars,
			pinCost = Config.PINChangeCost,
			pinCharNum = 4,
		})
	elseif data.action == "atm" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Wait(500)
		openBank()
	elseif data.action == "change_iban" then
		if Config.CustomIBANAllowLetters then
			local iban = Config.IBANPrefix..data.iban:upper()		
			QBCore.Functions.TriggerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)

				if isUsed == nil then
					TriggerServerEvent('okokBanking:UpdateIbanDB', iban, Config.IBANChangeCost)
				elseif isUsed ~= nil then
					exports['xt-notify']:Alert("NGÂN HÀNG", "IBAN này đã được sử dụng", 5000, 'error')
				end
			end, iban)
		elseif not Config.CustomIBANAllowLetters then
			if tonumber(data.iban) ~= nil then
				local iban = Config.IBANPrefix..data.iban:upper()			
				QBCore.Functions.TriggerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)

					if isUsed == nil then
						TriggerServerEvent('okokBanking:UpdateIbanDB', iban, Config.IBANChangeCost)
					elseif isUsed ~= nil then
						exports['xt-notify']:Alert("NGÂN HÀNG", "IBAN này đã được sử dụng", 5000, 'error')
					end
				end, iban)
			else
				exports['xt-notify']:Alert("NGÂN HÀNG", "Bạn chỉ có thể sử dụng các số trên IBAN của mình", 5000, 'error')
			end
		end
	elseif data.action == "change_pin" then
		if tonumber(data.pin) ~= nil then
			if string.len(data.pin) == 4 then
				QBCore.Functions.TriggerCallback("okokBanking:GetPIN", function(pin)
            		if pin then
            			TriggerServerEvent('okokBanking:UpdatePINDB', data.pin, Config.PINChangeCost)
            		else
            			TriggerServerEvent('okokBanking:UpdatePINDB', data.pin, 0)
					end
				end)
			else
				exports['xt-notify']:Alert("NGÂN HÀNG", "Mã PIN của bạn phải dài 4 chữ số", 5000, 'info')
			end
		else
			exports['xt-notify']:Alert("NGÂN HÀNG", "Bạn chỉ có thể sử dụng chữ số", 5000, 'info')
		end
	end
end)

RegisterNetEvent("okokBanking:updateTransactions", function(money, wallet)
	Wait(100)
	if isBankOpened then
		QBCore.Functions.TriggerCallback("okokBanking:GetOverviewTransactions", function(cb, id, allDays)
			trans = cb
			walletMoney = wallet
			playerBankMoney = money
			allDaysValues = allDays
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'overview_page',
				playerBankMoney = playerBankMoney,
				walletMoney = walletMoney,
				playerIBAN = playerIBAN,
				db = trans,
				identifier = trsIdentifier,
				graphDays = allDaysValues,
				isInSociety = canAccessSociety,
			})
			TriggerEvent('okokBanking:updateMoney', money, wallet)
		end)
	end
end)
function GetATMStatus()
    if MoATM then
		return true
	else
		return false
	end
end
RegisterNetEvent("okokBanking:updateMoney", function(money, wallet)
	if isBankOpened then
		playerBankMoney = money
		walletMoney = wallet
		SendNUIMessage({
			action = 'updatevalue',
			playerBankMoney = money,
			walletMoney = wallet,
		})
	end
end)

RegisterNetEvent("okokBanking:updateIban", function(iban)
	playerIBAN = iban
	SendNUIMessage({
		action = 'updateiban',
		iban = playerIBAN,
	})
end)

RegisterNetEvent("okokBanking:updateIbanPinChange", function()
	Wait(100)
	QBCore.Functions.TriggerCallback("okokBanking:GetOverviewTransactions", function(cbs, ids, allDays)
		trans = cbs
	end)
end)

RegisterNetEvent("okokBanking:updateTransactionsSociety", function(wallet)
	Wait(100)
	QBCore.Functions.TriggerCallback("okokBanking:SocietyInfo", function(cb)
		QBCore.Functions.TriggerCallback("okokBanking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
			QBCore.Functions.TriggerCallback("okokBanking:GetOverviewTransactions", function(cbs, ids, allDays)
				trans = cbs
				walletMoney = wallet
				societyDays = societyAllDays
				societyIdent = societyID
				societyTrans = societyTranscb
				societyInfo = cb
				if cb ~= nil then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'society_page',
						walletMoney = wallet,
						db = societyTrans,
						graphDays = societyDays,
						isInSociety = canAccessSociety,
						societyInfo = societyInfo,
					})
				else

				end
			end)
		end, society)
	end, society)
end)

function GenerateIBAN()
	math.randomseed(GetGameTimer())
	local stringFormat = "%0"..Config.IBANNumbers.."d"
	local number = math.random(0, 10^Config.IBANNumbers-1)
	number = string.format(stringFormat, number)
	local iban = Config.IBANPrefix..number:upper()
	local isIBanUsed = true
	local hasChecked = false

	while true do
		Wait(10)
		if isIBanUsed and not hasChecked then
			isIBanUsed = false
			QBCore.Functions.TriggerCallback("okokBanking:IsIBanUsed", function(isUsed)
				if isUsed ~= nil then
					isIBanUsed = true
					number = math.random(0, 10^Config.IBANNumbers-1)
					number = string.format("%03d", number)
					iban = Config.IBANPrefix..number:upper()
				elseif isUsed == nil then
					hasChecked = true
					isIBanUsed = false
				end
				canLoop = true
			end, iban)
		elseif not isIBanUsed and hasChecked then
			break
		end
	end
	TriggerServerEvent('okokBanking:SetIBAN', iban)
end