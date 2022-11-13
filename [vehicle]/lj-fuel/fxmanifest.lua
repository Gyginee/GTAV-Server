fx_version 'cerulean'
game 'gta5'

description 'lj-fuel'
version '1.3'
author 'github.com/loljoshie'

client_scripts {
    '@PolyZone/client.lua',
	'client/client.lua',
	'client/utils.lua'
}

server_scripts {
	'server/server.lua'
}

shared_scripts {
	'shared/config.lua',
}

exports {
	'GetFuel',
	'SetFuel'
}

lua54 'yes'