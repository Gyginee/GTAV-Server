QBCore = nil 

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

--[[function BoatMenuLaPuerta()
    exports['qb-menu']:openMenu({
        {
            header = "Điểm Thuê La Puerta",
            isMenuHeader = true
        },
        {
            header = "Thuyền: "..Config.RentalBoat,
            txt = "Giá: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 1
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuPaletoCove()
    exports['qb-menu']:openMenu({
        {
            header = "Điểm Thuê Paleto Cove",
            isMenuHeader = true
        },
        {
            header = "Thuyền: "..Config.RentalBoat,
            txt = "Giá: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 2
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuElGordo()
    exports['qb-menu']:openMenu({
        {
            header = "Điểm Thuê El Gordo",
            isMenuHeader = true
        },
        {
            header = "Thuyền: "..Config.RentalBoat,
            txt = "Giá: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 3
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 


function BoatMenuActDam()
    exports['qb-menu']:openMenu({
        {
            header = "Điểm Thuê Act Dam",
            isMenuHeader = true
        },
        {
            header = "Thuyền: "..Config.RentalBoat,
            txt = "Giá: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 4
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function BoatMenuAlamoSea()
    exports['qb-menu']:openMenu({
        {
            header = "Điểm Thuê Alamo Sea",
            isMenuHeader = true
        },
        {
            header = "Thuyền: "..Config.RentalBoat,
            txt = "Giá: $"..Config.BoatPrice,
            params = {
                event = "doj:client:rentaBoat",
				args = 5
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 
--============================================================== ReturnMenus

function ReturnBoatLaPuerta()
    exports['qb-menu']:openMenu({
		{
            header = "Thuê thuyền đánh cá",
            isMenuHeader = true
        },
		{
            header = "Trả thuyền",
            txt = "Trả và nhận lại $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 1
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatPaletoCove()
    exports['qb-menu']:openMenu({
		{
            header = "Thuê thuyền đánh cá",
            isMenuHeader = true
        },
		{
            header = "Trả thuyền",
            txt = "Trả và nhận lại $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 2
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatElGordo()
    exports['qb-menu']:openMenu({
		{
            header = "Thuê thuyền đánh cá",
            isMenuHeader = true
        },
		{
            header = "Trả thuyền",
            txt = "Trả và nhận lại $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 3
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatActDam()
    exports['qb-menu']:openMenu({
		{
            header = "Thuê thuyền đánh cá",
            isMenuHeader = true
        },
		{
            header = "Trả thuyền",
            txt = "Trả và nhận lại $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 4
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end 

function ReturnBoatAlamoSea()
    exports['qb-menu']:openMenu({
		{
            header = "Thuê thuyền đánh cá",
            isMenuHeader = true
        },
		{
            header = "Trả thuyền",
            txt = "Trả và nhận lại $"..math.floor(Config.BoatPrice/2),
            params = {
                event = "doj:client:ReturnBoat",
				args = 5
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end]]

--============================================================== Sell/Gear Menus
RegisterNetEvent('banca')
AddEventHandler('banca',function()
    exports['qb-menu']:openMenu({
		{
            header = "Nhà hàng hải sản Pearl",
            isMenuHeader = true
        },
        {
            header = "Bán cá thu",
            txt = "Giá: $"..Config.mackerelPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 1
            }
        },
        {
            header = "Bán cá tuyết",
            txt = "Giá: $"..Config.codfishPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 2
            }
        },
		{
            header = "Bán cá vược",
            txt = "Giá: $"..Config.bassPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 3 
            }
        },
        {
            header = "Bán cá bơn",
            txt = "Giá: $"..Config.flounderPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 4
            }
        },
		{
            header = "Bán cá đuối",
            txt = "Giá: $"..Config.stingrayPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 5
            }
        },		
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)
RegisterNetEvent('doj:client:SellLegalFish')
AddEventHandler('doj:client:SellLegalFish', function()
    exports['qb-menu']:openMenu({
		{
            header = "Nhà hàng hải sản Pearl",
            isMenuHeader = true
        },
        {
            header = "Bán cá thu",
            txt = "Giá: $"..Config.mackerelPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 1
            }
        },
        {
            header = "Bán cá tuyết",
            txt = "Giá: $"..Config.codfishPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 2
            }
        },
		{
            header = "Bán cá vược",
            txt = "Giá: $"..Config.bassPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 3 
            }
        },
        {
            header = "Bán cá bơn",
            txt = "Giá: $"..Config.flounderPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 4
            }
        },
		{
            header = "Bán cá đuối",
            txt = "Giá: $"..Config.stingrayPrice.." /con",
            params = {
				isServer = true,
                event = "fishing:server:SellLegalFish",
				args = 5
            }
        },		
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('muadungcu')
AddEventHandler('muadungcu',function()
    exports['qb-menu']:openMenu({
		{
            header = "Dụng cụ câu cá",
            isMenuHeader = true
        },
        {
            header = "Mua mồi câu",
            txt = "$"..Config.fishingBaitPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 1
            }
        },
		{
            header = "Mua cần câu",
            txt = "$"..Config.fishingRodPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 2
            }
        },
        {
            header = "Mua neo thuyền",
            txt = "$"..Config.BoatAnchorPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 3
            }
        },
        -- {
        --     header = "Mua hộp cá",
        --     txt = "$"..Config.FishingBoxPrice,
        --     params = {
		-- 		isServer = true,
        --         event = "fishing:server:BuyFishingGear",
		-- 		args = 4
        --     }
        -- },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)
RegisterNetEvent('doj:client:buyFishingGear')
AddEventHandler('doj:client:buyFishingGear', function() 
    exports['qb-menu']:openMenu({
		{
            header = "Dụng cụ câu cá",
            isMenuHeader = true
        },
        {
            header = "Mua mồi câu",
            txt = "$"..Config.fishingBaitPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 1
            }
        },
		{
            header = "Mua cần câu",
            txt = "$"..Config.fishingRodPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 2
            }
        },
        {
            header = "Mua neo thuyền",
            txt = "$"..Config.BoatAnchorPrice,
            params = {
				isServer = true,
                event = "fishing:server:BuyFishingGear",
				args = 3
            }
        },
        -- {
        --     header = "Mua hộp cá",
        --     txt = "$"..Config.FishingBoxPrice,
        --     params = {
		-- 		isServer = true,
        --         event = "fishing:server:BuyFishingGear",
		-- 		args = 4
        --     }
        -- },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)
RegisterNetEvent('bancala')
AddEventHandler('bancala',function()
    exports['qb-menu']:openMenu({
        {
            header = "Nhà hàng hải sản Pearl",
            isMenuHeader = true
        },
        {
            header = "Bán cá heo",
            txt = "Giá: $"..Config.dolphinPrice.." /con",
            params = {
                isServer = true,
                event = "fishing:server:SellillegalFish",
                args = 1
            }
        },
        {
            header = "Bán cá mập báo",
            txt = "Giá: $"..Config.sharktigerPrice.." /con",
            params = {
                isServer = true,
                event = "fishing:server:SellillegalFish",
                args = 2
            }
        },
        {
            header = "Bán cá mập búa",
            txt = "Giá: $"..Config.sharkhammerPrice.." /con",
            params = {
                isServer = true,
                event = "fishing:server:SellillegalFish",
                args = 3
            }
        },
        {
            header = "Bán cá voi sát thủ",
            txt = "Giá: $"..Config.killerwhalePrice.." /con",
            params = {
                isServer = true,
                event = "fishing:server:SellillegalFish",
                args = 4
            }
        },
        {
            header = "Đóng",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
    -- QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
	-- 	if HasItem then
	-- 		local charinfo = QBCore.Functions.GetPlayerData().charinfo
	-- 		QBCore.Functions.Notify('Chào mừng, '..charinfo.firstname..' '..charinfo.lastname)
	-- 		exports['qb-menu']:openMenu({
	-- 			{
	-- 				header = "Nhà hàng hải sản Pearl",
	-- 				isMenuHeader = true
	-- 			},
	-- 			{
	-- 				header = "Bán cá heo",
	-- 				txt = "Giá: $"..Config.dolphinPrice.." /con",
	-- 				params = {
	-- 					isServer = true,
	-- 					event = "fishing:server:SellillegalFish",
	-- 					args = 1
	-- 				}
	-- 			},
	-- 			{
	-- 				header = "Bán cá mập báo",
	-- 				txt = "Giá: $"..Config.sharktigerPrice.." /con",
	-- 				params = {
	-- 					isServer = true,
	-- 					event = "fishing:server:SellillegalFish",
	-- 					args = 2
	-- 				}
	-- 			},
	-- 			{
	-- 				header = "Bán cá mập búa",
	-- 				txt = "Giá: $"..Config.sharkhammerPrice.." /con",
	-- 				params = {
	-- 					isServer = true,
	-- 					event = "fishing:server:SellillegalFish",
	-- 					args = 3
	-- 				}
	-- 			},
	-- 			{
	-- 				header = "Bán cá voi sát thủ",
	-- 				txt = "Giá: $"..Config.killerwhalePrice.." /con",
	-- 				params = {
	-- 					isServer = true,
	-- 					event = "fishing:server:SellillegalFish",
	-- 					args = 4
	-- 				}
	-- 			},
	-- 			{
	-- 				header = "Đóng",
	-- 				txt = "",
	-- 				params = {
	-- 					event = "qb-menu:closeMenu"
	-- 				}
	-- 			},
	-- 		})
	-- 	else
    --         exports['okokNotify']:Alert("THẤT BẠI", "Bạn không thể bán cho chúng tôi vào lúc này, xin lỗi vì sự bất tiện này", 3000, 'error')
	-- 		-- QBCore.Functions.Notify('Bạn không thể bán cho chúng tôi vào lúc này, xin lỗi vì sự bất tiện này', 'error', 3500)
	-- 	end
	-- end, "pearlscard")
end)

RegisterNetEvent('doj:client:SellillegalFish')
AddEventHandler('doj:client:SellillegalFish', function() 
			local charinfo = QBCore.Functions.GetPlayerData().charinfo
			QBCore.Functions.Notify('Chào mừng, '..charinfo.firstname..' '..charinfo.lastname)
			exports['qb-menu']:openMenu({
				{
					header = "Nhà hàng hải sản Pearl",
					isMenuHeader = true
				},
				{
					header = "Bán cá heo",
					txt = "Giá: $"..Config.dolphinPrice.." /con",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 1
					}
				},
				{
					header = "Bán cá mập báo",
					txt = "Giá: $"..Config.sharktigerPrice.." /con",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 2
					}
				},
				{
					header = "Bán cá nhám búa",
					txt = "Giá: $"..Config.sharkhammerPrice.." /con",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 3
					}
				},
				{
					header = "Bán cá voi sát thủ",
					txt = "Giá: $"..Config.killerwhalePrice.." /con",
					params = {
						isServer = true,
						event = "fishing:server:SellillegalFish",
						args = 4
					}
				},
				{
					header = "Đóng",
					txt = "",
					params = {
						event = "qb-menu:closeMenu"
					}
				},
			})
end)
