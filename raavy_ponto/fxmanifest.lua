fx_version "bodacious"
game "gta5"

author "Raavy"
discord "https://discord.gg/"

client_scripts{
    "@vrp/lib/utils.lua",
    "config/config_ponto.lua",
    "client.lua"
}

server_scripts{
    "@vrp/lib/utils.lua",
    "server.lua"
}

files {
    "web/index.html",
    "web/estilo.css",
    "web/fundotabletsemfundo.png",
    "web/back.js"
}

ui_page "web/index.html"