fx_version 'cerulean'
game 'gta5'

description 'QB-TattooShop'



client_scripts {
	'config.lua',
	'client/jaymenu.lua',
	'client/main.lua'
}

server_scripts {'server/main.lua',
'@oxmysql/lib/MySQL.lua'
}

file 'AllTattoos.json'