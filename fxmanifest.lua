fx_version 'cerulean'
game 'gta5'

author 'Ingenious5V'
description 'Apartment Rental System for FiveM'
version '1.0.0'

-- Server scripts
server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Include OxMySQL library
    'server/main.lua'
}

-- Client scripts
client_scripts {
    'client/main.lua'
}

-- Shared scripts
shared_scripts {
    'config.lua'
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
