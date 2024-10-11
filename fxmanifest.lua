fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
}

client_script 'main.lua'

ui_page "nui/index.html"

files {
    "nui/*.*",
    "nui/assets/*.*"
}