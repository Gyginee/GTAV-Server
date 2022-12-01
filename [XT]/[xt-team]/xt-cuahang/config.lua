Config = Config or {}

Config.Products = {
    ['Shops'] = {
      [1] = {
        name = "sandwich",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "water_bottle",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 2,
    },
--[[     [3] = {
        name = "kurkakola",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 3,
    },
    [4] = {
        name = "twerks_candy",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 4,
    },
    [5] = {
        name = "snikkel_candy",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 5,
    },
    [6] = {
        name = "tosti",
        price = 50,
        amount = 50,
        info = {},
        type = "item",
        slot = 6,
    },
    [7] = {
        name = "beer",
        price = 90,
        amount = 50,
        info = {},
        type = "item",
        slot = 7,
    },
    [8] = {
        name = "whiskey",
        price = 150,
        amount = 50,
        info = {},
        type = "item",
        slot = 8,
    },
    [9] = {
        name = "vodka",
        price = 150,
        amount = 50,
        info = {},
        type = "item",
        slot = 9,
    },
    [10] = {
        name = "lighter",
        price = 10,
        amount = 50,
        info = {},
        type = "item",
        slot = 10,
    },
    [11] = {
        name = "glass_bottle",
        price = 20,
        amount = 500,
        info = {},
        type = "item",
        slot = 11,
 },
    [12] = {
        name = "rolling_paper",
        price = 20,
        amount = 5000,
        info = {},
        type = "item",
        slot = 12,				
    }, ]]
    },
    ['Weed'] = {
       [1] = {
        name = "weed_nutrition",
        price = 250,
        amount = 1000,
        info = {},
        type = "item",
        slot = 1,
      },
      [2] = {
        name = "rolling-paper",
        price = 75,
        amount = 750,
        info = {},
        type = "item",
        slot = 2,
      }, 
    },
    ['Hardware'] = {
      [1] = {
        name = "lockpick",
        price = 1000,
        amount = 100,
        info = {},
        type = "item",
        slot = 1,
      },
    },
    ['Hardware-2'] = {
      [1] = {
        name = "tool_drill_2",
        price = 750,
        amount = 1,
        info = {
          quality = 100.0,
        },
        type = "tool",
        slot = 1,
      },
      [2] = {
        name = "tool_axe",
        price = 750,
        amount = 1,
        info = {
          quality = 100.0,
        },
        type = "tool",
        slot = 2,
      },
      [3] = {
        name = "tool_scissor",
        price = 750,
        amount = 1,
        info = {
          quality = 100.0,
        },
        type = "tool",
        slot = 3,
       },
      [4] = {
        name = "tool_fishingrod",
        price = 750,
        amount = 1,
        info = {
          quality = 100.0,
        },
        type = "tool",
        slot = 4,
       },
       [5] = {
        name = "phone",
        price = 2500,
        amount = 50,
        info = {},
        type = "item",
        slot = 5,
       },
       [6] = {
        name = "binoculars",
        price = 550,
        amount = 50,
        info = {},
        type = "item",
        slot = 6,
       },
       [7] = {
         name = "parachute",
         price = 250,
         amount = 25,
         info = {},
         type = "item",
         slot = 7,
       },
       [8] = {
        name = "tool_scissor_2",
        price = 750,
        amount = 1,
        info = {
          quality = 100.0,
        },
        type = "tool",
        slot = 8,
       },
       [9] = {
        name = "tool_bucket",
        price = 750,
        amount = 1,
        info = {
          quality = 100.0,
        },
        type = "tool",
        slot = 9,
		       },
       [10] = {
        name = "diving_gear",
        price = 2500,
        amount = 500,
        info = {
          quality = 100.0,
        },
        type = "tool",
        slot = 10,
       },
    }, 
	['shopsung'] = {
        [1] = {
         name = "pistol_ammo",
         price = 1,
         amount = 999999,
         info = {},
         type = "item",
         slot = 1,
       },
       [2] = {
        name = "rifle_ammo",
        price = 1,
        amount = 1000,
        info = {},
        type = "item",
        slot = 2,
       },
       [3] = {
        name = "armor",
        price = 1,
        amount = 1000,
        info = {},
        type = "item",
        slot = 3,
       },
       [4] = {
        name = "heavyarmor",
        price = 1,
        amount = 1000,
        info = {},
        type = "item",
        slot = 4,
         },
		 [5] = {
        name = "weapon_assaultrifle",
        price = 1,
        amount = 1000,
        info = {},
        type = "item",
        slot = 5,
         },
		 [6] = {
        name = "weapon_pistol",
        price = 1,
        amount = 1000,
        info = {},
        type = "item",
        slot = 6,
		  },
		 [7] = {
        name = "bandage",
        price = 1,
        amount = 1000,
        info = {},
        type = "item",
        slot = 7,
         },
    },  
}

