fx_version 'cerulean'
game 'gta5'


ui_page 'html/index.html'

client_scripts {
    'client/main.lua',
}

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css',
    'html/cylinder.png',
    'html/driver.png',
    'html/pinBott.png',
    'html/pinTop.png',
    'html/collar.png',
}

exports {
 'OpenLockpickGame',
 'GetLockPickStatus',
}