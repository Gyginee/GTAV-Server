Config = {}

Config.Key = 38 -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

Config.AutoCamPosition = true -- If true it'll set the camera position automatically

Config.AutoCamRotation = true -- If true it'll set the camera rotation automatically

Config.HideMinimap = true -- If true it'll hide the minimap when interacting with an NPC

Config.UseOkokTextUI = true -- If true it'll use okokTextUI 

Config.CameraAnimationTime = 1000 -- Camera animation time: 1000 = 1 second

Config.TalkToNPC = {
	--[[ {
		npc = 'u_m_y_abner', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Employee of the', 								-- Text over the name
		name = 'Pacific Bank', 										-- Text under the header
		uiText = "Pacific Bank's Employee",							-- Name shown on the notification when near the NPC
		dialog = 'Hey, how can I help you?',						-- Text showm on the message bubble 
		coordinates = vector3(254.17, 222.8, 105.3), 				-- coordinates of NPC
		heading = 160.0,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Where is the toilet?', 'okokTalk:toilet', 'c'},		-- 'c' for client
			{'How can I rob the bank?', 'okokTalk:rob', 'c'},		-- 's' for server (if you write something else it'll be server by default)
			{"I want to access my safe.", 'okokTalk:safe', 'c'}, 
			{"I want to make a new credit card.", 'okokTalk:card', 'c'}, 
			{"I lost my credit card.", 'okokTalk:lost', 'c'}, 
			{"Is Jennifer working?", 'okokTalk:jennifer', 'c'}, 
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	}, ]]
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",							-- Name shown on the notification when near the NPC
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(24.49, -1346.44, 28.5), 				-- coordinates of NPC
		heading = 258.82,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC	
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(-47.4, -1758.65, 28.42), 				-- coordinates of NPC
		heading = 51.09,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(-706.13, -914.61, 18.22), 				-- coordinates of NPC
		heading = 88.13,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(-1221.34, -907.87, 11.33), 				-- coordinates of NPC
		heading = 45.22,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(1134.28, -983.23, 45.42), 				-- coordinates of NPC
		heading = 277.4,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'player_zero', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán Súng', 								-- Text over the name
		name = 'Súng Nè', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(16.51, -1107.38, 28.8), 				-- coordinates of NPC
		heading = 171.84,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Bán cho ít đồ nhé!', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(-160.62, 6320.86, 30.59), 				-- coordinates of NPC
		heading = 310.78,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(1728.21, 6415.85, 34.04), 				-- coordinates of NPC
		heading = 240.39,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC			
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(1697.23, 4923.45, 41.06), 				-- coordinates of NPC
		heading = 318.12,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(2677.15, 3279.87, 54.24), 				-- coordinates of NPC
		heading = 322.55,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(1959.48, 3740.93, 31.34), 				-- coordinates of NPC
		heading = 292.41,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
		npc = 'ig_natalia', 										-- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
		header = 'Bán hàng', 								-- Text over the name
		name = 'Cửa hàng 24/7', 										-- Text under the header
		uiText = "Nhân viên",	
		dialog = 'Tôi có thể giúp gì cho bạn?',						-- Text showm on the message bubble 
		coordinates = vector3(1164.71, 2710.83, 37.16), 				-- coordinates of NPC
		heading = 181.08,											-- Heading of NPC (needs decimals, 0.0 for example)
		camOffset = vector3(0.0, 0.0, 0.0), 						-- Camera position relative to NPC 	| (only works if Config.AutoCamPosition = false)
		camRotation = vector3(0.0, 0.0, 0.0),						-- Camera rotation 					| (only works if Config.AutoCamRotation = false)
		interactionRange = 2.5, 									-- From how far the player can interact with the NPC
		options = {													-- Options shown when interacting (Maximum 6 options per NPC)
			{'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},		-- 'c' for client
		},
		jobs = {													-- Jobs that can interact with the NPC		
		},
	},
	{
        npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(549.21, 2670.2, 41.16),                 -- coordinates of NPC
        heading = 84.03,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
         npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-1819.6, 793.58, 137.09),                 -- coordinates of NPC
        heading = 125.38,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
         npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-3243.36, 1000.1, 11.83),                 -- coordinates of NPC
        heading = 349.97,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-3040.08, 584.18, 6.91),                 -- coordinates of NPC
        heading = 8.86,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-2966.35, 392.04, 14.04),                 -- coordinates of NPC
        heading = 84.11,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-1487.06, -377.26, 39.16),                 -- coordinates of NPC
        heading = 131.54,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(372.84, 327.47, 102.57),                 -- coordinates of NPC
        heading = 249.32,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(2556.15, 380.86, 107.62),                 -- coordinates of NPC
        heading = 351.89,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'ig_natalia',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(1164.8, -323.55, 68.21),                 -- coordinates of NPC
        heading = 102.02,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'a_m_m_farmer_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(46.73, -1749.72, 28.63),                 -- coordinates of NPC
        heading = 48.36,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
    {
        npc = 'a_m_m_farmer_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(161.33, 6642.46, 30.7),                 -- coordinates of NPC
        heading = 222.8,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'a_m_y_soucent_02',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(170.11, -1799.63, 28.32),                 -- coordinates of NPC
        heading = 325.73,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'a_m_m_hillbilly_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(2747.25, 3472.97, 54.67),                 -- coordinates of NPC
        heading = 245.33,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
	},
		{
        npc = 'a_m_m_soucent_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bán hàng',                                 -- Text over the name
        name = 'Cửa hàng 24/7',                                         -- Text under the header
        uiText = "Nhân viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-1171.17, -1571.12, 3.66),                 -- coordinates of NPC
        heading = 131.76,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn mua đồ', 'xt-cuahang:server:open:shop', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'ig_molly',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(149.44, -1042.07, 28.37),                 -- coordinates of NPC
        heading = 341.87,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'ig_molly',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-1211.97, -332.03, 36.78),                 -- coordinates of NPC
        heading = 36.13,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'a_m_m_prolhost_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-2961.08, 482.79, 14.7),                 -- coordinates of NPC
        heading = 91.56,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'a_m_m_prolhost_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-111.24, 6470.1, 30.63),                 -- coordinates of NPC
        heading = 133.39,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'a_m_m_prolhost_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(313.76, -280.51, 53.16),                 -- coordinates of NPC
        heading = 339.93,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'ig_molly',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-351.45, -51.3, 48.04),                 -- coordinates of NPC
        heading = 337.38,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'ig_molly',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(252.17, 223.16, 105.29),                 -- coordinates of NPC
        heading = 159.2,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'a_m_m_prolhost_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(246.99, 225.08, 105.29),                 -- coordinates of NPC
        heading = 170.12,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
	{
        npc = 'ig_molly',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Nhân viên',                                 -- Text over the name
        name = 'Ngân hàng',                                         -- Text under the header
        uiText = "Nhân viên Ngân hàng",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(1175.03, 2708.3, 37.09),                 -- coordinates of NPC
        heading = 188.78,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn giao dịch', 'okokBanking:client:OpenBank', 'c'},        -- 'c' for client
        },
        jobs = {                                                    -- Jobs that can interact with the NPC

        },
    },
    {
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Bãi giữ xe',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(407.28, -1624.82, 28.29),                 -- coordinates of NPC
        heading = 239.56,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:depot', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC

        },
    },
    {
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 1',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(213.92, -808.45, 30.01),                 -- coordinates of NPC
        heading = 156.56,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC

        },
    },
    {
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 2',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(275.2, -345.53, 44.17),                 -- coordinates of NPC
        heading = 339.13,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC

        },
    },
    {
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 3',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-341.75, -772.49, 32.97),                 -- coordinates of NPC
        heading = 355.4,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC

        },
    },
    {
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 4',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-1190.52, -742.78, 19.24),                 -- coordinates of NPC
        heading = 307.96,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },
    {
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 5',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(67.89, 12.24, 68.21),                 -- coordinates of NPC
        heading = 329.01,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },
    {
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 6',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(959.64, 3618.99, 31.67),                 -- coordinates of NPC
        heading = 88.72,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },

