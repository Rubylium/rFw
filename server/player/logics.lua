


PlayersCache = {}


Citizen.CreateThread(function()
    while true do
        for k,v in pairs(PlayersCache) do
            SavePlayer(v, k)
        end
        Wait(config.savingAllPlayers*60*1000)
    end
end)

AddEventHandler('playerDropped', function (reason)
    local source = source
    if PlayersCache[source] ~= nil then
        SavePlayer(PlayersCache[source], source)
        PlayersCache[source] = nil
    end
end)

local savingCount = 0
local requests = {}
function SavePlayer(info, id)
    local account = json.encode({money = info.money, bank = info.bank})
    local inv = json.encode(info.inv)
    local pos = json.encode({x = info.pos.x, y = info.pos.y, z = info.pos.z})
    table.insert(requests, "UPDATE `players` SET accounts = '"..account.."', inv = '"..inv.."', pos = '"..pos.."' WHERE players.id = '"..info.id.."'")
    savingCount = savingCount + 1

    if savingCount == #PlayersCache and savingCount > 0 then
        MySQL.Async.transaction(requests, {}, function(success)
            if success then
                print("^2SAVED: ^7"..savingCount.." players saved.")
            else
                print("^1ERROR: ^7Could not save"..savingCount.." players.")
            end
            savingCount = 0
            requests = {}
        end)  
    end
    
end

function CreateUser(license)
    local accounts = json.encode({money = config.defaultMoney, bank = config.defaultBank})
    local pos = json.encode({x = config.defaultPos.x, y = config.defaultPos.y, z = config.defaultPos.z})
    MySQL.Sync.execute("INSERT INTO `players` (`license`, `accounts`, `inv`, `pos`) VALUES ('"..license.."', '"..accounts.."', '[]', '"..pos.."')")

    local id = MySQL.Sync.fetchAll("SELECT id FROM players WHERE license = @identifier", {
        ['@identifier'] = license
    })
    return id[1].id
end

RegisterNetEvent(config.prefix.."InitPlayer")
AddEventHandler(config.prefix.."InitPlayer", function()
    local license = GetLicense(source)
    local source = source

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
        PlayersCache[source].pos = config.defaultPos
    else
        local inv = json.decode(info[1].inv)
        local account = json.decode(info[1].accounts)
        PlayersCache[source].source = source
        PlayersCache[source].inv = inv
        PlayersCache[source].id = info[1].id
        PlayersCache[source].money = account.money
        PlayersCache[source].bank = account.bank
        if info[1].pos == nil then
            PlayersCache[source].pos = config.defaultPos
        else
            local pos = json.decode(info[1].pos)
            PlayersCache[source].pos = vector3(pos.x, pos.y, pos.z)
        end
    end
    print("^2CACHE: ^7Added player "..source.." to cache.")
    TriggerClientEvent(config.prefix.."PlayerLoaded", source, PlayersCache[source].pos)
end)