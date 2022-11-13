local QBCore = exports['qb-core']:GetCoreObject()
QBCore.Functions.CreateCallback("okokBanking:GetPlayerInfo", function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	MySQL.Async.fetchAll('SELECT * FROM players WHERE citizenid = @identifier', {
		['@identifier'] = xPlayer.PlayerData.citizenid
	}, function(result)
		local db = result[1]
		local data = {
			playerName = xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname,
			playerBankMoney = xPlayer.PlayerData.money.bank,
			playerIBAN = db.iban,
			walletMoney = xPlayer.PlayerData.money.cash,
			sex = xPlayer.PlayerData.charinfo.gender,
		}

		cb(data)
	end)
end)

QBCore.Functions.CreateCallback("okokBanking:IsIBanUsed", function(source, cb, iban)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	MySQL.Async.fetchAll('SELECT * FROM players WHERE iban = @iban', {
		['@iban'] = iban
	}, function(result)
		local db = result[1]

		if db ~= nil then
			local playerName = json.decode(result[1].charinfo)
			cb(db, true, tostring(playerName.firstname..' '..playerName.lastname))
		else
			MySQL.Async.fetchAll('SELECT * FROM okokBanking_societies WHERE iban = @iban', {
				['@iban'] = iban
			}, function(result2)
				local db2 = result2[1]
				cb(db2, false)
			end)
		end
	end)
end)

QBCore.Functions.CreateCallback("okokBanking:GetPIN", function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local result = MySQL.Sync.fetchAll('SELECT pincode FROM players WHERE citizenid = ?', {xPlayer.PlayerData.citizenid})
	if result then
		local pin = result[1]
		cb(pin.pincode)
	end
end)

QBCore.Functions.CreateCallback("okokBanking:SocietyInfo", function(source, cb, society)
	MySQL.Async.fetchAll('SELECT * FROM okokBanking_societies WHERE society = @society', {
		['@society'] = society
	}, function(result)
		local db = result[1]
		cb(db)
	end)
end)

