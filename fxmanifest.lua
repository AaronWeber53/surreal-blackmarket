fx_version 'cerulean'
game 'gta5'

description 'surreal-blackmarket'
version '1.0.0'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua' -- Change this to your preferred language
}

client_scripts {
    'client/client_functions.lua',
    'client/main.lua',
    'client/loop.lua',
}

server_scripts {
    'server/server_functions.lua',
    'server/main.lua',
    'server/store.lua'
}

lua54 'yes'