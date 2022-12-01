Config = {}
Config.EnableExtraMenu = true
Config.MenuItems = {
    [1] = {
        id = 'citizen',
        title = 'Công dân',
        icon = 'user',
        items = {
            {
                id = 'givenum',
                title = 'Đưa số liên lạc',
                icon = 'address-book',
                type = 'client',
                event = 'qb-phone:client:GiveContactDetails',
                shouldClose = true
            }, {
                id = 'getintrunk',
                title = 'Chui cốp',
                icon = 'car',
                type = 'client',
                event = 'qb-trunk:client:GetIn',
                shouldClose = true
            }, {
                id = 'cornerselling',
                title = 'Bán hoa lá',
                icon = 'cannabis',
                type = 'client',
                event = 'qb-drugs:client:cornerselling',
                shouldClose = true
            }, {
                id = 'togglehotdogsell',
                title = 'Bán hot dog',
                icon = 'hotdog',
                type = 'client',
                event = 'qb-hotdogjob:client:ToggleSell',
                shouldClose = true
            }, {
                id = 'interactions',
                title = 'Tương tác',
                icon = 'exclamation-triangle',
                items = {
                    {
                        id = 'handcuff',
                        title = 'Còng',
                        icon = 'user-lock',
                        type = 'client',
                        event = 'police:client:CuffPlayerSoft',
                        shouldClose = true
                    }, {
                        id = 'playerinvehicle',
                        title = 'Đưa vào phương tiện',
                        icon = 'car-side',
                        type = 'client',
                        event = 'police:client:PutPlayerInVehicle',
                        shouldClose = true
                    }, {
                        id = 'playeroutvehicle',
                        title = 'Áp giải ra khỏi xe',
                        icon = 'car-side',
                        type = 'client',
                        event = 'police:client:SetPlayerOutVehicle',
                        shouldClose = true
                    }, {
                        id = 'stealplayer',
                        title = 'Cướp',
                        icon = 'mask',
                        type = 'client',
                        event = 'police:client:RobPlayer',
                        shouldClose = true
                    }, {
                        id = 'escort',
                        title = 'Bắt cóc',
                        icon = 'user-friends',
                        type = 'client',
                        event = 'police:client:KidnapPlayer',
                        shouldClose = true
                    }, {
                        id = 'escort2',
                        title = 'Hộ tống',
                        icon = 'user-friends',
                        type = 'client',
                        event = 'police:client:EscortPlayer',
                        shouldClose = true
                    }, {
                        id = 'escort554',
                        title = 'Con tin',
                        icon = 'child',
                        type = 'client',
                        event = 'A5:Client:TakeHostage',
                        shouldClose = true
                    }
                }
            }
        }
    },
    [2] = {
        id = 'general',
        title = 'Tổng quan',
        icon = 'list-alt',
        items = {
            {
                id = 'house',
                title = 'Bất động sản',
                icon = 'home',
                items = {
                    {
                        id = 'givehousekey',
                        title = 'Đưa chìa khoá nhà',
                        icon = 'key',
                        type = 'client',
                        event = 'qb-houses:client:giveHouseKey',
                        shouldClose = true,
                        items = {}
                    }, {
                        id = 'removehousekey',
                        title = 'Xoá chìa khoá nhà',
                        icon = 'key',
                        type = 'client',
                        event = 'qb-houses:client:removeHouseKey',
                        shouldClose = true,
                        items = {}
                    }, {
                        id = 'togglelock',
                        title = 'Khoá cửa',
                        icon = 'door-closed',
                        type = 'client',
                        event = 'qb-houses:client:toggleDoorlock',
                        shouldClose = true
                    }, {
                        id = 'decoratehouse',
                        title = 'Trang trí',
                        icon = 'boxes',
                        type = 'client',
                        event = 'qb-houses:client:decorate',
                        shouldClose = true
                    }, {
                        id = 'houseLocations',
                        title = 'Đặt địa điểm',
                        icon = 'home',
                        items = {
                            {
                                id = 'setstash',
                                title = 'Đặt hòm',
                                icon = 'box-open',
                                type = 'client',
                                event = 'qb-houses:client:setLocation',
                                shouldClose = true
                            }, {
                                id = 'setoutift',
                                title = 'Đặt tủ quần áo',
                                icon = 'tshirt',
                                type = 'client',
                                event = 'qb-houses:client:setLocation',
                                shouldClose = true
                            }, {
                                id = 'setlogout',
                                title = 'Đặt điểm Đăng xuất',
                                icon = 'door-open',
                                type = 'client',
                                event = 'qb-houses:client:setLocation',
                                shouldClose = true
                            }
                        }
                    }
                }
            }, {
                id = 'clothesmenu',
                title = 'Trang phục',
                icon = 'tshirt',
                items = {
                    {
                        id = 'Hair',
                        title = 'Tóc',
                        icon = 'user',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Ear',
                        title = 'Khuyên tai',
                        icon = 'deaf',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleProps',
                        shouldClose = true
                    }, {
                        id = 'Neck',
                        title = 'Vòng cổ',
                        icon = 'user-tie',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Top',
                        title = 'Áo khoác',
                        icon = 'tshirt',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Shirt',
                        title = 'Áo trong',
                        icon = 'tshirt',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Pants',
                        title = 'Quần',
                        icon = 'user',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'Shoes',
                        title = 'Giày',
                        icon = 'shoe-prints',
                        type = 'client',
                        event = 'qb-radialmenu:ToggleClothing',
                        shouldClose = true
                    }, {
                        id = 'meer',
                        title = 'Thêm',
                        icon = 'plus',
                        items = {
                            {
                                id = 'Hat',
                                title = 'Mũ',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Glasses',
                                title = 'Kính',
                                icon = 'glasses',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Visor',
                                title = 'Khăn che mặt',
                                icon = 'hat-cowboy-side',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Mask',
                                title = 'Mặt nạ',
                                icon = 'theater-masks',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Vest',
                                title = 'Áo giáp',
                                icon = 'vest',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Bag',
                                title = 'Túi',
                                icon = 'shopping-bag',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }, {
                                id = 'Bracelet',
                                title = 'Vòng đeo tay',
                                icon = 'user',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Watch',
                                title = 'Đồng hồ',
                                icon = 'stopwatch',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleProps',
                                shouldClose = true
                            }, {
                                id = 'Gloves',
                                title = 'Găng tay',
                                icon = 'mitten',
                                type = 'client',
                                event = 'qb-radialmenu:ToggleClothing',
                                shouldClose = true
                            }
                        }
                    }
                }
            }
        }
    },
    [3] = {
        id = 'vesinh',
        title = 'Vệ sinh',
        icon = 'toilet',
        items = {
            {
                id = 'didai',
                title = 'Đi tè',
                icon = 'restroom',
                type = 'client',
                event = 'xt-vesinh:client:didai',
                shouldClose = true
            },
            {
                id = 'diia',
                title = 'Đi ị',
                icon = 'poo',
                type = 'client',
                event = 'xt-vesinh:client:diia',
                shouldClose = true
            }
        }
    },
}
Config.VehicleDoors = {
    id = 'vehicledoors',
    title = 'Cửa xe',
    icon = 'car-side',
    items = {
        {
            id = 'door0',
            title = 'Cửa trước bên trái',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            shouldClose = false
        }, {
            id = 'door4',
            title = 'Nắp',
            icon = 'car',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            shouldClose = false
        }, {
            id = 'door1',
            title = 'Cửa trước bên phải',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            shouldClose = false
        }, {
            id = 'door3',
            title = 'Cửa sau bên phải',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            shouldClose = false
        }, {
            id = 'door5',
            title = 'Cốp',
            icon = 'car',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            shouldClose = false
        }, {
            id = 'door2',
            title = 'Cửa sau bên trái',
            icon = 'car-side',
            type = 'client',
            event = 'qb-radialmenu:client:openDoor',
            shouldClose = false
        }
    }
}

