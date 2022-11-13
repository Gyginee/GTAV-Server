Config = {}
Config.distance = 1.5
Config.Car = "utillitruck"
Config.Plate = "DIEN"	 --JUST 4 CHAR, CLIENT HAS RANDOM NUMBER 1000 TO 9999
Config.Pay = math.random(10, 15)
Config.Account = 'bank' --This is where the money is go.

Config.postes = {
	{prop = 'prop_streetlight_01', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
	{prop = 'prop_streetlight_01b', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
	{prop = 'prop_streetlight_03b', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
	{prop = 'prop_telegraph_01b', scenario = 'PROP_HUMAN_SEAT_BENCH', verticalOffset = -0.5, forwardOffset = 0.0, leftOffset = 0.0, angularOffset = 180.0},
}

Config.TiempoParaArreglar = 6  -- Segundos

Config.Locales = {
	iniciarrepa = "[~b~Y~w~] Sửa chữa",
	ponerescalera = "[~b~Y~w~] Để cầu thang",
	sacarescalera = "[~b~Y~w~] Lấy cầu thang",
	espera = "Chờ ~b~ ", -- ..seconds 
	tofinish = "~w~ giây để hoàn thành sửa chữa.",
	startjob = "[~b~E~w~] Bắt đầu công việc",
	jobiniciado = "Công việc bắt đầu, đi đến bãi đậu xe.",
	endjob = "GIỮ ~b~E~w~ ĐỂ KẾT THÚC CÔNG VIỆC",
	jobterminado = "Bạn đã hoàn thành công việc của mình, hẹn gặp bạn một ngày khác!",
	saveescalera = "NHẤN ~b~E~w~ ĐỂ CẤT CẦU THANG",
	cogerescala = "NHẤN ~b~E~w~ ĐỂ LẤY CẦU THANG",
	delcar = "NHẤN ~b~E~w~ ĐỂ TRẢ PHƯƠNG TIỆN",
}

Config.Uniforms = {
	['male'] = {
		outfitData = {
			['t-shirt'] = {item = 15, texture = 0},
			['torso2']  = {item = 105, texture = 0},
			['arms']    = {item = 85, texture = 0},
			['pants']   = {item = 52, texture = 1},
			['shoes']   = {item = 42, texture = 4},
		}
	},
	['female'] = {
	 	outfitData = {
			['t-shirt'] = {item = 14, texture = 0},
			['torso2']  = {item = 22, texture = 0},
			['arms']    = {item = 85, texture = 0},
			['pants']   = {item = 47, texture = 4},
			['shoes']   = {item = 98, texture = 1},
	 	}
	},
}


Config.delveh = vector3(-830.96, -751.02, 22.92)

Config.Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}