Config = {}

Config.AttachedVehicle = nil
Config.CurrentTowedVehicle = nil
Config.AuthorizedIds = {
    "insertcitizenidhere",
}

Config.MaxStatusValues = {
    ["engine"] = 1000.0,
    ["body"] = 1000.0,
    ["radiator"] = 100,
    ["axle"] = 100,
    ["brakes"] = 100,
    ["clutch"] = 100,
    ["fuel"] = 100,
}

Config.ValuesLabels = {
    ["engine"] = "Động cơ",
    ["body"] = "Thân vỏ",
    ["radiator"] = "Bộ tản nhiệt",
    ["axle"] = "Trục truyền động",
    ["brakes"] = "Phanh",
    ["clutch"] = "Ly hợp",
    ["fuel"] = "Thùng xăng",
}
Config.Damages = {
    ["radiator"] = "Bộ tản nhiệt",
    ["axle"] = "Trục lái",
    ["brakes"] = "Phanh",
    ["clutch"] = "Ly hợp",
    ["fuel"] = "Thùng xăng",
}

Config.RepairCost = {
    ["body"] = "plastic",
    ["radiator"] = "plastic",
    ["axle"] = "steel",
    ["brakes"] = "iron",
    ["clutch"] = "aluminum",
    ["fuel"] = "plastic",
}

Config.RepairCostAmount = {
    ["engine"] = {
        item = "metalscrap",
        costs = 2,
    },
    ["body"] = {
        item = "plastic",
        costs = 3,
    },
    ["radiator"] = {
        item = "steel",
        costs = 5,
    },
    ["axle"] = {
        item = "aluminum",
        costs = 7,
    },
    ["brakes"] = {
        item = "copper",
        costs = 5,
    },
    ["clutch"] = {
        item = "copper",
        costs = 6,
    },
    ["fuel"] = {
        item = "plastic",
        costs = 5,
    },
}

Config.Businesses = {
    "Sửa xe",
}

Config.Plates = {
    [1] = {
        coords = vector4(-327.51, -144.04, 39.03, 69.39),
        AttachedVehicle = nil,
    },
    [2] = {
        coords = vector4(-324.95, -139.23, 39.03, 70.21),
        AttachedVehicle = nil,
    },
    [3] = {
        coords = vector4(-323.84, -133.96, 39.03, 70.78),
        AttachedVehicle = nil,
    },
    [4] = {
        coords = vector4(-321.76, -128.64, 39.03, 69.36),
        AttachedVehicle = nil,
    },
    [5] = {
        coords = vector4(-320.1, -123.51, 39.03, 71.55),
        AttachedVehicle = nil,
    },
    [6] = {
        coords = vector4(-318.15, -118.46, 39.03, 71.1),
        AttachedVehicle = nil,
    },
    [7] = {
        coords = vector4(-316.07, -113.35, 39.03, 69.99),
        AttachedVehicle = nil,
    },
    [8] = {
        coords = vector4(-313.62, -108.31, 39.03, 70.56),
        AttachedVehicle = nil,
    },
    [9] = {
        coords = vector4(-311.54, -103.04, 39.03, 70.01),
        AttachedVehicle = nil,
    },
}

Config.Locations = {
    ["exit"] = vector3(-339.04, -135.53, 39),
    ["stash"] = vector3(-326.74, -157.54, 38.88),
    ["duty"] = vector3(-346.7, -111.36, 37.87),
    ["vehicle"] = vector4(-353.24, -89.89, 39.11, 70.84),
}

Config.Vehicles = {
    ["flatbedm2"] = "Xe nâng",
    ["hvywrecker"] = "Xe kéo",
}

Config.MinimalMetersForDamage = {
    [1] = {
        min = 8000,
        max = 12000,
        multiplier = {
            min = 1,
            max = 8,
        }
    },
    [2] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 8,
            max = 16,
        }
    },
    [3] = {
        min = 12000,
        max = 16000,
        multiplier = {
            min = 16,
            max = 24,
        }
    },
}

