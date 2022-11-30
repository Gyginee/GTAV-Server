Config = {}

Config.UserLicense = "None"
Config["image_source"] = "nui://lj-inventory/html/images/"
Config.CloseInventoryHudTrigger = "lj-inventory:closeInventory"

Config["chance"] = {
	[1] = { name = "Common", rate = 40 },
	[2] = { name = "Rare", rate = 30 },
	[3] = { name = "Epic", rate = 22 },
	[4] = { name = "Unique", rate = 8 },
	[5] = { name = "Legendary", rate = 0 },
}

Config["broadcast"] = true
Config["broadcast_tier"] = {
	[1] = false,
	[2] = false,
	[3] = false,
	[4] = false,
	[5] = false,
}

Config["hom"] = {
	["case"] = {
		name = "Case #1",
		list = {
			{ label ="Nước Suối", item = "water_bottle", amount = 5, tier = 1 },
			{ money = 50000, tier = 1 },
			{ money = 125000, tier = 2 },
		--[[ 	{ label ="Ma Tuý",item = 'joint', amount = 2, tier = 3 }, ]]
			{ label ="Súng Ngắn",weapon = "weapon_pistol", amount = 1, tier = 4 },
			{ label ="Súng Trường",weapon = "weapon_assaultrifle", amount = 1, tier = 1 },
			{ label ="Súng Ngắm",weapon = "weapon_sniperrifle", amount = 1, tier = 1 },
		}
	},
}
