fx_version 'cerulean'

games { 'gta5' }

author 'M_N•Script'

description 'Job with props'

version '1.0.0'


client_scripts {
    'client/apel.lua',
    'client/function.lua',
    'locales/id.lua',
    'config.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'locales/id.lua',
    'config.lua'
}

dependencies {
}