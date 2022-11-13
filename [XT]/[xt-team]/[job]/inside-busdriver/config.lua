Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}
Config.BailPrice = 1000
Config.MinPayout = 175 -- Minimum Payout
Config.MaxPayout = 250 -- Minimum Payout
Config.Vehicle = 'bus'

Config.BusDriver = {
	['Jobstart'] = { --the place where you start and finish your work
		Pos = {x = 452.11, y = -622.05, z = 27.56, h = 270.31},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 25,
	},
	['Coaches'] = { --place of accepting the order, which randomizes the number of packages
		{x=460.5,y=-618.38,z=28.48,blip},
		{x=460.1,y=-625.43,z=28.49,blip},
		{x=459.39,y=-632.38,z=28.48,blip},
		{x=459.71,y=-641.8,z=28.48,blip},
	},
	['Inspection'] = { --the place where the company car appears
		Pos = {x = 466.03, y = -582.8, z = 28.48},
		PosCar = {x = 455.5, y = -563.45, z = 27.55,h=356.23},
		PosPed = {x = 456.34, y = -550.24, z = 28.5,h=160.01},
		FirstWheel = {x = 453.94, y = -558.86, z = 28.5,h=256.45},
		SecondWheel = {x = 453.45, y = -566.93, z = 28.5,h=256.46},
	},
	['RouteSelection'] = { --gates to which we have to go to load packages
		Pos = {x = 471.39, y = -611.19, z = 28.5, h = 175.19},
	},
    ['Peds'] = { --list of pedal models that may appear
		[1] = {ped = 'a_m_m_bevhills_01'},
	},
}

