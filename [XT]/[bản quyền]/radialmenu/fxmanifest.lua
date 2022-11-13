fx_version "cerulean"
game "common"
lua54 'yes'

client_scripts{ 
    'config.lua',
    'client.lua',
    'functions.lua',
}

escrow_ignore {
    'config.lua'
}

ui_page "html/index.html"
files {
	"html/index.html",
    "html/app.js",
    "html/style.css",
    "html/*.ttf"
}
dependency '/assetpacks'