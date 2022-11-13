QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Cư dân',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Vô gia cư',
                payment = 10
            },
        },
	},
	['police'] = {
		label = 'Cảnh sát',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Thiếu úy',
                payment = 50
            },
			['1'] = {
                name = 'Trung úy',
                payment = 75
            },
			['2'] = {
                name = 'Thượng úy',
                payment = 100
            },
			['3'] = {
                name = 'Đại úy',
                payment = 125
            },
			['4'] = {
                name = 'Đại tá',
				isboss = true,
                payment = 150
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Điều dưỡng',
                payment = 50
            },
			['1'] = {
                name = 'Dược sĩ',
                payment = 75
            },
			['2'] = {
                name = 'Y sĩ',
                payment = 100
            },
			['3'] = {
                name = 'Bác sĩ',
                payment = 125
            },
			['4'] = {
                name = 'Giám đốc',
				isboss = true,
                payment = 150
            },
        },
	},
	['realestate'] = {
		label = 'Bất động sản',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
			['1'] = {
                name = 'Tay mơ',
                payment = 75
            },
			['2'] = {
                name = 'Chuyên nghiệp',
                payment = 100
            },
			['3'] = {
                name = 'Quản lý',
                payment = 125
            },
			['4'] = {
                name = 'Giám đốc',
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
			['1'] = {
                name = 'Quản lý',
				isboss = true,
                payment = 150
            },
        },
	},
     ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Tài xế',
                payment = 50
            },
		},
	},
	['cardealer'] = {
		label = 'Bán xe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
			['1'] = {
                name = 'Quản lý',
                isboss = true,
                payment = 75
            },
			
        },
	},
	['mechanic'] = {
		label = 'Sửa xe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
			['1'] = {
                name = 'Quản lý',
				isboss = true,
                payment = 150
            },
        },
	},
    ['doxe'] = {
		label = 'Xưởng độ',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Thợ máy',
                payment = 50
            },
			['2'] = {
                name = 'Chủ xưởng',
				isboss = true,
                payment = 150
            },
        },
	},
	['judge'] = {
		label = 'Toà án',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Thẩm phán',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Luật sư',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Điều tra viên',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Nhà báo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Phóng viên',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Xe tải',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Tài xế',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Kéo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Tài xế',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Vệ sinh',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Lao công',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nông dân',
                payment = 50
            },
        },
	},

	['nhahang'] = {
		label = 'Nhà hàng',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
            ['1'] = {
                name = 'Quản lý',
                payment = 50,
                isboss = true,
            },
        },
	},

	['bar'] = {
		label = 'Quán Bar',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
            ['1'] = {
                name = 'Quản lý',
                payment = 50,
                isboss = true,
            },
        },
	},
    ['xam'] = {
		label = 'Tiệm xăm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
            ['1'] = {
                name = 'Quản lý',
                payment = 50,
                isboss = true,
            },
        },
	},
	['cafe'] = {
		label = 'Quán Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Nhân viên',
                payment = 50
            },
            ['1'] = {
                name = 'Quản lý',
                payment = 50,
                isboss = true,
            },
        },
	},

}