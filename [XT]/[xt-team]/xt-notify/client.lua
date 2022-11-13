function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('xt-notify:client:Alert')
AddEventHandler('xt-notify:client:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)

---[ EXAMPLE NOTIFY (DELETE THIS BELOW) ]---

RegisterCommand('noti-success', function()
	exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đã nhận được <span style='color:#30ff00'><b>100$</b></span>!", 5000, 'success')
end)

RegisterCommand('noti-info', function()
	exports['xt-notify']:Alert("THÔNG BÁO", "Thành phố ngắt điện trong <span style='color:#0092ff'>5 phút</span>!", 5000, 'info')
end)

RegisterCommand('noti-error', function()
	exports['xt-notify']:Alert("THÔNG BÁO", "Bạn không đủ <span style='color:#fc1100'>quyền hạn</span>!", 5000, 'error')
end)

RegisterCommand('noti-warning', function()
	exports['xt-notify']:Alert("THÔNG BÁO", "Bạn đang bị <span style='color:#ffd700'>căng thẳng</span>", 5000, 'warning')
end)

RegisterCommand('noti-sms', function()
	exports['xt-notify']:Alert("TIN NHẮN", "<span style='color:#01a2dc'>0986868686: </span> Bao giờ định trả nợ anh thế em trai?", 5000, 'sms')
end)

RegisterCommand('noti-long', function()
	exports['xt-notify']:Alert("LƯU", "Trang phục của bạn đã được lưu", 5000, 'long')
end)