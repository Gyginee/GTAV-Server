Config = {}

Config = {
    ttcoords = vector3(2501.87, 4800.76, 35.01),
    cowcoords = vector3(2438.240, 4765.890, 35.00),
    Cow = {
      [1] = {coords = vector3(2420.14, 4784.49, 34.65), heading = -149.404},
      [2] = {coords = vector3(2441.06, 4755.05, 33.85), heading = 163.23},
      [3] = {coords = vector3(2443.96, 4764.95, 33.85), heading = 104.46},
      [4] = {coords = vector3(2434.870, 4764.150, 33.80), heading = 39.3},
    },
    Thaydo = vector3(2436.9, 4773.49, 34.37), --Thay đồ
    Ped = vector4(2436.74, 4773.69, 33.37, 235.9), --NPC

}

Config.blips = {
    {title = "Tiệt trùng sữa", colour = 4, id = 141, x = 2438.240, y = 4765.890,z = 35.00 },
    {title = "Trại bò", colour = 4, id = 402, x = Config.ttcoords.x, y = Config.ttcoords.y, z = Config.ttcoords.z },
}

Config.CanMilk = false

Config.Timepick = 5000
Config.SleepTime = 5000

Config.Clothes = {
  male = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1'] = 97,   ['torso_2'] = 1,
      ['arms'] = 15,
      ['pants_1'] = 97,   ['pants_2'] = 6,
      ['shoes_1'] = 12,   ['shoes_2'] = 6,
      ['hat_1'] = 3,   ['hat_2'] = 2,
  },
  female = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1'] = 63,   ['torso_2'] = 2,
      ['arms'] = 15,
      ['pants_1'] = 2,   ['pants_2'] = 2,
      ['shoes_1'] = 100,   ['shoes_2'] = 0,
      ['hat_1'] = 93,   ['hat_2'] = 8,
  }
}