
fx_version 'adamant'

game 'gta5'

ui_page 'html/form.html'
version '1.1'

files {
	'html/form.html',
	'html/css.css',
	'html/water.png',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
	'html/img/*.png',
}

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'
