Config = {}
Config.Locations = {
  label = "Công ty vệ sinh môi trường",
  coords = vector4(-321.87, -1545.87, 31.02, 354.19),
}

Config.Tiencoc = 2500
Config.Clothes = {
  male = {
    ['tshirt_1'] = 59,  ['tshirt_2'] = 0,
    ['torso_1'] = 1,   ['torso_2'] = 0,
      ['arms'] = 0,
      ['pants_1'] = 36,   ['pants_2'] = 0,
      ['shoes_1'] = 27,   ['shoes_2'] = 0,
  },
  female = {
      ['tshirt_1'] = 36,  ['tshirt_2'] = 0,
      ['torso_1'] = 73,   ['torso_2'] = 0,
      ['arms'] = 14,
      ['pants_1'] = 35,   ['pants_2'] = 0,
      ['shoes_1'] = 26,   ['shoes_2'] = 0,
  }
}
Config.Xe = vector4(-322.29, -1522.89, 27.26, 263.09) -- Điểm Lấy xe rác
Config.Tien = 50 -- tiền 1 túi rác

Config.TrashAmt = 15 -- Số túi rác mỗi điểm
-- số lượng đồ vật
Config.Min = 1
Config.Max = 3

Config.Bins = {
  218085040,
  666561306,
  -58485588,
  -206690185,
  1511880420,
  682791951,
  -387405094,
  364445978,
  1605769687,
  -1831107703,
  -515278816,
  -1790177567,
}

Config.Collections = {
  [0] = {name = 'Khu 361', ma = '361' , pos = vector3(-713.77, -1134.46, 10.61)},
  [1] = {name = 'Khu 117', ma = '117' , pos = vector3(-7.97, -1564.73, 29.3)},
  [2] = {name = 'Khu 366', ma = '366' , pos = vector3(-716.91, -882.08, 23.64)},
  [3] = {name = 'Khu 377', ma = '377' , pos = vector3(-560.63, -703.45, 33.02)},
  [4] = {name = 'Khu 346', ma = '346' , pos = vector3(-994.83, -1121.69, 2.16)},
  [5] = {name = 'Khu 345', ma = '345' , pos = vector3(-1055.32, -1016.24, 2.11)},
  [6] = {name = 'Khu 215', ma = '215' , pos = vector3(425.0, -683.23, 29.28)},
  [7] = {name = 'Khu 208', ma = '208' , pos = vector3(395.64, -738.96, 29.04)},
  [8] = {name = 'Khu 204', ma = '204' , pos = vector3(242.52, -824.54, 30.26)},
  [9] = {name = 'Khu 578', ma = '578' , pos = vector3(276.37, -56.66, 70.15)},
  [10] = {name = 'Khu 591', ma = '591' , pos = vector3(393.89, 102.39, 101.89)},
  [11] = {name = 'Khu 203', ma = '203' , pos = vector3(237.46, -680.21, 37.02)},
}


Config.Thuong = {
  'plastic',
  'metalscrap',
  'copper',
  'glass',
  'aluminum'
}
