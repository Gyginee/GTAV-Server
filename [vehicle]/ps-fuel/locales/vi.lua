local Translations = {
    notify = {
        ["no_money"] = "Bạn Không Đủ Tiền",
        ["refuel_cancel"] = "Ngừng bơm xăng",
        ["jerrycan_full"] = "Căn xăng đã đầy",
        ["jerrycan_empty"] = "Can xăng rỗng",
        ["vehicle_full"] = "Xe đã đầy xăng",
        ["already_full"] = "Can xăng đầy",
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
