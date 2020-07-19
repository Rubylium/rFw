local societyCache = {}
local savingCount = 0
local requests = {}
local societyCount = 0

MySQL.ready(function ()
    GetSocietyToCache()
end)

function GetSocietyToCache()
    local info = MySQL.Sync.fetchAll("SELECT society_name, money, inventory FROM society", {})
    for k,v in pairs(info) do
        local sInv = json.decode(v.inventory)
        societyCache[v.society_name] = {society = v.society_name, money = v.money, inventory = sInv}
        print("^2Loading ^7society ["..v.society_name.."] to dynamic cache with "..v.money.."^2$.")
    end
end


local second = 1000
local minute = 60*second
Citizen.CreateThread(function()
    while true do
        Wait(0.1*minute)
        societyCount = GetSocietyCount()
        for k,v in pairs(societyCache) do
            SaveSocietyCache(v)
        end
    end
end)


-- For some reason, doing #societyCache don't return the table count, maybe due to table syntaxe ?
function GetSocietyCount()
    local count = 0
    for k,v in pairs(societyCache) do
        count = count + 1
    end
    return count
end

function SaveSocietyCache(info)
    local encodedInv = json.encode(info.inventory)
    requests[#requests + 1] = "UPDATE society SET money = '"..info.money.."', inventory = '"..encodedInv.."' WHERE society_name = '"..info.society.."'"
    savingCount = savingCount + 1

    if savingCount == societyCount and savingCount > 0 then
        MySQL.Async.transaction(requests, {}, function(success)
            if success then
                print("^2SAVED: ^7"..savingCount.." society saved.")
            else
                print("^1ERROR: ^7Could not save"..savingCount.." society.")
            end
            savingCount = 0
            requests = {}
            societyCount = 0
        end)  
    end
end