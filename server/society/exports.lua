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


function TransferItemToSociety(id, society, item, count)
    if items[item] ~= nil then
        if societyCache[society] ~= nil then -- Be sure the society exist befor doing thing with it
            if societyCache[society].inventory[item] == nil then -- Creating the item
                societyCache[society].inventory[item] = {}
                societyCache[society].inventory[item].count = count
                societyCache[society].inventory[item].label = items[item].label
            else -- Adding count to the item
                societyCache[society].inventory[item].count = societyCache[society].inventory[item].count + count 
            end

            if PlayersCache[id].inv[item].count - count <= 0 then
                PlayersCache[id].inv[item] = nil
            else
                PlayersCache[id].inv[item].count = PlayersCache[id].inv[item].count - count
            end

            TriggerClientEvent(config.prefix.."OnRemoveItem", id, items[item].label, count)
            TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv, GetInvWeight(PlayersCache[id].inv))
        else
            ErrorHandling(id, 4)
        end
    else
        ErrorHandling(id, 1)
    end
end

function TransferItemFromSocietyToPlayer(id, society, item, count, countSee) -- Too long name, but eh
    if items[item] ~= nil then
        if societyCache[society] ~= nil then -- Be sure the society exist befor doing thing with it
            if societyCache[society].inventory[item].count == countSee then
                if societyCache[society].inventory[item].count - count <= 0 then -- Removing the item
                    societyCache[society].inventory[item] = nil
                else -- Removing count
                    societyCache[society].inventory[item].count = societyCache[society].inventory[item].count - count
                end

                if PlayersCache[id].inv[item] == nil then -- Creating item
                    PlayersCache[id].inv[item] = {}
                    PlayersCache[id].inv[item].label = items[item].label
                    PlayersCache[id].inv[item].count = count
                else -- Adding count
                    PlayersCache[id].inv[item].count = PlayersCache[id].inv[item].count + count
                end

                TriggerClientEvent(config.prefix.."OnGetItem", id, items[item].label, count)
                TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv, GetInvWeight(PlayersCache[id].inv))
            else
                ErrorHandling(id, 5)
            end
        else
            ErrorHandling(id, 4)
        end
    else
        ErrorHandling(id, 1)
    end
end