Config.VehicleSeats = {
    id = 'vehicleseats',
    title = 'Ghế xe',
    icon = 'chair',
    items = {}
}
Config.VehicleKeys = {
    id = 'vehiclekeys',
    title = 'Đưa chìa khoá',
    icon = 'key',
    type = 'client',
    event = 'xt-vehiclekeys:client:give:key',
    shouldClose = false,
}
Config.VehicleEnginer = {
    id = 'vehicleenginer',
    title = 'Bật động cơ',
    icon = 'car-battery',
    type = 'client',
    event = 'qb-radialmenu:client:engine',
    shouldClose = false,
}
Config.JobInteractions = {
    ["ambulance"] = {
        {
            id = 'statuscheck',
            title = 'Kiểm tra sức khoẻ',
            icon = 'heartbeat',
            type = 'client',
            event = 'xt-benhvien:client:CheckStatus',
            shouldClose = true
        },{
            id = 'revivep',
            title = 'Cứu sống',
            icon = 'user-md',
            type = 'client',
            event = 'xt-benhvien:client:RevivePlayer',
            shouldClose = true
        },{
            id = 'treatwounds',
            title = 'Chữa trị',
            icon = 'band-aid',
            type = 'client',
            event = 'xt-benhvien:client:TreatWounds',
            shouldClose = true
        }, {
            id = 'emergencybutton2',
            title = 'Nút khẩn cấp',
            icon = 'bell',
            type = 'client',
            event = 'police:client:SendPoliceEmergencyAlert',
            shouldClose = true
        }, {
            id = 'escort',
            title = 'Hộ tống',
            icon = 'user-friends',
            type = 'client',
            event = 'police:client:EscortPlayer',
            shouldClose = true
        }, {
            id = 'stretcheroptions',
            title = 'Băng ca',
            icon = 'procedures',
            items = {
                {
                    id = 'spawnstretcher',
                    title = 'Lấy Băng ca',
                    icon = 'plus',
                    type = 'client',
                    event = 'qb-radialmenu:client:TakeStretcher',
                    shouldClose = false
                }, {
                    id = 'despawnstretcher',
                    title = 'Xoá Băng ca',
                    icon = 'minus',
                    type = 'client',
                    event = 'qb-radialmenu:client:RemoveStretcher',
                    shouldClose = false
                }
            }
        }
    },
    ["taxi"] = {
        {
            id = 'togglemeter',
            title = 'Hiện/Ẩn Đồng hồ',
            icon = 'eye-slash',
            type = 'client',
            event = 'qb-taxi:client:toggleMeter',
            shouldClose = false
        }, {
            id = 'togglemouse',
            title = 'Bật tắt Đồng hồ',
            icon = 'hourglass-start',
            type = 'client',
            event = 'qb-taxi:client:enableMeter',
            shouldClose = true
        }, {
            id = 'npc_mission',
            title = 'Đón NPC',
            icon = 'taxi',
            type = 'client',
            event = 'qb-taxi:client:DoTaxiNpc',
            shouldClose = true
        }
    },
    ["mechanic"] = {
        {
            id = 'towvehicle',
            title = 'Kéo xe',
            icon = 'truck-pickup',
            type = 'client',
            event = 'qb-mechanic:client:hook:car',
            shouldClose = true
        }
    },
    ["police"] = {
        {
            id = 'emergencybutton',
            title = 'Nút khẩn cấp',
            icon = 'bell',
            type = 'client',
            event = 'police:client:SendPoliceEmergencyAlert',
            shouldClose = true
        }, {
            id = 'checkvehstatus',
            title = 'Kiểm tra trạng thái điều chỉnh',
            icon = 'info-circle',
            type = 'client',
            event = 'qb-tunerchip:client:TuneStatus',
            shouldClose = true
        }, {
            id = 'resethouse',
            title = 'Cài đặt khoá cửa',
            icon = 'key',
            type = 'client',
            event = 'qb-houses:client:ResetHouse',
            shouldClose = true
        }, {
            id = 'takedriverlicense',
            title = 'Tước bằng lái',
            icon = 'id-card',
            type = 'client',
            event = 'police:client:SeizeDriverLicense',
            shouldClose = true
        }, {
            id = 'policeinteraction',
            title = 'Hành động',
            icon = 'tasks',
            items = {
                {
                    id = 'statuscheck',
                    title = 'Kiểm tra sức khoẻ',
                    icon = 'heartbeat',
                    type = 'client',
                    event = 'xt-benhvien:client:CheckStatus',
                    shouldClose = true
                }, {
                    id = 'checkstatus',
                    title = 'Kiểm tra trạng thái',
                    icon = 'question',
                    type = 'client',
                    event = 'police:client:CheckStatus',
                    shouldClose = true
                }, {
                    id = 'escort',
                    title = 'Hộ tống',
                    icon = 'user-friends',
                    type = 'client',
                    event = 'police:client:EscortPlayer',
                    shouldClose = true
                }, {
                    id = 'searchplayer',
                    title = 'Kiểm tra',
                    icon = 'search',
                    type = 'client',
                    event = 'police:client:SearchPlayer',
                    shouldClose = true
                }, {
                    id = 'jailplayer',
                    title = 'Giam giữ',
                    icon = 'user-lock',
                    type = 'client',
                    event = 'police:client:JailPlayer',
                    shouldClose = true
                }
            }
        }, {
            id = 'policeobjects',
            title = 'Vật thể',
            icon = 'road',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Nón',
                    icon = 'exclamation-triangle',
                    type = 'client',
                    event = 'police:client:spawnCone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Cổng',
                    icon = 'torii-gate',
                    type = 'client',
                    event = 'police:client:spawnBarrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Biển báo giới hạn tốc độ',
                    icon = 'sign',
                    type = 'client',
                    event = 'police:client:spawnRoadSign',
                    shouldClose = false
                }, {
                    id = 'spawntent',
                    title = 'Lều',
                    icon = 'campground',
                    type = 'client',
                    event = 'police:client:spawnTent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Đèn',
                    icon = 'lightbulb',
                    type = 'client',
                    event = 'police:client:spawnLight',
                    shouldClose = false
                }, {
                    id = 'spikestrip',
                    title = 'Đinh',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'police:client:SpawnSpikeStrip',
                    shouldClose = false
                }, {
                    id = 'deleteobject',
                    title = 'Xoá',
                    icon = 'trash',
                    type = 'client',
                    event = 'police:client:deleteObject',
                    shouldClose = false
                }
            }
        }
    },
    ["hotdog"] = {
        {
            id = 'togglesell',
            title = 'Toggle sell',
            icon = 'hotdog',
            type = 'client',
            event = 'qb-hotdogjob:client:ToggleSell',
            shouldClose = true
        }
    }
}

