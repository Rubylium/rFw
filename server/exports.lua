


function AddMoney(id, add)
    PlayersCache[id].money = PlayersCache[id].money + tonumber(add)
end

function RemoveMoney(id, rmv)
    PlayersCache[id].money = PlayersCache[id].money - tonumber(rmv)
end

function AddBank(id, add)
    PlayersCache[id].bank = PlayersCache[id].bank + tonumber(add)
end

function RemoveBank(id, rmv)
    PlayersCache[id].bank = PlayersCache[id].bank - tonumber(rmv)
end