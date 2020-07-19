function GiveMoneyToSociety(id, society, amount)
    if societyCache[society] ~= nil then -- Be sure the society exist befor doing thing with it
        if PlayersCache[id].money >= amount then
            PlayersCache[id].money = PlayersCache[id].money - amount
            societyCache[society].money = societyCache[society].money + amount
        else
            ErrorHandling(id, 3)
        end
    else
        ErrorHandling(id, 4)
    end
end

function GiveBankToSociety(id, society, amount)
    if societyCache[society] ~= nil then -- Be sure the society exist befor doing thing with it
        if PlayersCache[id].bank >= amount then
            PlayersCache[id].bank = PlayersCache[id].bank - amount
            societyCache[society].money = societyCache[society].money + amount
        else
            ErrorHandling(id, 3)
        end
    else
        ErrorHandling(id, 4)
    end
end