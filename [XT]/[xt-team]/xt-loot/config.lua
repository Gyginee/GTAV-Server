Config = {}

Config.UserLicense = "None"
Config["image_source"] = "nui://lj-inventoryhud/html/img/items/"
Config.CloseInventoryHudTrigger = "lj-inventoryhud:closeInventory"

Config["chance"] = {
	[1] = { name = "Common", rate = 0 },
	[2] = { name = "Rare", rate = 0 },
	[3] = { name = "Epic", rate = 100 },
	[4] = { name = "Unique", rate = 0} ,
	[5] = { name = "Legendary", rate = 0},
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
			{item = "repairkit", amount=5 , tier = 1},
			{money = 1000, tier = 2},
			{weapon = "weapon_pistol", amount = 1, tier = 3},
			{item = "coffee", amount= 1, tier = 4},
			{item = "firework1", amount= 1, tier = 4},
		}
	},
}