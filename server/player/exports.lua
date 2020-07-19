

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
value = Value to compare with player's bank 
]]--
function HasEnoughBank(id,value)
    return PlayersCache[id].bank >= value
end

--[[  
id = Server ID
value = Value to compare with player's cash 
]]--
function HasEnoughCash(id,value)
    return PlayersCache[id].money >= value
end

--[[  
id = Server ID
value = Value to send from bank to cash
]]--
function BankToCash(id,value)
    if value > PlayersCache[id].bank then
        ErrorHandling(id,3)
    else
        PlayersCache[id].bank = PlayersCache[id].bank - value
        PlayersCache[id].money = PlayersCache[id].money + value
        TriggerClientEvent(config.prefix.."OnAccountsRefresh", id, PlayersCache[id].money, PlayersCache[id].bank)
    end
end


--[[  
from = Sender's Server ID
to = Receiver's Server ID
value = Value to send to the target
]]--
function doBankTransfer(from,to,value)
    if value > PlayersCache[from].bank then
        ErrorHandling(id,3)
    else
        PlayersCache[from].bank = PlayersCache[from].bank - value
        PlayersCache[to].bank = PlayersCache[to].bank + value
        TriggerClientEvent(config.prefix.."OnAccountsRefresh", from, PlayersCache[from].money, PlayersCache[from].bank)
        TriggerClientEvent(config.prefix.."OnAccountsRefresh", to, PlayersCache[to].money, PlayersCache[to].bank)
    end
end

--[[  
from = Sender's Server ID
to = Receiver's Server ID
value = Value to send to the target
]]--
function doCashTransfer(from,to,value)
    if value > PlayersCache[from].money then
        ErrorHandling(id,3)
    else
        PlayersCache[from].money = PlayersCache[from].money - value
        PlayersCache[to].money = PlayersCache[to].money + value
        TriggerClientEvent(config.prefix.."OnAccountsRefresh", from, PlayersCache[from].money, PlayersCache[from].bank)
        TriggerClientEvent(config.prefix.."OnAccountsRefresh", to, PlayersCache[to].money, PlayersCache[to].bank)
    end
end

--[[  
id = Server ID
value = Value to send from cash to bank
]]--
function CashToBank(id,value)
    if value > PlayersCache[id].cash then
        ErrorHandling(id,3)
    else
        PlayersCache[id].bank = PlayersCache[id].bank + value
        PlayersCache[id].money = PlayersCache[id].money - value
        TriggerClientEvent(config.prefix.."OnAccountsRefresh", id, PlayersCache[id].money, PlayersCache[id].bank)
    end
end

--[[  
id = Server ID
job = New player job
grade = Job grade
]]--
function ChangePlayerJob(id, job, grade)
    if grade == nil then grade = 0 end
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