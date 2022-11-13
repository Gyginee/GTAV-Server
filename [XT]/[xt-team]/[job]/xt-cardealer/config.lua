Config = Config or {}

--[[ SETUP ]]--
Config.TestDriveTimer = 60 -- THỜI GIAN LÁI THỬ (GIÂY)
----------------------------

--[[ LOG ]]--

---

--[[ VỊ TRÍ ]] --
Config.Locations = {
    ["menu"] = { 
        coords = {x = 133.85, y = -153.52, z = 54.8, h = 132.79, r = 1.0}, -- VỊ TRÍ MỞ MENU SHOWROOM
    },
    ["boss"] = {
        coords = {x = 147.25, y = -140.03, z = 54.8, h = 187.16, r = 1.0}, -- VỊ TRÍ MỞ BẢN QUẢN LÝ, ĐẶT HÀNG
    },
    ["platform"] = {
        coords = {x = -791.724, y = -217.602, z = 37.427, h = 221.2, r = 1.0}, -- XE NẰM Ở VỊ TRÍ TRUNG TÂM
    },
    ["stash"] = {
        coords = {x = -805.376, y = -204.715, z = 37.163, h = 221.2, r = 1.0}, -- KHO CHUNG
    },
    ["stock"] = {
        coords = {x = 120.25, y = -129.58, z = 54.84, h = 159.89, r = 1.0}, -- VỊ TRÍ NHẬP KHO XE
    },
    ["catxe"] = {
        coords = {x = -773.107, y = -233.657, z = 37.079, h = 29.99, r = 1.0}, -- VỊ TRÍ CẤT XE LÁI THỬ
    },
}
------------------


vector4(142.98, -164.63, 54.45, 205.0)
--[[ VỊ TRÍ XE SHOWROOM ]]--
Config.ShowroomLocation = {
    [1] = {spawn = vector4(120.5, -156.29, 49.95, 205.99), dist = vector3(121.6, -153.4, 54.8)},
    [2] = {spawn =vector4(126.04, -158.3, 49.95, 205.99), dist = vector3(126.79, -155.06, 54.8)},
    [3] = {spawn =vector4(131.7, -160.34, 49.95, 205.99), dist = vector3(132.34, -157.42, 54.8)},
    [4] = {spawn =vector4(137.36, -162.27, 49.95, 205.99), dist = vector3(137.52, -159.34, 54.8)},
    [5] = {spawn =vector4(142.98, -164.63, 49.95, 205.99), dist = vector3(144.34, -161.14, 54.8)},
    [6] = {spawn =vector4(138.61, -149.65, 53.93, 106.21), dist = vector3(134.21, -153.51, 54.8)},
}


--[[VỊ TRÍ CẢNG]]--
Config.PortLocation = {
    [1] = vector4(1192.741, -2942.90, 5.9021, 90.24),
    [2] = vector4(1192.266, -2937.29, 5.9021, 93.08),
    [3] = vector4(1192.005, -2926.98, 5.9021, 90.94),
    [4] = vector4(1191.250, -2914.24, 5.9021, 93.56),
    [5] = vector4(1193.832, -2902.58, 5.9021, 92.90),
}

