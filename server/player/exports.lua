

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