Config.Shops = {
  [1] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 25.92,
      ['Y'] = -1346.68,
      ['Z'] = 29.49,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [2] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -48.09,
      ['Y'] = -1757.16,
      ['Z'] = 29.42,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [3] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -707.78,
      ['Y'] = -913.96,
      ['Z'] = 19.21,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [4] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -1222.86,
      ['Y'] = -907.16,
      ['Z'] = 12.32,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [5] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 1135.79,
      ['Y'] = -981.91,
      ['Z'] = 46.41,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [6] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 161.6,
      ['Y'] = 6636.14,
      ['Z'] = 31.57,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [7] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 1729.43,
      ['Y'] = 6415.32,
      ['Z'] = 35.03,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [8] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 1698.82,
      ['Y'] = 4924.58,
      ['Z'] = 42.06,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [9] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 2678.00,
      ['Y'] = 3281.03,
      ['Z'] = 55.24,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [10] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 1961.00,
      ['Y'] = 3741.30,
      ['Z'] = 32.34,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [11] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 1166.12,
      ['Y'] = 2709.18,
      ['Z'] = 38.15,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [12] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 547.99,
      ['Y'] = 2670.43,
      ['Z'] = 42.15,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [13] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -1820.98,
      ['Y'] = 792.98,
      ['Z'] = 138.116,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [14] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -3243.04,
      ['Y'] = 1001.49,
      ['Z'] = 12.83,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [15] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -3040.01,
      ['Y'] = 585.66,
      ['Z'] = 7.9,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [16] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -2967.93,
      ['Y'] = 391.03,
      ['Z'] = 15.04,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [17] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -1487.37,
      ['Y'] = -379.13,
      ['Z'] = 40.16,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [18] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 374.08,
      ['Y'] = 326.64,
      ['Z'] = 103.56,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [19] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 2556.50,
      ['Y'] = 382.16,
      ['Z'] = 108.62,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [20] = {
    ['Name'] = 'Cửa hàng 24/7',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = 1163.50,
      ['Y'] = -323.27,
      ['Z'] = 69.20,
    },
    ['Product'] = Config.Products["Shops"]
  },
  [21] = {
    ['Name'] = 'Cửa hàng Dụng cụ',
    ['Type'] = 'Hardware',
    ['Coords'] = {
      ['X'] = 44.74,
      ['Y'] = -1748.21,
      ['Z'] = 29.52,
    },
    ['Product'] = Config.Products["Hardware-2"]
  },
  [22] = {
    ['Name'] = 'Cửa hàng Dụng cụ',
    ['Type'] = 'Hardware',
    ['Coords'] = {
      ['X'] = 170.14,
      ['Y'] = -1799.22,
      ['Z'] = 29.31,
    },
    ['Product'] = Config.Products["Hardware"]
  },
  [23] = {
    ['Name'] = 'Cửa hàng Dụng cụ',
    ['Type'] = 'Hardware2',
    ['Coords'] = {
      ['X'] = 2748.84,
      ['Y'] = 3472.50,
      ['Z'] = 55.67,
    },
    ['Product'] = Config.Products["Hardware-2"]
  },
  [24] = {
    ['Name'] = 'Cửa hàng',
    ['Type'] = 'Store',
    ['Coords'] = {
      ['X'] = -1171.89,
      ['Y'] = -1572.03,
      ['Z'] = 4.66,
    },
    ['Product'] = Config.Products["Weed"]
  },
 --[[  [25] = {
    ['Name'] = 'Shop Súng',
    ['Type'] = 'shopsung',
    ['Coords'] = {
      ['X'] = 16.51,
      ['Y'] = -1107.38,
      ['Z'] = 28.8,
    },
    ['Product'] = Config.Products["shopsung"]
  }, ]]
}