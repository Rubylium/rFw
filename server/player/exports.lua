

--[[ 
id = Server ID
add = Money to add ( Int or float )
]]--
function AddMoney(id, add)
    PlayersCache[id].money = PlayersCache[id].money + tonumber(add)
end

--[[  
id = Server ID
rmv = Money to remove ( Int or float )
]]--
function RemoveMoney(id, rmv)
    PlayersCache[id].money = PlayersCache[id].money - tonumber(rmv)
end

--[[  
id = Server ID
add = bank Money to add ( Int or float )
]]--
function AddBank(id, add)
    PlayersCache[id].bank = PlayersCache[id].bank + tonumber(add)
end

--[[  
id = Server ID
rmv = bank Money to remove ( Int or float )
]]--
function RemoveBank(id, rmv)
    PlayersCache[id].bank = PlayersCache[id].bank - tonumber(rmv)
end

--[[  
id = Server ID
]]--
function GetMoney(id)
    return PlayersCache[id].money
end

--[[  
id = Server ID
]]--
function GetBank(id)
    return PlayersCache[id].bank
end

--[[  
id = Server ID
job = New player job
grade = Job grade
]]--
function ChangePlayerJob(id, job, grade)
    PlayersCache[id].job = job
    PlayersCache[id].job_grade = grade
    TriggerClientEvent(config.prefix.."OnJobChange", id, job, grade)
end

--[[  
    EVENTS
]]--

RegisterNetEvent(config.prefix.."SavePos")
AddEventHandler(config.prefix.."SavePos", function(pos)
    PlayersCache[source].pos = pos
end)