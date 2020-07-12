
fx_version 'adamant'
games { 'gta5' };

client_scripts {
    "config.lua",
    "client/*.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "config.lua",
    "utils.lua",
    "server/player/*.lua",
    "server/inventory/*.lua",
    "server/society/*.lua",
}


server_exports {
    "AddMoney",
    "RemoveMoney",
    "AddBank",
    "RemoveBank",
    "GetMoney",
    "GetBank",
}