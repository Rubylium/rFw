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
        SavePlayerDisconnect(PlayersCache[source], source)
        PlayersCache[source] = nil
    end
end)

function SavePlayerDisconnect(info, id)
    local account = json.encode({money = info.money, bank = info.bank})
    local inv = json.encode(info.inv)
    local pos = json.encode({x = info.pos.x, y = info.pos.y, z = info.pos.z})
    local skin = json.encode(info.skin)
    local identity = json.encode(info.identity)
    MySQL.Sync.execute("UPDATE `players` SET identity = '"..identity.."', accounts = '"..account.."', skin = '"..skin.."', inv = '"..inv.."', pos = '"..pos.."', job = '"..info.job.."', job_grade = '"..info.job_grade.."' WHERE players.id = '"..info.id.."'")
    print("^2SAVED: ^7"..id.." saved.")
end

local savingCount = 0
local requests = {}

function SavePlayer(info, id)
    local account = json.encode({money = info.money, bank = info.bank})
    local inv = json.encode(info.inv)
    local pos = json.encode({x = info.pos.x, y = info.pos.y, z = info.pos.z})
    local skin = json.encode(info.skin)
    local identity = json.encode(info.identity)
    requests[#requests + 1] = "UPDATE `players` SET identity = '"..identity.."', accounts = '"..account.."', skin = '"..skin.."', inv = '"..inv.."', pos = '"..pos.."', job = '"..info.job.."', job_grade = '"..info.job_grade.."' WHERE players.id = '"..info.id.."'"
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
    MySQL.Sync.execute("INSERT INTO `players` (`license`, `accounts`, `identity`, `perm_level`, `inv`, `pos`, `job`, `job_grade`) VALUES ('"..license.."', '"..accounts.."', '[]', '0', '[]', '"..pos.."', 'Aucun', '0')")

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
        PlayersCache[source].job = "Aucun"
        PlayersCache[source].job_grade = 0
        PlayersCache[source].perm = 0
        PlayersCache[source].skin = nil
        PlayersCache[source].identity = {}
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
        PlayersCache[source].job = info[1].job
        PlayersCache[source].job_grade = info[1].job_grade
        PlayersCache[source].perm = info[1].perm_level
        if info[1].skin == nil then
            PlayersCache[source].skin = nil
        else
            PlayersCache[source].skin = json.decode(info[1].skin)
        end
        if info[1].identity == nil then
            PlayersCache[source].identity = nil
        else
            PlayersCache[source].identity = json.decode(info[1].identity)
        end
    end
    print("^2CACHE: ^7Added player "..source.." to cache.")
    TriggerClientEvent(config.prefix.."PlayerLoaded", source, PlayersCache[source], config.items)
    TriggerClientEvent(config.prefix.."OnInvRefresh", source, PlayersCache[source].inv, GetInvWeight(PlayersCache[source].inv))
end)