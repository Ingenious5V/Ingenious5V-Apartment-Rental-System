fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'FiveM NUI Example'
version '1.0.0'

-- Specify the NUI page
ui_page 'html/index.html'

-- Include the HTML, CSS, and JavaScript files
files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/images/defaultapartment.png',
    'html/images/defaultinterior.pngg'
}

-- Client scripts
client_scripts {
    'client/main.lua'
}

-- Server scripts
server_scripts {
    'server/main.lua'
}