Config.Deposit = {
    ['Deposit'] = { 
		Pos = {x = 471.17, y = -583.13, z = 28.5},
		Size  = {x = 2.0, y = 2.0, z = 2.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 25,
	},
}

Config.Locations = {
    {name='first'},
    {name='second'},
}
Config.First = {
    [1] = {x=-37.29,y=-109.29,z=57.4,h=69.12,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-40.85,y=-103.36,z=57.68,h=174.35,ped},
        [2]={x=-39.51,y=-103.72,z=57.6,h=166.46,ped},
        [3]={x=-38.17,y=-104.45,z=57.55,h=155.7,ped},
    }},
    dx=-41.49,dy=-104.9,dz=57.67,dh=155.02
},
   [2] = {x=-685.66,y=-4.92,z=38.33,h=106.91,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-691.59,y=-2.5,z=38.32,h=182.1,ped},
        [2]={x=-690.42,y=-2.27,z=38.34,h=192.35,ped},
        [3]={x=-693.42,y=-3.15,z=38.29,h=201.91,ped},
    }},
    dx=-691.76,dy=-4.32,dz=38.3,dh=187.59
},
    [3] = {x=-1373.78,y=-46.46,z=52.23,h=98.94,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1378.25,y=-43.52,z=52.52,h=187.21,ped},
        [2]={x=-1376.0,y=-43.41,z=52.38,h=188.37,ped},
        [3]={x=-1377.68,y=-42.31,z=52.49,h=175.46,ped},
    }},
    dx=-1379.31,dy=-44.68,dz=52.56,dh=194.67
},
    [4] = {x=-786.52,y=203.79,z=75.95,h=274.69,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-780.81,y=200.67,z=75.93,h=354.43,ped},
        [2]={x=-782.32,y=200.75,z=75.98,h=358.75,ped},
        [3]={x=-783.55,y=200.72,z=76.01,h=24.95,ped},
    }},
    dx=-780.9,dy=201.75,dz=75.88,dh=0.17
},
    [5] = {x=-322.44,y=457.93,z=108.61,h=234.1,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-320.44,y=451.63,z=109.09,h=331.12,ped},
        [2]={x=-321.56,y=452.33,z=109.21,h=326.72,ped},
        [3]={x=-322.08,y=452.9,z=109.24,h=334.55,ped},
    }},
    dx=-319.28,dy=452.86,dz=108.44,dh=318.93
},
    [6] = {x=271.62,y=156.31,z=104.35,h=250.02,done=false,Peds = {
    ['Peds'] = {
        [1]={x=273.99,y=151.13,z=104.42,h=342.77,ped},
        [2]={x=272.61,y=151.64,z=104.45,h=333.25,ped},
        [3]={x=277.74,y=150.18,z=104.35,h=12.82,ped},
    }},
    dx=275.99,dy=151.73,dz=104.3,dh=348.38
},
    [7] = {x=967.35,y=143.11,z=80.86,h=321.32,done=false,Peds = {
    ['Peds'] = {
        [1]={x=974.02,y=145.41,z=80.99,h=49.05,ped},
        [2]={x=973.11,y=144.29,z=80.99,h=55.96,ped},
        [3]={x=972.33,y=143.27,z=80.99,h=50.55,ped},
    }},
    dx=972.65,dy=146.22,dz=80.99,dh=51.09
},
    [8] = {x=1495.65,y=799.53,z=76.89,h=327.14,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1499.83,y=800.73,z=76.97,h=353.09,ped},
        [2]={x=1498.78,y=800.11,z=76.89,h=352.88,ped},
        [3]={x=1502.66,y=804.85,z=77.02,h=105.33,ped},
    }},
    dx=1501.24,dy=802.81,dz=76.99,dh=64.83
},
    [9] = {x=2423.71,y=2891.77,z=40.22,h=308.28,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2429.13,y=2892.18,z=40.27,h=43.53,ped},
        [2]={x=2428.11,y=2891.32,z=40.27,h=39.11,ped},
        [3]={x=2427.3,y=2890.63,z=40.27,h=40.2,ped},
    }},
    dx=2429.44,dy=2893.78,dz=40.24,dh=41.87
},
    [10] = {x=2944.89,y=3971.8,z=51.66,h=8.53,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2947.19,y=3976.74,z=51.6,h=113.25,ped},
        [2]={x=2947.76,y=3976.11,z=51.63,h=103.48,ped},
        [3]={x=2947.69,y=3979.56,z=51.61,h=116.21,ped},
    }},
    dx=2946.16,dy=3977.8,dz=51.59,dh=101.38
},
    [11] = {x=2665.53,y=5046.72,z=44.78,h=12.11,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2668.68,y=5052.55,z=44.82,h=115.24,ped},
        [2]={x=2669.06,y=5051.38,z=44.81,h=104.33,ped},
        [3]={x=2667.75,y=5049.4,z=44.77,h=71.75,ped},
    }},
    dx=2666.44,dy=5052.76,dz=44.76,dh=92.19
},
    [12] = {x=2373.02,y=5848.53,z=46.74,h=33.36,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2374.32,y=5855.19,z=47.16,h=127.15,ped},
        [2]={x=2375.26,y=5854.02,z=47.18,h=119.56,ped},
        [3]={x=2374.77,y=5852.43,z=46.71,h=93.82,ped},
    }},
    dx=2371.87,dy=5854.58,dz=46.79,dh=124.64
},
    [13] = {x=1682.77,y=6394.77,z=30.94,h=76.26,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1677.47,y=6399.7,z=30.53,h=172.8,ped},
        [2]={x=1678.74,y=6399.57,z=30.68,h=166.03,ped},
        [3]={x=1680.01,y=6399.27,z=30.77,h=161.81,ped},
    }},
    dx=1677.73,dy=6397.93,dz=30.56,dh=162.13
},
    [14] = {x=184.79,y=6563.79,z=31.96,h=114.12,done=false,Peds = {
    ['Peds'] = {
        [1]={x=178.68,y=6564.62,z=31.98,h=210.64,ped},
        [2]={x=179.35,y=6565.37,z=32.02,h=207.73,ped},
        [3]={x=180.64,y=6565.96,z=32.02,h=184.52,ped},
    }},
    dx=178.71,dy=6563.26,dz=31.89,dh=210.59
},
    [15] = {x=-360.79,y=6031.94,z=31.26,h=133.91,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-368.36,y=6030.07,z=31.28,h=238.68,ped},
        [2]={x=-366.49,y=6031.55,z=31.25,h=230.86,ped},
        [3]={x=-365.27,y=6032.34,z=31.23,h=221.85,ped},
    }},
    dx=-366.48,dy=6029.53,dz=31.3,dh=221.6
},
    [16] = {x=-752.92,y=5517.97,z=35.65,h=121.82,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-759.8,y=5517.92,z=35.25,h=203.76,ped},
        [2]={x=-758.49,y=5518.46,z=35.37,h=199.52,ped},
        [3]={x=-757.16,y=5518.74,z=35.48,h=177.39,ped},
    }},
    dx=-758.92,dy=5516.83,dz=35.45,dh=204.62
},
    [17] = {x=-1514.66,y=5009.28,z=62.67,h=137.89,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1521.15,y=5007.65,z=62.3,h=214.24,ped},
        [2]={x=-1520.04,y=5008.78,z=62.31,h=214.29,ped},
        [3]={x=-1518.82,y=5009.38,z=62.39,h=205.47,ped},
    }},
    dx=-1520.15,dy=5006.55,dz=62.47,dh=222.34
},
[18] = {x=-2244.6,y=4299.2,z=47.42,h=148.75,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2250.52,y=4296.29,z=47.13,h=232.6,ped},
        [2]={x=-2249.63,y=4297.29,z=47.17,h=228.51,ped},
        [3]={x=-2248.73,y=4298.26,z=47.24,h=233.09,ped},
    }},
    dx=-2249.54,dy=4295.51,dz=47.17,dh=235.61
},
    [19] = {x=-2719.75,y=2322.07,z=17.62,h=162.43,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2725.31,y=2318.06,z=17.71,h=258.66,ped},
        [2]={x=-2724.89,y=2319,29,z=17.64,h=245.2,ped},
        [3]={x=-2724.29,y=2322.19,z=17.49,h=226.98,ped},
    }},
    dx=-2723.79,dy=2317.36,dz=17.79,dh=247.46
},
    [20] = {x=-3125.33,y=1095.92,z=20.47,h=172.25,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-3129.44,y=1090.8,z=20.63,h=248.54,ped},
        [2]={x=-3129.17,y=1092.25,z=20.63,h=257.62,ped},
        [3]={x=-3128.9,y=1093.73,z=20.62,h=219.13,ped},
    }},
    dx=-3128.05,dy=1090.52,dz=20.47,dh=260.09
},
    [21] = {x=-2857.78,y=47.65,z=14.36,h=251.84,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2853.06,y=42.76,z=14.4,h=3.23,ped},
        [2]={x=-2854.45,y=42.49,z=14.38,h=351.22,ped},
        [3]={x=-2855.89,y=43.84,z=14.38,h=350.01,ped},
    }},
    dx=-2853.0,dy=43.87,dz=14.42,dh=338.79
},
    [22] = {x=-2127.18,y=-373.48,z=12.97,h=249.36,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2123.13,y=-378.91,z=12.97,h=330.65,ped},
        [2]={x=-2124.52,y=-378.49,z=12.99,h=340.07,ped},
        [3]={x=-2125.53,y=-377.8,z=13.01,h=314.76,ped},
    }},
    dx=-2122.61,dy=-377.46,dz=12.81,dh=328.99
},
    [23] = {x=-1438.34,y=-906.15,z=10.86,h=246.23,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1434.59,y=-911.8,z=11.06,h=335.14,ped},
        [2]={x=-1435.72,y=-911.85,z=11.06,h=330.4,ped},
        [3]={x=-1436.36,y=-911.26,z=11.05,h=308.92,ped},
    }},
    dx=-1433.91,dy=-910.39,dz=11.01,dh=337.97
},
    [24] = {x=-791.53,y=-1094.51,z=10.68,h=209.18,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-792.02,y=-1101.35,z=10.65,h=284.56,ped},
        [2]={x=-792.95,y=-1100.43,z=10.67,h=299.17,ped},
        [3]={x=-793.16,y=-1099.26,z=10.7,h=290.85,ped},
    }},
    dx=-790.72,dy=-1100.61,dz=10.66,dh=304.57
},
    [25] = {x=-772.74,y=-1682.98,z=28.67,h=178.06,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-776.86,y=-1688.08,z=29.0,h=251.7,ped},
        [2]={x=-777.17,y=-1686.96,z=28.96,h=257.55,ped},
        [3]={x=-776.83,y=-1685.68,z=28.88,h=270.62,ped},
    }},
    dx=-775.2,dy=-1688.66,dz=28.88,dh=260.38
},
    [26] = {x=-1026.34,y=-2501.26,z=13.67,h=149.88,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1032.75,y=-2504.47,z=13.82,h=240.47,ped},
        [2]={x=-1031.83,y=-2503.19,z=13.81,h=235.02,ped},
        [3]={x=-1031.26,y=-2502.1,z=13.81,h=224.71,ped},
    }},
    dx=-1031.43,dy=-2504.96,dz=13.77,dh=237.11
},
    [27] = {x=-168.51,y=-2110.02,z=24.68,h=296.36,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-161.64,y=-2111.26,z=25.09,h=18.52,ped},
        [2]={x=-162.86,y=-2112.08,z=25.04,h=20.47,ped},
        [3]={x=-164.31,y=-2112.68,z=24.97,h=3.05,ped},
    }},
    dx=-162.36,dy=-2109.76,dz=25.0,dh=21.07
},
    [28] = {x=714.55,y=-2071.8,z=29.18,h=265.81,done=false,Peds = {
    ['Peds'] = {
        [1]={x=719.61,y=-2075.78,z=29.29,h=346.47,ped},
        [2]={x=718.49,y=-2075.99,z=29.29,h=338.66,ped},
        [3]={x=717.27,y=-2075.64,z=29.29,h=343.28,ped},
    }},
    dx=720.09,dy=-2074.25,dz=29.28,dh=346.6
},
    [29] = {x=1431.25,y=-1789.09,z=67.21,h=12.35,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1433.22,y=-1782.61,z=67.12,h=107.35,ped},
        [2]={x=1433.69,y=-1783.83,z=67.23,h=108.75,ped},
        [3]={x=1434.13,y=-1785.15,z=67.34,h=95.94,ped},
    }},
    dx=1431.88,dy=-1783.13,dz=66.81,dh=110.07
},
    [30] = {x=1239.08,y=-1157.8,z=37.42,h=22.44,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1240.08,y=-1151.29,z=37.72,h=105.77,ped},
        [2]={x=1240.54,y=-1152.66,z=37.68,h=105.53,ped},
        [3]={x=1240.83,y=-1153.91,z=37.66,h=103.94,ped},
    }},
    dx=1238.7,dy=-1151.78,dz=37.55,dh=102.55
},
    [31] = {x=809.76,y=-1000.82,z=26.14,h=92.01,done=false,Peds = {
    ['Peds'] = {
        [1]={x=803.75,y=-997.56,z=26.2,h=180.43,ped},
        [2]={x=805.1,y=-997.27,z=26.22,h=170.34,ped},
        [3]={x=806.28,y=-997.52,z=26.24,h=165.69,ped},
    }},
    dx=803.96,dy=-998.96,dz=26.17,dh=180.04
},
    [32] = {x=319.24,y=-804.76,z=29.2,h=341.24,done=false,Peds = {
    ['Peds'] = {
        [1]={x=324.7,y=-800.46,z=29.27,h=62.57,ped},
        [2]={x=324.23,y=-801.68,z=29.27,h=51.15,ped},
        [3]={x=323.64,y=-802.21,z=29.27,h=44.88,ped},
    }},
    dx=323.26,dy=-800.11,dz=29.27,dh=75.94
},
      
}


