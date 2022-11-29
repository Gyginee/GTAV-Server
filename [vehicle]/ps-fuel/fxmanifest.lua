fx_version 'cerulean'
game 'gta5'

description 'ps-fuel'
version '1.0'
author 'Gyginee#0929'

client_scripts {
    '@PolyZone/client.lua',
	'client/client.lua',
	'client/utils.lua'
}

server_scripts {
	'server/server.lua'
}

shared_scripts {
	
	
	-- 'locales/de.lua',
	'shared/config.lua',
}

exports {
	'GetFuel',
	'SetFuel'
}

lua54 'yes'
