Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

Config.MinPayout = 200 -- Minimum Payout
Config.MaxPayout = 300 -- Maximum Payout
Config.BailPrice = 1000
Config.MinShipments = 5 -- the minimum value must be 1
Config.MaxShipments = 10 -- the maximum value must be the same as the number of Customers
Config.Vehicle = 'benson'
Config.Courier = {
	['Jobstart'] = { --the place where you start and finish your work
		Pos = {x = 1196.74, y = -3253.69, z = 6.15},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 25,
	},
	['Pickup'] = { --place of accepting the order, which randomizes the number of packages
		Pos = {x = 1183.46, y = -3303.89, z = 5.97},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 25,
	},
	['Carspawn'] = { --the place where the company car appears
		Pos = {x = 1169.97, y = -3308.01, z = 5.88},
		Heading = 357.18,
		Model  = 'benson',
	},
	['Gate'] = { --gates to which we have to go to load packages
		{x = 1218.41, y = -3230.92, z = 5.52, h = 359.92},
		{x = 1233.56, y = -3330.42, z = 5.51, h = 180.34},
		{x = 1190.64, y = -3330.43, z = 5.51, h = 180.96},
		{x = 1233.61, y = -3230.84, z = 5.91, h = 359.81},
		{x = 1218.52, y = -3330.3, z = 5.91, h = 180.5},
	},
	['Customers'] = { --x,y,z the place of the appearance of the pedal, gotoX,gotoY,gotoZ the place to go when you hand over the package
		{blip, ped, x = 1291.94, y = -1717.68, z = 55.06-0.4, h = 198.72, gotoX = 1289.2, gotoY = -1710.65, gotoZ = 55.48, gotoH = 19.52, done = false},
		{blip, ped, x = 1435.43, y = -1498.35, z = 63.22-0.4, h = 159.5, gotoX = 1437.44, gotoY = -1491.95, gotoZ = 63.62, gotoH = 343.07, done = false},
		{blip, ped, x = 1229.22, y = -733.69, z = 60.65-0.4, h = 111.54, gotoX = 1229.28, gotoY = -725.55, gotoZ = 60.8, gotoH = 291.23, done = false},
		{blip, ped, x = 866.74, y = -576.45, z = 57.36-0.4, h = 309.83, gotoX = 861.65, gotoY = -583.23, gotoZ = 58.16, gotoH = 177.55, done = false},
		{blip, ped, x = 1095.69, y = -426.12, z = 67.12-0.4, h = 73.86, gotoX = 1099.46, gotoY = -438.55, gotoZ = 67.79, gotoH = 170.12, done = false},
		{blip, ped, x = 268.23, y = -1708.4, z = 29.38-0.4, h = 45.2, gotoX = 269.55, gotoY = -1712.88, gotoZ = 29.67, gotoH = 318.31, done = false},
		{blip, ped, x = 85.82, y = -1944.06, z = 20.75-0.4, h = 314.59, gotoX = 80.91, gotoY = -1949.18, gotoZ = 20.78, gotoH = 52.24, done = false},
		{blip, ped, x = -1243.92, y = -1366.77, z = 4.04-0.4, h = 279.53, gotoX = -1246.96, gotoY = -1358.32, gotoZ = 7.82, gotoH = 19.8, done = false},
		{blip, ped, x = -292.9, y = 277.29, z = 88.64-0.4, h = 179.41, gotoX = -292.97, gotoY = 282.44, gotoZ = 89.89, gotoH = 359.8, done = false},
		{blip, ped, x = -314.42, y = -264.55, z = 32.33-0.4, h = 231.56, gotoX = -327.24, gotoY = -254.67, gotoZ = 34.39, gotoH = 53.23, done = false},
	},
	['Peds'] = { --list of pedal models that may appear
		[1] = {ped = 'a_m_m_bevhills_01'},
	},
	['Text'] = { --the text that is randomly selected over the customer when we return the package
		[1] = {text = 'Cảm ơn'},
		[2] = {text = 'Thanh kiu bấy bì'},
		[3] = {text = "Bạn thật tuyệt vời"},
		[4] = {text = 'Iu bạn lắm'},
		[5] = {text = 'Tôi sẽ vote cho bạn 5 sao'},
		[6] = {text = 'Ơn giời bạn đây rồi'},
		[7] = {text = 'Wow!!! Tốc độ giao hàng thật nhanh'},
		[8] = {text = "Uwu Uwu"},
		[9] = {text = "Tôi muốn ôm bạn một cái quá!"},
	},
}


Config.Clothes = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 242,   ['torso_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 10,   ['pants_2'] = 0,
        ['shoes_1'] = 48,   ['shoes_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 250,   ['torso_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 12,   ['pants_2'] = 7,
        ['shoes_1'] = 3,   ['shoes_2'] = 0,
    }
  }
