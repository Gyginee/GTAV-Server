Config = {}

    Config.compatable_weapon_hashes = {
         -- assault rifles:
         ["weapon_carbinerifle"] = { model = "w_ar_carbinerifle", hash = -2084633992, pos = {bone = 10706, x = 0.0, y = 0.19, z = -0.25, x_rotation = 0.0, y_rotation = 75.0, z_rotation = 180.0} },
        ["weapon_carbinerifle_mk2"] = { model = "w_ar_carbineriflemk2", hash = GetHashKey("WEAPON_CARBINERIFLE_MK2"),pos = {bone = 10706, x = 0.0, y = 0.19, z = -0.25, x_rotation = 0.0, y_rotation = 75.0, z_rotation = 180.0} },
         ["weapon_assaultrifle"] = { model = "w_ar_assaultrifle", hash = -1074790547, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         ["weapon_specialcarbine"] = { model = "w_ar_specialcarbine", hash = -1063057011, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         ["weapon_bullpuprifle"] = { model = "w_ar_bullpuprifle", hash = 2132975508, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 0.0, z_rotation = 0.0}},
         ["weapon_advancedrifle"] = { model = "w_ar_advancedrifle", hash = -1357824103, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
		 ["weapon_compactrifle"] = { model = "w_ar_assaultrifle_smg", hash = -1357824103, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         -- sub machine guns:
         ["weapon_gusenberg"] = { model = "w_sb_gusenberg", hash = 1627465347, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         -- sniper rifles:
         ["weapon_sniperrifle"] = { model = "w_sr_sniperrifle", hash = 100416529, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         -- shotguns:
         ["weapon_assaultshotgun"] = { model = "w_sg_assaultshotgun", hash = -494615257, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         ["weapon_bullpupshotgun"] = { model = "w_sg_bullpupshotgun", hash = -1654528753, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         ["weapon_pumpshotgun"] = { model = "w_sg_pumpshotgun", hash = 487013001, pos = {bone = 10706, x = 0.0, y = 0.19, z = -0.25, x_rotation = 0.0, y_rotation = 60.0, z_rotation = 180.0}},
         ["weapon_musket"] = { model = "w_ar_musket", hash = -1466123874, pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         ["weapon_heavyshotgun"] = { model = "w_sg_heavyshotgun", hash = GetHashKey("WEAPON_HEAVYSHOTGUN"), pos = {bone = 24816, x = 0.275, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 145.0, z_rotation = 0.0}},
         --meleee
         ["weapon_machete"] = { model = "w_me_machette_lr", hash = GetHashKey("weapon_machete"), pos = {bone = 24816, x = 0.175, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
         ["weapon_knife"] = { model = "W_ME_knife_01", hash = GetHashKey("weapon_knife"), pos = {bone = 24816, x = 0.0, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
         ["weapon_dagger"] = { model = "w_me_dagger", hash = GetHashKey("weapon_dagger"), pos = {bone = 24816, x = 0.0, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
         ["weapon_bottle"] = { model = "w_me_bottle", hash = GetHashKey("weapon_bottle"), pos = {bone = 24816, x = 0.175, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
		 ["weapon_hatchet"] = { model = "w_me_hatchet", hash = GetHashKey("weapon_hatchet"), pos = {bone = 24816, x = 0.175, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
		 ["weapon_bat"] = { model = "W_ME_Bat", hash = GetHashKey("weapon_bat"), pos = {bone = 24816, x = 0.4, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
		 ["weapon_battleaxe"] = { model = "w_me_battleaxe", hash = GetHashKey("weapon_battleaxe"), pos = {bone = 24816, x = 0.175, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
         ["weapon_poolcue"] = { model = "w_me_poolcue", hash = GetHashKey("weapon_poolcue"), pos = {bone = 24816, x = 0.4, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
		 ["weapon_nightstick"] = { model = "W_ME_Nightstick", hash = GetHashKey("weapon_nightstick"), pos = {bone = 24816, x = -0.075, y = 0.0, z = 0.2, x_rotation = 0.0, y_rotation = 0.0, z_rotation = 120.0}},
		 ["weapon_golfclub"] = { model = "W_ME_GClub", hash = GetHashKey("weapon_golfclub"), pos = {bone = 24816, x = 0.4, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
		 ["weapon_crowbar"] = { model = "w_me_crowbar", hash = GetHashKey("weapon_crowbar"), pos = {bone = 24816, x = 0.175, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
		 ["weapon_wrench"] = { model = "w_me_wrench", hash = GetHashKey("weapon_wrench"), pos = {bone = 24816, x = 0.175, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
		 ["weapon_stone_hatchet"] = { model = "w_me_Stonehatchet", hash = GetHashKey("weapon_stone_hatchet"), pos = {bone = 24816, x = 0.175, y = -0.15, z = -0.15, x_rotation = 0.0, y_rotation = -35.0, z_rotation = 0.0}},
         --pistol
         ["weapon_pistol"] = { model = "w_pi_pistol", hash = GetHashKey("weapon_pistol"), pos = {bone = 11816, x = 0.125, y = 0.0, z = 0.22, x_rotation = 270.0, y_rotation = 0.0, z_rotation = 0.0}},
         ["weapon_stungun"] = { model = "W_PI_STUNGUN", hash =  GetHashKey("weapon_stungun"), pos = {bone = 10706, x = 0.0, y = 0.19, z = -0.25, x_rotation = 0.0, y_rotation = 75.0, z_rotation = 180.0} },
		 ["weapon_pistol_mk2"] = { model = "W_PI_PISTOLMK2", hash = GetHashKey("weapon_pistol_mk2"), pos = {bone = 11816, x = 0.125, y = 0.0, z = 0.22, x_rotation = 270.0, y_rotation = 0.0, z_rotation = 0.0}},
		 ["weapon_combatpistol"] = { model = "W_PI_COMBATPISTOL", hash = GetHashKey("weapon_combatpistol"), pos = {bone = 11816, x = 0.125, y = 0.0, z = 0.22, x_rotation = 270.0, y_rotation = 0.0, z_rotation = 0.0}},
		 ["weapon_pistol50"] = { model = "W_PI_PISTOL50", hash = GetHashKey("weapon_pistol50"), pos = {bone = 11816, x = 0.125, y = 0.0, z = 0.22, x_rotation = 270.0, y_rotation = 0.0, z_rotation = 0.0}},
		 ["weapon_heavypistol"] = { model = "w_pi_heavypistol", hash = GetHashKey("weapon_heavypistol"), pos = {bone = 11816, x = 0.125, y = 0.0, z = 0.22, x_rotation = 270.0, y_rotation = 0.0, z_rotation = 0.0}},
		 ["weapon_snspistol"] = { model = "w_pi_sns_pistol", hash = GetHashKey("weapon_snspistol"), pos = {bone = 11816, x = 0.125, y = 0.0, z = 0.22, x_rotation = 270.0, y_rotation = 0.0, z_rotation = 0.0}},
		 ["weapon_snspistol_mk2"] = { model = "W_PI_SNS_PistolMK2", hash = GetHashKey("weapon_snspistol_mk2"), pos = {bone = 11816, x = 0.125, y = 0.0, z = 0.22, x_rotation = 270.0, y_rotation = 0.0, z_rotation = 0.0}},
		 --Submachine Guns
		 ["weapon_microsmg"] = { model = "W_SB_MICROSMG", hash = GetHashKey("weapon_microsmg"), pos = {bone = 24816, x = -0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 180.0, z_rotation = 0.0}},
		 ["weapon_smg"] = { model = "W_SB_SMG", hash = GetHashKey("weapon_smg"), pos = {bone = 10706, x = 0.0, y = 0.19, z = -0.25, x_rotation = 0.0, y_rotation = 60.0, z_rotation = 180.0}},
		 ["weapon_smg_mk2"] = { model = "W_SB_SMGMK2", hash = GetHashKey("weapon_smg_mk2"), pos = {bone = 10706, x = 0.0, y = 0.19, z = -0.25, x_rotation = 0.0, y_rotation = 60.0, z_rotation = 180.0}},
		 ["weapon_assaultsmg"] = { model = "W_SB_ASSAULTSMG", hash = GetHashKey("weapon_assaultsmg"), pos = {bone = 10706, x = 0.0, y = 0.19, z = -0.25, x_rotation = 0.0, y_rotation = 60.0, z_rotation = 180.0}},
		 ["weapon_minismg"] = { model = "w_sb_minismg", hash = GetHashKey("weapon_minismg"), pos = {bone = 24816, x = -0.075, y = -0.15, z = -0.02, x_rotation = 0.0, y_rotation = 180.0, z_rotation = 0.0}},
      }

