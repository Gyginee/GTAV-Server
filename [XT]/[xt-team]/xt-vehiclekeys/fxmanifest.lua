fx_version 'cerulean'
game 'gta5'

description 'QG-VehicleKeys'
version '1.0.0'
shared_script 'config.lua'



client_scripts {
 'client/client.lua'
}

server_scripts {
 'server/server.lua'
}

exports {
 'SetVehicleKey',
}