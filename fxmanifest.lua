-- fxmanifest.lua
fx_version 'cerulean'
game 'gta5'

author 'Ingenious5V'
description 'Apartment Rental System with Overextended Integration'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua', -- Overextended library
    'config.lua', -- Your configuration
}

client_scripts {
    'client/main.lua', -- Your client script
}

server_scripts {
    'server/main.lua', -- Your server script
}
-- Files
files {
    'html/index.html',
    'html/style.css',
    'html/scripts.js'
}

-- UI page
ui_page 'html/index.html'

-- Dependencies
dependencies {
    'oxmysql'
}
