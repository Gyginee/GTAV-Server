fx_version 'cerulean'
game 'gta5'

description "Cào số cho zui"

ui_page 'html/build/index.html'

files {
  'html/build/index.html',
  'html/build/static/css/main.css',
  'html/build/static/js/main.js',
  'html/build/static/media/impactreg.eot',
  'html/build/static/media/impactreg.ttf',
  'html/build/static/media/impactreg.woff',
  'html/build/static/media/scratch_bg.jpg',
	'html/build/static/media/scratch.png'

}

client_script {
  "config.lua",
  "client/client.lua",
}

server_script {
  "config.lua",
  "server/server.lua",
}
