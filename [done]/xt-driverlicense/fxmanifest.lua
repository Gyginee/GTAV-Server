fx_version 'cerulean'
game 'gta5'

description 'xt-driverlicense'
version '2.0.0'
author 'Gyginee#0929'


shared_scripts {
    'config.lua'
}

server_script 'server/server.lua'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'client/client.lua'
}

files {
    
}

lua54 'yes'
use_fxv2_oal 'yes'