Config.TrunkClasses = {
    [0] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [1] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sedans
    [2] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- SUVs
    [3] = {allowed = true, x = 0.0, y = -1.5, z = 0.0}, -- Coupes
    [4] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Muscle
    [5] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports Classics
    [6] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Sports
    [7] = {allowed = true, x = 0.0, y = -2.0, z = 0.0}, -- Super
    [8] = {allowed = false, x = 0.0, y = -1.0, z = 0.25}, -- Motorcycles
    [9] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Off-road
    [10] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Industrial
    [11] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Utility
    [12] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Vans
    [13] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Cycles
    [14] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Boats
    [15] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Helicopters
    [16] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Planes
    [17] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Service
    [18] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Emergency
    [19] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Military
    [20] = {allowed = true, x = 0.0, y = -1.0, z = 0.25}, -- Commercial
    [21] = {allowed = true, x = 0.0, y = -1.0, z = 0.25} -- Trains
}

Config.ExtrasEnabled = true

Config.Commands = {
    ["top"] = {
        Func = function() ToggleClothing("Top") end,
        Sprite = "top",
        Desc = "Cởi/ mặc áo trong",
        Button = 1,
        Name = "Torso"
    },
    ["gloves"] = {
        Func = function() ToggleClothing("gloves") end,
        Sprite = "gloves",
        Desc = "Cởi/ đeo găng tay",
        Button = 2,
        Name = "Gloves"
    },
    ["visor"] = {
        Func = function() ToggleProps("visor") end,
        Sprite = "visor",
        Desc = "Cởi/ đeo mũ",
        Button = 3,
        Name = "Visor"
    },
    ["bag"] = {
        Func = function() ToggleClothing("Bag") end,
        Sprite = "bag",
        Desc = "Opens or closes your bag",
        Button = 8,
        Name = "Bag"
    },
    ["shoes"] = {
        Func = function() ToggleClothing("Shoes") end,
        Sprite = "shoes",
        Desc = "Take your shoes off/on",
        Button = 5,
        Name = "Shoes"
    },
    ["vest"] = {
        Func = function() ToggleClothing("Vest") end,
        Sprite = "vest",
        Desc = "Take your vest off/on",
        Button = 14,
        Name = "Vest"
    },
    ["hair"] = {
        Func = function() ToggleClothing("hair") end,
        Sprite = "hair",
        Desc = "Put your hair up/down/in a bun/ponytail.",
        Button = 7,
        Name = "Hair"
    },
    ["hat"] = {
        Func = function() ToggleProps("Hat") end,
        Sprite = "hat",
        Desc = "Take your hat off/on",
        Button = 4,
        Name = "Hat"
    },
    ["glasses"] = {
        Func = function() ToggleProps("Glasses") end,
        Sprite = "glasses",
        Desc = "Take your glasses off/on",
        Button = 9,
        Name = "Glasses"
    },
    ["ear"] = {
        Func = function() ToggleProps("Ear") end,
        Sprite = "ear",
        Desc = "Take your ear accessory off/on",
        Button = 10,
        Name = "Ear"
    },
    ["neck"] = {
        Func = function() ToggleClothing("Neck") end,
        Sprite = "neck",
        Desc = "Take your neck accessory off/on",
        Button = 11,
        Name = "Neck"
    },
    ["watch"] = {
        Func = function() ToggleProps("Watch") end,
        Sprite = "watch",
        Desc = "Take your watch off/on",
        Button = 12,
        Name = "Watch",
        Rotation = 5.0
    },
    ["bracelet"] = {
        Func = function() ToggleProps("Bracelet") end,
        Sprite = "bracelet",
        Desc = "Take your bracelet off/on",
        Button = 13,
        Name = "Bracelet"
    },
    ["mask"] = {
        Func = function() ToggleClothing("Mask") end,
        Sprite = "mask",
        Desc = "Take your mask off/on",
        Button = 6,
        Name = "Mask"
    }
}