{
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 7',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-450.23, -793.91, 29.66),                 -- coordinates of NPC
        heading = 85.3,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },

{
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 8',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(1738.08, 3709.06, 33.14),                 -- coordinates of NPC
        heading =22.32,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },

{
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 9 ',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(362.04, 297.84, 102.88),                 -- coordinates of NPC
        heading =333.94,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },

{
        npc = 'ig_trafficwarden',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Bảo vệ',                                 -- Text over the name
        name = 'Gara 10',                                         -- Text under the header
        uiText = "Bảo vệ",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-1184.91, -1510.02, 3.65),                 -- coordinates of NPC
        heading =312.81,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn lấy xe', 'xt-garages:client:gara', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },
    {
        npc = 'a_m_y_musclbeac_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Huấn luyện viên',                                 -- Text over the name
        name = 'Phòng tập thể hình',                                         -- Text under the header
        uiText = "Huấn luyện viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(-1197.37, -1579.39, 3.61),                 -- coordinates of NPC
        heading = 37.4,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn đăng kí thể hình', 'xt-gym:dangki', 'c'},
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },
    {
        npc = 'cs_karen_daniels',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Giáo viên',                                 -- Text over the name
        name = 'Trường dạy lại xe',                                         -- Text under the header
        uiText = "Giáo viên",
        dialog = 'Tôi có thể giúp gì cho bạn?',                        -- Text showm on the message bubble 
        coordinates = vector3(240.18, -1379.99, 32.74),                 -- coordinates of NPC
        heading = 152.57,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn thi bằng xe hơi', 'okokTalk:thioto', 'c'},
            {'Tôi muốn thi bằng xe máy', 'okokTalk:thixm', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    },
--[[     {
        npc = 's_m_m_movalien_01',                                         -- Website too see peds name: https://wiki.rage.mp/index.php?title=Peds
        header = 'Alien',                                 -- Text over the name
        name = 'Sự kiện Halloween',                                         -- Text under the header
        uiText = "Alien",
        dialog = 'Bạn có gì cho tôi không?',                        -- Text showm on the message bubble 
        coordinates = vector3(214.9, -917.5, 30.69),                 -- coordinates of NPC
        heading = 324.06,                                            -- Heading of NPC (needs decimals, 0.0 for example)
        camOffset = vector3(0.0, 0.0, 0.0),                         -- Camera position relative to NPC     | (only works if Config.AutoCamPosition = false)
        camRotation = vector3(0.0, 0.0, 0.0),                        -- Camera rotation                     | (only works if Config.AutoCamRotation = false)
        interactionRange = 2.5,                                     -- From how far the player can interact with the NPC
        options = {                                                    -- Options shown when interacting (Maximum 6 options per NPC)
            {'Tôi muốn đổi chút kẹo', 'okokTalk:doikeo', 'c'},        -- 'c' for client
        },
        jobs = {                                                  -- Jobs that can interact with the NPC
        },
    }, ]]
	--[[
	-- This is the template to create new NPCs
	{
		npc = "",
		header = "",
		name = "",
		uiText = "",
		dialog = "",
		coordinates = vector3(0.0, 0.0, 0.0),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 0,
		options = {
			{"", 'client:event', 'c'},
			{"", 'client:event', 'c'},
			{"", 'client:event', 'c'}, 
			{"", 'server:event', 's'}, 
			{"", 'server:event', 's'}, 
			{"", 'server:event', 's'}, 
		},
		jobs = {	-- Example jobs
			'police',
			'ambulance',
		},
	},
	]]--
}