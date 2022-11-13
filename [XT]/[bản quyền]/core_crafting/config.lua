Config = {
	BlipSprite = 566,
	BlipColor = 0,
	CraftingStopWithDistance = true, -- Chế tạo sẽ dừng lại khi không gần bàn làm việc
	ExperiancePerCraft = 5, -- Số lượng kinh nghiệm được thêm vào mỗi Craft (100 experiance là 1 cấp độ)
	HideWhenCantCraft = true, -- Thay vì hạ thấp độ mờ, nó che giấu vật phẩm không thể chế tạo do mức độ thấp hoặc công việc sais
	Categories = {
		['food'] = {
			Label = 'Đồ ăn',
			Image = 'comluon',
			Jobs = {},
		},
		['drink'] = {
			Label = 'Đồ uống',
			Image = 'coffeechicken',
			Jobs = {},
		},
		['tools'] = {
			Label = 'Vật phẩm',
			Image = 'lockpick',  -- tên của file hình ảnh
			Jobs = {}
		},
		['dungcu'] = {
			Label = 'Dụng cụ',
			Image = 'axe', -- tên của file hình ảnh
			Jobs = {}
		},
		['vukhi'] = {
			Label = 'Vũ khí',
			Image = 'np_sniper-rifle', -- tên của file hình ảnh
			Jobs = {}
		},
		['suado'] = {
			Label = 'Sửa Đồ',
			Image = '10kgoldchain', -- tên của file hình ảnh
			Jobs = {}
		},
	},
	PermanentItems = { -- Các mục không bị loại bỏ khi chế tạo
		['wrench'] = true
	},
	Recipes = { -- Nhập tên mục và sau đó giá trị tốc độ! Giá trị càng cao mô-men xoắn
		-----------CÔNG DÂN----------------------
		['lockpick'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'tools', -- Mục danh mục sẽ được đưa vào
			type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 5, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 10, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				["copper"] = 50,
				["plastic"] = 10,
			}
		},
		['glass_bottle'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'dungcu', -- Mục danh mục sẽ được đưa vào
		type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 5, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 10, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			["glass"] = 2,
		}
		},
		['tool_axe'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			c = 'dungcu', -- Mục danh mục sẽ được đưa vào
			type = 'tool', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 15, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				["iron"] = 3,
				["packaged_plank"] = 1,
			}
		},
		['tool_drill_2'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'dungcu', -- Mục danh mục sẽ được đưa vào
		type = 'tool', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 10, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			["copper"] = 10,
			["packaged_plank"] = 1,
			}
		},
		['tool_fishingrod'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'dungcu', -- Mục danh mục sẽ được đưa vào
		type = 'tool', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 10, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			["packaged_plank"] = 1,
			["iron"] = 2,
			}
		},
		['tool_scissor_2'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'dungcu', -- Mục danh mục sẽ được đưa vào
		type = 'tool', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 10, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			["iron"] = 3,
			["plastic"] = 15,
			}
		},
		['tool_bucket'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'dungcu', -- Mục danh mục sẽ được đưa vào
		type = 'tool', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 10, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			["copper"] = 10,
			["gold"] = 2,
			}
		},
		['repairkit'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'tools', -- Mục danh mục sẽ được đưa vào
		type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {'mechanic'}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 0, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
		["metalscrap"] = 2
		}
		},
		['advancedrepairkit'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'tools', -- Mục danh mục sẽ được đưa vào
		type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {'mechanic'}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 0, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
		["metalscrap"] = 3
		}
		},
		['cleaningkit'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'tools', -- Mục danh mục sẽ được đưa vào
		type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {'mechanic'}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 0, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
		["metalscrap"] = 3,
		["plastic"] = 3,
			}
		},
		
		['son'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'tools', -- Mục danh mục sẽ được đưa vào
		type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {'doxe'}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 0, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
		["iron"] = 50,
		["plastic"] = 50,
			}
		},
		['giay-dan'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'tools', -- Mục danh mục sẽ được đưa vào
		type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {'doxe'}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 0, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
		["packaged_plank"] = 5,
		["copper"] = 50,
			}
		},
		['aluminumoxide'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 5, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
			type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				['diamond'] = 2,
				['diamond-ring'] = 2,
				['metalscrap'] = 5,
				['rolex'] = 1
				
			}
		},
		['ironoxide'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 10, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
			type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				['diamond'] = 5,
				['diamond-ring'] = 2,
				['iron'] = 20,
				['rolex'] = 1
				
			}
		},
		['weapon_switchblade'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 10, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
			type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				['aluminumoxide'] = 5,
				['ironoxide'] = 5,
				['diamond'] = 5,
				['rolex'] = 5,
				['metalscrap'] = 5
			}
		},
		['weapon_hammer'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 10, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
			type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			['aluminumoxide'] = 5,
			['ironoxide'] = 5,
			['diamond'] = 5,
			['rolex'] = 4,
			['metalscrap'] = 5
			}
		},
		['weapon_machete'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 12, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
			type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			['aluminumoxide'] = 5,
			['ironoxide'] = 5,
			['diamond'] = 5,
			['rolex'] = 4,
			['metalscrap'] = 10
			}
		},
		['weapon_wrench'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 12, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
			type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			['aluminumoxide'] = 5,
			['ironoxide'] = 5,
			['diamond'] = 5,
			['rolex'] = 4,
			['metalscrap'] = 10
			}
		},
		['weapon_hatchet'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 12, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
			type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			['aluminumoxide'] = 5,
			['ironoxide'] = 5,
			['diamond'] = 5,
			['rolex'] = 4,
			['metalscrap'] = 10
			}
		},
		['weapon_golfclub'] = {  -- ten vat pham can che tao ra + ten hinh anh
		Level = 17, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
		Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
		type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
		Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
		JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
		Amount = 1, -- Số lượng sẽ được chế tạo
		SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
		requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
		Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
		Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
		Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
		['aluminumoxide'] = 5,
		['ironoxide'] = 5,
		['diamond'] = 5,
		['rolex'] = 6,
		['metalscrap'] = 10
		}
	},
	['weapon_bat'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 17, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
	['aluminumoxide'] = 5,
	['ironoxide'] = 5,
	['diamond'] = 5,
	['rolex'] = 6,
	['metalscrap'] = 10
	}
},
['weapon_pistol'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 50, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
	['snspistol_part_1'] = 1,
	['snspistol_part_2'] = 1,
	['snspistol_part_3'] = 1,
	['snspistol_stage_1'] = 1
	}
},
		['screwdriverset'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'tools', -- Mục danh mục sẽ được đưa vào
			type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 10, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
			["metalscrap"] = 10,
			["iron"] = 5,
			["steel"] = 10,
			["aluminum"] = 10,
			}
		},
		['electronickit'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'tools', -- Mục danh mục sẽ được đưa vào
			type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 10, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				["metalscrap"] = 10,
				["plastic"] = 45,
				["aluminum"] = 10,
			}
		},
		['radio'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 2, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'tools', -- Mục danh mục sẽ được đưa vào
			type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 20, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 30, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				["metalscrap"] = 10,
				["plastic"] = 50,
			}
		},
		['rolling_paper'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'tools', -- Mục danh mục sẽ được đưa vào
			type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 10, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 10, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 30, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				["wood"] = 10,
			}
		},
		['lockpick'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'tools', -- Mục danh mục sẽ được đưa vào
			type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 5, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 5, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				["metalscrap"] = 10,
				["iron"] = 5,
				["plastic"] = 10,
			}
		},
		['plastic-bag'] = {  -- ten vat pham can che tao ra + ten hinh anh
			Level = 0, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
			Category = 'tools', -- Mục danh mục sẽ được đưa vào
			type = 'item', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
			Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
			JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
			Amount = 1, -- Số lượng sẽ được chế tạo
			SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
			requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
			Exp = 5, --Điểm kinh nghiệm sau mỗi lần chế tạo
			Time = 5, -- Thời gian tính bằng giây để chế tạo vật phẩm này
			Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
				["plastic"] = 2,
			}
		},
		--Đồ ăn

		['sashimi'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 4, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["fish"] = 1,
				["fish3"] = 1,
			}
		},
		['comluon'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 2, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["gao"] = 1,
				["fish2"] = 1,
			}
		},
		['comheo'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 3, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["gao"] = 1,
				["packagedpig"] = 1,
			}
		},
		['cahoi'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 4, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["fish"] = 1,
				["packed_orange"] = 1,
			}
		},
		['ramen'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 4, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["wheatpowder"] = 3,
				["packagedpig"] = 1,
			}
		},
		['trada'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 2, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["water_bottle"] = 1,
				["tea"] = 2,
			}
		},
		['wheatpowder'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 3, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["gao"] = 1,
			}
		},
		['tomchienxu'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 1, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["wheatpowder"] = 1,
				["fish3"] = 2,
			}
		},
		['mochi1'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 1, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["water_bottle"] = 1,
				["wheatpowder"] = 3,
			}
		},
		['banhxeo'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 3, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["fish3"] = 1,
				["wheatpowder"] = 2,
			}
		},
		['oreo'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 1, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 2, 
			Time = 3, 
			Ingredients = { 
				["milk"] = 1,
				["matcha"] = 1,
				["water_bottle"] = 1,
			}
		},
		['thumiso'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 4, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["fish1"] = 1,
				["milk"] = 1,
			}
		},
		['comtra'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 3, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["gao"] = 1,
				["fish2"] = 1,
				["tea"] = 50,
			}
		},
		['temakicua'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 2, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["gao"] = 1,
				["cua"] = 1,
			}
		},
		['misoba'] = {  
			Level = 0, 
			Category = 'food', 
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 2, 
			SuccessRate = 100, 
			requireBlueprint = false, 
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["gao"] = 1,
				["matcha"] = 1,
			}
		},
		['gaterizaki'] = {  
			Level = 0, 
			Category = 'food',
			type = 'item', 
			Jobs = {'nhat'},
			JobGrades = {},
			Amount = 4,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				["packedchicken"] = 1,
				["orange"] = 1,
			}
		},

		--Cafe
		['coffeecam'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 1,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['orange'] = 1;
				["coffeebean"] = 1;
				["milk"] = 1;
			}
		},
		['coffeechicken'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 1,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['alivechicken'] = 1;
				["coffeebean"] = 1;
				["milk"] = 1;
			}
		},
		['trasuamatcha'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 1,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['matcha'] = 1;
				["orange"] = 1;
				["milk"] = 1;
			}
		},
		['taophomatcha'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 1,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['matcha'] = 1;
				["gao"] = 1;
				["water_bottle"] = 1;
			}
		},
		['trada'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 1,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['tea'] = 1;
				["water_bottle"] = 1;
			}
		},
		['trasua'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 1,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['milk'] = 1;
				['drytea'] = 1;
				["matcha"] = 1;
			}
		},
		['camvat'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 3,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['packed_orange'] = 2;
			}
		},
		['nuocgao'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 1,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['gao'] = 2;
				['water_bottle'] = 1
			}
		},
		['banhmatcha'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 2,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['wheatpowder'] = 2;
				['matcha'] = 1
			}
		},
		['khoheo'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 3,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['packagedpig'] = 1;
				
			}
		},
		['khoga'] = {  
			Level = 0, 
			Category = 'drink',
			type = 'item', 
			Jobs = {'cafe'},
			JobGrades = {},
			Amount = 3,
			SuccessRate = 100,
			requireBlueprint = false,
			Exp = 1, 
			Time = 3, 
			Ingredients = { 
				['packedchicken'] = 1;
			}
		},
		
		-- súng 
	['snspistol_part_1'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
	['ironoxide'] = 10,
	['aluminumoxide'] = 10,
	['steel'] = 100,
	['metalscrap'] = 50,
	['aluminum'] = 50,
	['kimloaibian'] = 2	
	}
},