local bags = {[40] = true, [41] = true, [44] = true, [45] = true}

Config.ExtraCommands = {
    ["pants"] = {
        Func = function() ToggleClothing("Pants", true) end,
        Sprite = "pants",
        Desc = "Take your pants off/on",
        Name = "Pants",
        OffsetX = -0.04,
        OffsetY = 0.0
    },
    ["shirt"] = {
        Func = function() ToggleClothing("Shirt", true) end,
        Sprite = "shirt",
        Desc = "Take your shirt off/on",
        Name = "shirt",
        OffsetX = 0.04,
        OffsetY = 0.0
    },
    ["reset"] = {
        Func = function()
            if not ResetClothing(true) then
                Notify('Nothing To Reset', 'error')
            end
        end,
        Sprite = "reset",
        Desc = "Revert everything back to normal",
        Name = "reset",
        OffsetX = 0.12,
        OffsetY = 0.2,
        Rotate = true
    },
    ["bagoff"] = {
        Func = function() ToggleClothing("Bagoff", true) end,
        Sprite = "bagoff",
        SpriteFunc = function()
            local Bag = GetPedDrawableVariation(PlayerPedId(), 5)
            local BagOff = LastEquipped["Bagoff"]
            if LastEquipped["Bagoff"] then
                if bags[BagOff.Drawable] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            end
            if Bag ~= 0 then
                if bags[Bag] then
                    return "bagoff"
                else
                    return "paraoff"
                end
            else
                return false
            end
        end,
        Desc = "Take your bag off/on",
        Name = "bagoff",
        OffsetX = -0.12,
        OffsetY = 0.2
    }
}