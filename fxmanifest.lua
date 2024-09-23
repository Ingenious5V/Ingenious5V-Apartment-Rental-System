-- fxmanifest.lua
fx_version 'cerulean'
game 'gta5'

author 'Ingenious5V'
description 'Apartment Rental System with Overextended Integration'
version '1.0.0'

lua54 'yes' -- Enable Lua 5.4

shared_scripts {
    '@ox_lib/init.lua', -- Overextended library
    'shared/config.lua', -- Your shared configuration
}

client_scripts {
    'client/main.lua', -- Your client script
}

server_scripts {
    'server/main.lua', -- Your server script
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/images/apartment1.jpg',
    'html/images/apartment2.jpg',
    'html/images/interior1.jpg',
    'html/images/interior2.jpg'
}