['snspistol_part_2'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
	['ironoxide'] = 10,
	['aluminumoxide'] = 10,
	['iron'] = 100,
	['metalscrap'] = 50,
	['aluminum'] = 50,
	['kimloaibian'] = 2	
	}
},
['snspistol_part_3'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
	['ironoxide'] = 10,
	['aluminumoxide'] = 10,
	['wood'] = 50,
	['metalscrap'] = 50,
	['aluminum'] = 50,
	['kimloaibian'] = 2	
	}
},
['snspistol_stage_1'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'vukhi', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
    ['ironoxide'] = 10,
	['aluminumoxide'] = 10,
	['rubber'] = 70,
	['metalscrap'] = 50,
	['aluminum'] = 50,
    ['kimloaibian'] = 2	
	}
	},
['muc'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'tools', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
    ['rubber'] = 2
	}
},
['kim'] = {  -- ten vat pham can che tao ra + ten hinh anh
	Level = 1, -- Vật phẩm này sẽ có thể chế tạo từ cấp độ nào
	Category = 'tools', -- Mục danh mục sẽ được đưa vào
	type = 'weapon', -- Chỉ định xem đây có phải là một khẩu súng hay không để nó sẽ được thêm vào tải trọng
	Jobs = {}, -- Những công việc nào có thể tạo ra mặt hàng này, để lại {} cho phép bất kỳ công việc nào
	JobGrades = {}, -- Loại công việc nào có thể chế tạo mặt hàng này, để lại {} cho phép bất kỳ hạng nào
	Amount = 1, -- Số lượng sẽ được chế tạo
	SuccessRate = 100, -- 90% rằng thủ công sẽ thành công! Nếu không, bạn sẽ mất các thành phần của mình
	requireBlueprint = false, -- Yêu cầu một sơ đồ chi tiết mà bạn cần tự thêm vào cơ sở dữ liệu TEMPLATE: itemname_blueprint VÍ DỤ: band_blueprint
	Exp = 100, --Điểm kinh nghiệm sau mỗi lần chế tạo
	Time = 15, -- Thời gian tính bằng giây để chế tạo vật phẩm này
	Ingredients = { -- Các thành phần cần thiết để tạo ra vật phẩm này
    ['steel'] = 2
	}
},
--suado

},	
	Workbenches = {																									-- ten cac vat pham de can tao																								-- nếu thêm 1 ví trí,. điểm cuối cùng k cần dấu phẩy ở đuôi! các cái trên cần
		{coords = vector3(101.12, 6616.56, 32.44), jobs = {},grades = {}, blip = true, recipes = {'tool_bucket', 'tool_axe', 'tool_scissor_2', 'tool_fishingrod', 'tool_drill_2', 'glass_bottle','plastic-bag','screwdriverset','lockpick'}, radius = 2.0, name = "Chế tạo dụng cụ" },
		{coords = vector3(-352.85, -130.17, 39.02), jobs = {'mechanic'},grades = {'1'}, blip = false, recipes = {'repairkit','advancedrepairkit','cleaningkit'}, radius = 2.0, name = "Chế tạo dụng cụ" },
		--{coords = vector3(1692.57, 3585.1, 35.62), jobs = {},grades = {}, blip = false, recipes = {'lockpick', 'screwdriverset', 'electronickit', 'radio', 'rolling_paper'}, radius = 2.0, name = "Chế tạo dụng cụ" },
		{coords = vector3(-584.13, -938.89, 23.89), jobs = {'doxe'},grades = {}, blip = false, recipes = {'giay-dan', 'son'}, radius = 2.0, name = "Chế tạo dụng cụ" },
		{coords = vector3(-178.26, 301.7, 97.46), jobs = {'nhat'},grades = {'1', '2', '3'}, blip = false, recipes = {'sashimi','comluon','comheo','ramen','trada','wheatpowder','tomchienxu','mochi1','banhxeo','oreo','thumiso','comtra','temakicua','gaterizaki','cahoi','misoba',}, radius = 2.0, name = "Nấu đồ ăn" },
		{coords = vector3(826.74, -110.39, 79.77), jobs = {'cafe'},grades = {}, blip = false, recipes = {'khoga','khoheo','banhmatcha', "nuocgao", "camvat", "trasua", "trasuamatcha", "taophomatcha","trada", "coffeechicken","coffeecam",}, radius = 2.0, name = "Pha đồ uống" },
	    {coords = vector3(107.14, 6629.13, 31.79), jobs = {},grades = {}, blip = false, recipes = {'ironoxide','aluminumoxide','weapon_switchblade','weapon_machete','weapon_hammer','weapon_hatchet','weapon_golfclub'}, radius = 2.0, name = "Vũ khí" },
		{coords = vector3(1363.76, 6549.07, 14.62), jobs = {},grades = {}, blip = false, recipes = {'snspistol_part_1'}, radius = 2.0, name = "Vũ khí" },
		{coords = vector3(-2797.99, 1431.59, 100.93), jobs = {},grades = {}, blip = false, recipes = {'snspistol_part_2'}, radius = 2.0, name = "Vũ khí" },
		{coords = vector3(471.04, 2607.54, 44.48), jobs = {},grades = {}, blip = false, recipes = {'snspistol_part_3'}, radius = 2.0, name = "Vũ khí" },
		{coords = vector3(-1108.59, -1643.35, 4.64), jobs = {},grades = {}, blip = false, recipes = {'snspistol_stage_1'}, radius = 2.0, name = "Vũ khí" },
		{coords = vector3(583.31, -3110.95, 6.07), jobs = {},grades = {}, blip = false, recipes = {'weapon_pistol'}, radius = 2.0, name = "Vũ khí" },
        {coords = vector3(321.11, 186.04, 103.59), jobs = {'xam'},grades = {}, blip = false, recipes = {'muc','kim'}, radius = 2.0, name = "Chế tạo dụng cụ" },
        {coords = vector3(660.72, 1281.98, 360.29), jobs = {},grades = {}, blip = false, recipes = {'weapon_switchblade','weapon_machete','weapon_hammer','weapon_hatchet','weapon_bat','weapon_golfclub'}, radius = 2.0, name = "sửa vũ khí" },		
	},
}