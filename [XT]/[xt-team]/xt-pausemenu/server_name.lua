function SetData()
	players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		table.insert( players, player )
end
	local name = GetPlayerName(PlayerId())
	local id = GetPlayerServerId(PlayerId())
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', "~o~X Team~s~ | Discord :  | ID: "..id.."")
end

Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(100)
		SetData()
	end
end)

Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_LEAVE", "~r~Thoát kết nối khỏi ~w~~y~Server~s~ 😭")
end)
Citizen.CreateThread(function()
    AddTextEntry("PM_PANE_QUIT", "~r~Để tắt ~o~FiveM 🐌")
end)