Config.Second = {
    [1] = {x=-37.29,y=-109.29,z=57.4,h=69.12,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-40.85,y=-103.36,z=57.68,h=174.35,ped},
        [2]={x=-39.51,y=-103.72,z=57.6,h=166.46,ped},
        [3]={x=-38.17,y=-104.45,z=57.55,h=155.7,ped},
    }},
    dx=-41.49,dy=-104.9,dz=57.67,dh=155.02
},
   [2] = {x=-685.66,y=-4.92,z=38.33,h=106.91,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-691.59,y=-2.5,z=38.32,h=182.1,ped},
        [2]={x=-690.42,y=-2.27,z=38.34,h=192.35,ped},
        [3]={x=-693.42,y=-3.15,z=38.29,h=201.91,ped},
    }},
    dx=-691.76,dy=-4.32,dz=38.3,dh=187.59
},
    [3] = {x=-1373.78,y=-46.46,z=52.23,h=98.94,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1378.25,y=-43.52,z=52.52,h=187.21,ped},
        [2]={x=-1376.0,y=-43.41,z=52.38,h=188.37,ped},
        [3]={x=-1377.68,y=-42.31,z=52.49,h=175.46,ped},
    }},
    dx=-1379.31,dy=-44.68,dz=52.56,dh=194.67
},
    [4] = {x=-786.52,y=203.79,z=75.95,h=274.69,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-780.81,y=200.67,z=75.93,h=354.43,ped},
        [2]={x=-782.32,y=200.75,z=75.98,h=358.75,ped},
        [3]={x=-783.55,y=200.72,z=76.01,h=24.95,ped},
    }},
    dx=-780.9,dy=201.75,dz=75.88,dh=0.17
},
    [5] = {x=-322.44,y=457.93,z=108.61,h=234.1,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-320.44,y=451.63,z=109.09,h=331.12,ped},
        [2]={x=-321.56,y=452.33,z=109.21,h=326.72,ped},
        [3]={x=-322.08,y=452.9,z=109.24,h=334.55,ped},
    }},
    dx=-319.28,dy=452.86,dz=108.44,dh=318.93
},
    [6] = {x=271.62,y=156.31,z=104.35,h=250.02,done=false,Peds = {
    ['Peds'] = {
        [1]={x=273.99,y=151.13,z=104.42,h=342.77,ped},
        [2]={x=272.61,y=151.64,z=104.45,h=333.25,ped},
        [3]={x=277.74,y=150.18,z=104.35,h=12.82,ped},
    }},
    dx=275.99,dy=151.73,dz=104.3,dh=348.38
},
    [7] = {x=967.35,y=143.11,z=80.86,h=321.32,done=false,Peds = {
    ['Peds'] = {
        [1]={x=974.02,y=145.41,z=80.99,h=49.05,ped},
        [2]={x=973.11,y=144.29,z=80.99,h=55.96,ped},
        [3]={x=972.33,y=143.27,z=80.99,h=50.55,ped},
    }},
    dx=972.65,dy=146.22,dz=80.99,dh=51.09
},
    [8] = {x=1495.65,y=799.53,z=76.89,h=327.14,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1499.83,y=800.73,z=76.97,h=353.09,ped},
        [2]={x=1498.78,y=800.11,z=76.89,h=352.88,ped},
        [3]={x=1502.66,y=804.85,z=77.02,h=105.33,ped},
    }},
    dx=1501.24,dy=802.81,dz=76.99,dh=64.83
},
    [9] = {x=2423.71,y=2891.77,z=40.22,h=308.28,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2429.13,y=2892.18,z=40.27,h=43.53,ped},
        [2]={x=2428.11,y=2891.32,z=40.27,h=39.11,ped},
        [3]={x=2427.3,y=2890.63,z=40.27,h=40.2,ped},
    }},
    dx=2429.44,dy=2893.78,dz=40.24,dh=41.87
},
    [10] = {x=2944.89,y=3971.8,z=51.66,h=8.53,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2947.19,y=3976.74,z=51.6,h=113.25,ped},
        [2]={x=2947.76,y=3976.11,z=51.63,h=103.48,ped},
        [3]={x=2947.69,y=3979.56,z=51.61,h=116.21,ped},
    }},
    dx=2946.16,dy=3977.8,dz=51.59,dh=101.38
},
    [11] = {x=2665.53,y=5046.72,z=44.78,h=12.11,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2668.68,y=5052.55,z=44.82,h=115.24,ped},
        [2]={x=2669.06,y=5051.38,z=44.81,h=104.33,ped},
        [3]={x=2667.75,y=5049.4,z=44.77,h=71.75,ped},
    }},
    dx=2666.44,dy=5052.76,dz=44.76,dh=92.19
},
    [12] = {x=2373.02,y=5848.53,z=46.74,h=33.36,done=false,Peds = {
    ['Peds'] = {
        [1]={x=2374.32,y=5855.19,z=47.16,h=127.15,ped},
        [2]={x=2375.26,y=5854.02,z=47.18,h=119.56,ped},
        [3]={x=2374.77,y=5852.43,z=46.71,h=93.82,ped},
    }},
    dx=2371.87,dy=5854.58,dz=46.79,dh=124.64
},
    [13] = {x=1682.77,y=6394.77,z=30.94,h=76.26,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1677.47,y=6399.7,z=30.53,h=172.8,ped},
        [2]={x=1678.74,y=6399.57,z=30.68,h=166.03,ped},
        [3]={x=1680.01,y=6399.27,z=30.77,h=161.81,ped},
    }},
    dx=1677.73,dy=6397.93,dz=30.56,dh=162.13
},
    [14] = {x=184.79,y=6563.79,z=31.96,h=114.12,done=false,Peds = {
    ['Peds'] = {
        [1]={x=178.68,y=6564.62,z=31.98,h=210.64,ped},
        [2]={x=179.35,y=6565.37,z=32.02,h=207.73,ped},
        [3]={x=180.64,y=6565.96,z=32.02,h=184.52,ped},
    }},
    dx=178.71,dy=6563.26,dz=31.89,dh=210.59
},
    [15] = {x=-360.79,y=6031.94,z=31.26,h=133.91,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-368.36,y=6030.07,z=31.28,h=238.68,ped},
        [2]={x=-366.49,y=6031.55,z=31.25,h=230.86,ped},
        [3]={x=-365.27,y=6032.34,z=31.23,h=221.85,ped},
    }},
    dx=-366.48,dy=6029.53,dz=31.3,dh=221.6
},
    [16] = {x=-752.92,y=5517.97,z=35.65,h=121.82,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-759.8,y=5517.92,z=35.25,h=203.76,ped},
        [2]={x=-758.49,y=5518.46,z=35.37,h=199.52,ped},
        [3]={x=-757.16,y=5518.74,z=35.48,h=177.39,ped},
    }},
    dx=-758.92,dy=5516.83,dz=35.45,dh=204.62
},
    [17] = {x=-1514.66,y=5009.28,z=62.67,h=137.89,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1521.15,y=5007.65,z=62.3,h=214.24,ped},
        [2]={x=-1520.04,y=5008.78,z=62.31,h=214.29,ped},
        [3]={x=-1518.82,y=5009.38,z=62.39,h=205.47,ped},
    }},
    dx=-1520.15,dy=5006.55,dz=62.47,dh=222.34
},
[18] = {x=-2244.6,y=4299.2,z=47.42,h=148.75,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2250.52,y=4296.29,z=47.13,h=232.6,ped},
        [2]={x=-2249.63,y=4297.29,z=47.17,h=228.51,ped},
        [3]={x=-2248.73,y=4298.26,z=47.24,h=233.09,ped},
    }},
    dx=-2249.54,dy=4295.51,dz=47.17,dh=235.61
},
    [19] = {x=-2719.75,y=2322.07,z=17.62,h=162.43,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2725.31,y=2318.06,z=17.71,h=258.66,ped},
        [2]={x=-2724.89,y=2319,29,z=17.64,h=245.2,ped},
        [3]={x=-2724.29,y=2322.19,z=17.49,h=226.98,ped},
    }},
    dx=-2723.79,dy=2317.36,dz=17.79,dh=247.46
},
    [20] = {x=-3125.33,y=1095.92,z=20.47,h=172.25,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-3129.44,y=1090.8,z=20.63,h=248.54,ped},
        [2]={x=-3129.17,y=1092.25,z=20.63,h=257.62,ped},
        [3]={x=-3128.9,y=1093.73,z=20.62,h=219.13,ped},
    }},
    dx=-3128.05,dy=1090.52,dz=20.47,dh=260.09
},
    [21] = {x=-2857.78,y=47.65,z=14.36,h=251.84,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2853.06,y=42.76,z=14.4,h=3.23,ped},
        [2]={x=-2854.45,y=42.49,z=14.38,h=351.22,ped},
        [3]={x=-2855.89,y=43.84,z=14.38,h=350.01,ped},
    }},
    dx=-2853.0,dy=43.87,dz=14.42,dh=338.79
},
    [22] = {x=-2127.18,y=-373.48,z=12.97,h=249.36,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-2123.13,y=-378.91,z=12.97,h=330.65,ped},
        [2]={x=-2124.52,y=-378.49,z=12.99,h=340.07,ped},
        [3]={x=-2125.53,y=-377.8,z=13.01,h=314.76,ped},
    }},
    dx=-2122.61,dy=-377.46,dz=12.81,dh=328.99
},
    [23] = {x=-1438.34,y=-906.15,z=10.86,h=246.23,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1434.59,y=-911.8,z=11.06,h=335.14,ped},
        [2]={x=-1435.72,y=-911.85,z=11.06,h=330.4,ped},
        [3]={x=-1436.36,y=-911.26,z=11.05,h=308.92,ped},
    }},
    dx=-1433.91,dy=-910.39,dz=11.01,dh=337.97
},
    [24] = {x=-791.53,y=-1094.51,z=10.68,h=209.18,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-792.02,y=-1101.35,z=10.65,h=284.56,ped},
        [2]={x=-792.95,y=-1100.43,z=10.67,h=299.17,ped},
        [3]={x=-793.16,y=-1099.26,z=10.7,h=290.85,ped},
    }},
    dx=-790.72,dy=-1100.61,dz=10.66,dh=304.57
},
    [25] = {x=-772.74,y=-1682.98,z=28.67,h=178.06,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-776.86,y=-1688.08,z=29.0,h=251.7,ped},
        [2]={x=-777.17,y=-1686.96,z=28.96,h=257.55,ped},
        [3]={x=-776.83,y=-1685.68,z=28.88,h=270.62,ped},
    }},
    dx=-775.2,dy=-1688.66,dz=28.88,dh=260.38
},
    [26] = {x=-1026.34,y=-2501.26,z=13.67,h=149.88,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-1032.75,y=-2504.47,z=13.82,h=240.47,ped},
        [2]={x=-1031.83,y=-2503.19,z=13.81,h=235.02,ped},
        [3]={x=-1031.26,y=-2502.1,z=13.81,h=224.71,ped},
    }},
    dx=-1031.43,dy=-2504.96,dz=13.77,dh=237.11
},
    [27] = {x=-168.51,y=-2110.02,z=24.68,h=296.36,done=false,Peds = {
    ['Peds'] = {
        [1]={x=-161.64,y=-2111.26,z=25.09,h=18.52,ped},
        [2]={x=-162.86,y=-2112.08,z=25.04,h=20.47,ped},
        [3]={x=-164.31,y=-2112.68,z=24.97,h=3.05,ped},
    }},
    dx=-162.36,dy=-2109.76,dz=25.0,dh=21.07
},
    [28] = {x=714.55,y=-2071.8,z=29.18,h=265.81,done=false,Peds = {
    ['Peds'] = {
        [1]={x=719.61,y=-2075.78,z=29.29,h=346.47,ped},
        [2]={x=718.49,y=-2075.99,z=29.29,h=338.66,ped},
        [3]={x=717.27,y=-2075.64,z=29.29,h=343.28,ped},
    }},
    dx=720.09,dy=-2074.25,dz=29.28,dh=346.6
},
    [29] = {x=1431.25,y=-1789.09,z=67.21,h=12.35,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1433.22,y=-1782.61,z=67.12,h=107.35,ped},
        [2]={x=1433.69,y=-1783.83,z=67.23,h=108.75,ped},
        [3]={x=1434.13,y=-1785.15,z=67.34,h=95.94,ped},
    }},
    dx=1431.88,dy=-1783.13,dz=66.81,dh=110.07
},
    [30] = {x=1239.08,y=-1157.8,z=37.42,h=22.44,done=false,Peds = {
    ['Peds'] = {
        [1]={x=1240.08,y=-1151.29,z=37.72,h=105.77,ped},
        [2]={x=1240.54,y=-1152.66,z=37.68,h=105.53,ped},
        [3]={x=1240.83,y=-1153.91,z=37.66,h=103.94,ped},
    }},
    dx=1238.7,dy=-1151.78,dz=37.55,dh=102.55
},
    [31] = {x=809.76,y=-1000.82,z=26.14,h=92.01,done=false,Peds = {
    ['Peds'] = {
        [1]={x=803.75,y=-997.56,z=26.2,h=180.43,ped},
        [2]={x=805.1,y=-997.27,z=26.22,h=170.34,ped},
        [3]={x=806.28,y=-997.52,z=26.24,h=165.69,ped},
    }},
    dx=803.96,dy=-998.96,dz=26.17,dh=180.04
},
    [32] = {x=319.24,y=-804.76,z=29.2,h=341.24,done=false,Peds = {
    ['Peds'] = {
        [1]={x=324.7,y=-800.46,z=29.27,h=62.57,ped},
        [2]={x=324.23,y=-801.68,z=29.27,h=51.15,ped},
        [3]={x=323.64,y=-802.21,z=29.27,h=44.88,ped},
    }},
    dx=323.26,dy=-800.11,dz=29.27,dh=75.94
},
      
}

Config.Clothes = {
    male = {
        ['tshirt_1'] = 144,  ['tshirt_2'] = 0,
        ['torso_1'] = 137,   ['torso_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 28,   ['pants_2'] = 0,
        ['shoes_1'] = 36,   ['shoes_2'] = 3,
    },
    female = {
        ['tshirt_1'] = 90,  ['tshirt_2'] = 18,
        ['torso_1'] = 134,   ['torso_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 12,   ['pants_2'] = 2,
        ['shoes_1'] = 37,   ['shoes_2'] = 3,
    }
  }