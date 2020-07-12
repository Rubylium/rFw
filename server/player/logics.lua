


PlayersCache = {}


Citizen.CreateThread(function()
    while true do
        for k,v in pairs(PlayersCache) do
            print(v.id, v.money, v.bank, v.inv)
            if GetPlayerPing(v.source) == 0 then
                SavePlayer(v, k)
            end
        end
        Wait(5*1000)
    end
end)

function SavePlayer(info, id)
    local account = json.encode({money = info.money, bank = info.bank})
    local inv = json.encode(info.inv)

    MySQL.Sync.execute("UPDATE `players` SET accounts = '"..account.."', inv = '"..inv.."' WHERE players.id = '"..info.id.."'")
    print("^2SAVED: ^7Player "..info.source.." saved.")
    PlayersCache[id] = nil
end

function CreateUser(license)
    local accounts = json.encode({money = config.defaultMoney, bank = config.defaultBank})
    MySQL.Sync.execute("INSERT INTO `players` (`license`, `accounts`, `inv`) VALUES ('"..license.."', '"..accounts.."', '[]')")

    local id = MySQL.Sync.fetchAll("SELECT id FROM players WHERE license = @identifier", {
        ['@identifier'] = license
    })
    return id[1]
end

RegisterNetEvent(config.prefix.."InitPlayer")
AddEventHandler(config.prefix.."InitPlayer", function()
    local source = source	
    local license = GetPlayerIdentifiers(source)[1]

    local info = MySQL.Sync.fetchAll("SELECT * FROM players WHERE license = @identifier", {
        ['@identifier'] = license
    })

    PlayersCache[source] = {}

    if info[1] == nil then
        local id = CreateUser(license)
        PlayersCache[source].source = source
        PlayersCache[source].inv = {}
        PlayersCache[source].id = id
        PlayersCache[source].money = config.defaultMoney
        PlayersCache[source].bank = config.defaultBank
    else
        local inv = json.decode(info[1].inv)
        local account = json.decode(info[1].accounts)
        PlayersCache[source].source = source
        PlayersCache[source].inv = inv
        PlayersCache[source].id = info[1].id
        PlayersCache[source].money = account.money
        PlayersCache[source].bank = account.bank
    end
    print("^2CACHE: ^7Added player "..source.." to cache.")
end)