RegisterServerEvent("okokBanking:CreateSocietyAccount", function(society, society_name, value, iban)
	MySQL.Async.fetchAll('INSERT INTO okokBanking_societies (society, society_name, value, iban) VALUES (@society, @society_name, @value, @iban)', {
		['@society'] = society,
		['@society_name'] = society_name,
		['@value'] = value,
		['@iban'] = iban:upper(),
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:SetIBAN", function(iban)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	MySQL.Async.fetchAll('UPDATE players SET iban = @iban WHERE citizenid = @identifier', {
		['@identifier'] = xPlayer.PlayerData.citizenid,
		['@iban'] = iban,
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:DepositMoney", function(amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.cash
	if amount <= playerMoney then
		xPlayer.Functions.RemoveMoney('cash', amount)
		xPlayer.Functions.AddMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		TriggerEvent('okokBanking:AddDepositTransaction', amount, _source)
		TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã gửi "..amount.."$", 5000, 'success')
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn không có đủ tiền mặt trên người", 5000, 'error')
	end
end)

RegisterServerEvent("okokBanking:WithdrawMoney", function(amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.bank

	if amount <= playerMoney then
		xPlayer.Functions.RemoveMoney('bank', amount)
		xPlayer.Functions.AddMoney('cash', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)

		TriggerEvent('okokBanking:AddWithdrawTransaction', amount, _source)
		TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã rút "..amount.."$", 5000, 'success')
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn không có đủ số dư trong tài khoản ngân hàng", 5000, 'error')
	end
end)

RegisterServerEvent("okokBanking:TransferMoney", function(amount, ibanNumber, targetIdentifier, acc, targetName)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(targetIdentifier)
	local xPlayers = QBCore.Functions.GetPlayers()
	local playerMoney = xPlayer.PlayerData.money.bank
	ibanNumber = ibanNumber:upper()
	if xPlayer.PlayerData.citizenid ~= targetIdentifier then
		if amount <= playerMoney then
			
			if xTarget ~= nil then
				xPlayer.Functions.RemoveMoney('bank', amount)
				xTarget.Functions.AddMoney('bank', amount)
				xPlayer = QBCore.Functions.GetPlayer(_source)

				for i=1, #xPlayers, 1 do
				    local xForPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
				    if xForPlayer.PlayerData.citizenid == targetIdentifier then

				    	TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.PlayerData.money.bank, xTarget.PlayerData.money.cash)
				    	TriggerClientEvent('xt-notify:client:Alert', xPlayers[i], "NGÂN HÀNG", "Bạn đã nhận "..amount.."$ từ "..xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, 5000, 'success')
				    end
				end
				TriggerEvent('okokBanking:AddTransferTransaction', amount, xTarget, _source)
				TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
				TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã chuyển "..amount.."$ tới "..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname, 5000, 'success')
			elseif xTarget == nil then
				local playerAccount = json.decode(acc)
				playerAccount.bank = playerAccount.bank + amount
				playerAccount = json.encode(playerAccount)

				xPlayer.Functions.RemoveMoney('bank', amount)
				xPlayer = QBCore.Functions.GetPlayer(_source)

				TriggerEvent('okokBanking:AddTransferTransaction', amount, 1, _source, targetName, targetIdentifier)
				TriggerClientEvent('okokBanking:updateTransactions', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
				TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã chuyển "..amount.."$ tới "..targetName, 5000, 'success')

				MySQL.Async.fetchAll('UPDATE players SET money = @playerAccount WHERE citizenid = @target', {
					['@playerAccount'] = playerAccount,
					['@target'] = targetIdentifier
				}, function(changed)

				end)
			end
		else
			TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn không có đủ số dư trong tài khoản ngân hàng", 5000, 'error')
		end
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn không thể gửi tiền cho bản thân", 5000, 'error')
	end
end)

RegisterServerEvent("okokBanking:DepositMoneyToSociety", function(amount, society, societyName)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.cash

	if amount <= playerMoney then
		MySQL.Async.fetchAll('UPDATE okokBanking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
		xPlayer.Functions.RemoveMoney('cash', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)

		TriggerEvent('okokBanking:AddDepositTransactionToSociety', amount, _source, society, societyName)
		TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã gửi "..amount.."$ tới "..societyName, 5000, 'success')
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn không có đủ tiền mặt", 5000, 'error')
	end
end)

RegisterServerEvent("okokBanking:WithdrawMoneyToSociety", function(amount, society, societyName, societyMoney)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local db
	local hasChecked = false

	MySQL.Async.fetchAll('SELECT * FROM okokBanking_societies WHERE society = @society', {
		['@society'] = society
	}, function(result)
		db = result[1]
		hasChecked = true
	end)

	MySQL.Async.fetchAll('UPDATE okokBanking_societies SET is_withdrawing = 1 WHERE society = @society AND society_name = @society_name', {
		['@value'] = amount,
		['@society'] = society,
		['@society_name'] = societyName,
	}, function(changed)
	end)

	while not hasChecked do 
		Citizen.Wait(100)
	end
	
	if amount <= db.value then
		if db.is_withdrawing == 1 then
			TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Ai đó đã rút tiền", 5000, 'error')
		else

			MySQL.Async.fetchAll('UPDATE okokBanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
				['@value'] = amount,
				['@society'] = society,
				['@society_name'] = societyName,
			}, function(changed)
			end)
			
			xPlayer.Functions.AddMoney('cash', amount)
			xPlayer = QBCore.Functions.GetPlayer(_source)
			TriggerEvent('okokBanking:AddWithdrawTransactionToSociety', amount, _source, society, societyName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã rút "..amount.."$ từ "..societyName, 5000, 'success')
		end
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Tài khoản công ty của bạn không đủ số dư để gửi ngân hàng", 5000, 'error')
	end

	MySQL.Async.fetchAll('UPDATE okokBanking_societies SET is_withdrawing = 0 WHERE society = @society AND society_name = @society_name', {
		['@value'] = amount,
		['@society'] = society,
		['@society_name'] = societyName,
	}, function(changed)
	end)
end)

RegisterServerEvent("okokBanking:TransferMoneyToSociety", function(amount, ibanNumber, societyName, society)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerMoney = xPlayer.PlayerData.money.bank

		if amount <= playerMoney then
			MySQL.Async.fetchAll('UPDATE okokBanking_societies SET value = value + @value WHERE iban = @iban', {
				['@value'] = amount,
				['@iban'] = ibanNumber
			}, function(changed)
			end)
			xPlayer.Functions.RemoveMoney('bank', amount)
			xPlayer = QBCore.Functions.GetPlayer(_source)

			TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, society, societyName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã chuyển "..amount.."$ tới "..societyName, 5000, 'success')
		else
			TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn không có đủ số dư trong tài khoản ngân hàng", 5000, 'error')
		end
end)

RegisterServerEvent("okokBanking:TransferMoneyToSocietyFromSociety", function(amount, ibanNumber, societyNameTarget, societyTarget, society, societyName, societyMoney)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(targetIdentifier)
	local xPlayers = QBCore.Functions.GetPlayers()

	if amount <= societyMoney then
		MySQL.Async.fetchAll('UPDATE okokBanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
		MySQL.Async.fetchAll('UPDATE okokBanking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = societyTarget,
			['@society_name'] = societyNameTarget,
		}, function(changed)
		end)
		TriggerEvent('okokBanking:AddTransferTransactionFromSociety', amount, society, societyName, societyTarget, societyNameTarget)
		TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã chuyển "..amount.."$ tới "..societyNameTarget, 5000, 'success')
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Tài khoản công ty của bạn không đủ số dư để gửi ngân hàng", 5000, 'error')
	end
end)

RegisterServerEvent("okokBanking:TransferMoneyToPlayerFromSociety", function(amount, ibanNumber, targetIdentifier, acc, targetName, society, societyName, societyMoney, toMyself)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local xTarget = QBCore.Functions.GetPlayerByCitizenId(targetIdentifier)
	local xPlayers = QBCore.Functions.GetPlayers()

	if amount <= societyMoney then
		MySQL.Async.fetchAll('UPDATE okokBanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
		if xTarget ~= nil then
			xTarget.Functions.AddMoney('bank', amount)
			if not toMyself then
				for i=1, #xPlayers, 1 do
				    local xForPlayer = QBCore.Functions.GetPlayer(xPlayers[i])
				    if xForPlayer.PlayerData.citizenid == targetIdentifier then
			    		TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.PlayerData.money.bank, xTarget.PlayerData.money.cash)
			    		TriggerClientEvent('xt-notify:client:Alert', xPlayers[i], "NGÂN HÀNG", "Bạn đã nhận "..amount.."$ từ "..xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname, 5000, 'success')
				    end
				end
			end
			TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã chuyển "..amount.."$ tới "..xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname, 5000, 'success')
		elseif xTarget == nil then
			local playerAccount = json.decode(acc)
			playerAccount.bank = playerAccount.bank + amount
			playerAccount = json.encode(playerAccount)
			TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.PlayerData.money.cash)
			TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn đã chuyển "..amount.."$ tới "..targetName, 5000, 'success')
			MySQL.Async.fetchAll('UPDATE players SET money = @playerAccount WHERE citizenid = @target', {
				['@playerAccount'] = playerAccount,
				['@target'] = targetIdentifier
			}, function(changed)

			end)
		end
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Tài khoản công ty của bạn không đủ số dư để gửi ngân hàng", 5000, 'error')
	end
end)

QBCore.Functions.CreateCallback("okokBanking:GetOverviewTransactions", function(source, cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local playerIdentifier = xPlayer.PlayerData.citizenid
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.Async.fetchAll('SELECT * FROM okokBanking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = playerIdentifier
	}, function(result)
		MySQL.Async.fetchAll('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `okokBanking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY', {

		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)

QBCore.Functions.CreateCallback("okokBanking:GetSocietyTransactions", function(source, cb, society)
	local playerIdentifier = society
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.Async.fetchAll('SELECT * FROM okokBanking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = society
	}, function(result)
		MySQL.Async.fetchAll('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `okokBanking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY AND receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
			['@identifier'] = society
		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)


RegisterServerEvent("okokBanking:AddDepositTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = 'bank',
		['@receiver_name'] = 'Tài khoản ngân hàng',
		['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddWithdrawTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@receiver_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@sender_identifier'] = 'bank',
		['@sender_name'] = 'Tài khoản ngân hàng',
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransaction", function(amount, xTarget, source_, targetName, targetIdentifier)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)
	if targetName == nil then
		MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(xTarget.PlayerData.citizenid),
			['@receiver_name'] = tostring(xTarget.PlayerData.charinfo.firstname..' '..xTarget.PlayerData.charinfo.lastname),
			['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
			['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	elseif targetName ~= nil and targetIdentifier ~= nil then
		MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(targetIdentifier),
			['@receiver_name'] = tostring(targetName),
			['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
			['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	end
end)

RegisterServerEvent("okokBanking:AddTransferTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)
	MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransactionFromSocietyToP", function(amount, society, societyName, identifier, name)

	MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = identifier,
		['@receiver_name'] = name,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransactionFromSociety", function(amount, society, societyName, societyTarget, societyNameTarget)
	
	MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = societyTarget,
		['@receiver_name'] = societyNameTarget,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddDepositTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@sender_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddWithdrawTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = QBCore.Functions.GetPlayer(_source)

	MySQL.Async.fetchAll('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.PlayerData.citizenid),
		['@receiver_name'] = tostring(xPlayer.PlayerData.charinfo.firstname..' '..xPlayer.PlayerData.charinfo.lastname),
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:UpdateIbanDB", function(iban, amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if amount <= xPlayer.PlayerData.money.bank then
		MySQL.Async.fetchAll('UPDATE players SET iban = @iban WHERE citizenid = @identifier', {
			['@iban'] = iban,
			['@identifier'] = xPlayer.PlayerData.citizenid,
		}, function(changed)
		end)

		xPlayer.Functions.RemoveMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, "bank", "Ngân hàng (IBAN)")
		TriggerClientEvent('okokBanking:updateIban', _source, iban)
		TriggerClientEvent('okokBanking:updateIbanPinChange', _source)
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "IBAN đã thay đổi thành công thành "..iban, 5000, 'success')
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn cần phải có "..amount.."$ để thay đổi IBAN của bạn", 5000, 'error')
	end
end)

RegisterServerEvent("okokBanking:UpdatePINDB", function(pin, amount)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if amount <= xPlayer.PlayerData.money.bank then
		MySQL.Async.fetchAll('UPDATE players SET pincode = @pin WHERE citizenid = @identifier', {
			['@pin'] = pin,
			['@identifier'] = xPlayer.PlayerData.citizenid,
		}, function(changed)
		end)

		xPlayer.Functions.RemoveMoney('bank', amount)
		xPlayer = QBCore.Functions.GetPlayer(_source)
		TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.PlayerData.money.bank, xPlayer.PlayerData.money.cash)
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, "bank", "Ngân hàng (PIN)")
		TriggerClientEvent('okokBanking:updateIbanPinChange', _source)
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Mã PIN chuyển thành công thành mã "..pin, 5000, 'success')
	else
		TriggerClientEvent('xt-notify:client:Alert', _source, "NGÂN HÀNG", "Bạn cần phải có "..amount.."$ để thay đổi mã PIN", 5000, 'error')
	end
end)