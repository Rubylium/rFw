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


function TransferItemToSociety(id, society, item, count, args)
    if items[item] ~= nil then
        if societyCache[society] ~= nil then -- Be sure the society exist befor doing thing with it
            local exist, itemid = DoesItemExistInSociety(society, item, args)
            if exist then -- Creating the item
                itemid = GenerateItemId()
                societyCache[society].inventory[itemid] = {}
                societyCache[society].inventory[itemid].item = item
                societyCache[society].inventory[itemid].label = items[item].label
                societyCache[society].inventory[itemid].count = count
                societyCache[society].inventory[itemid].itemId = itemid
                societyCache[society].inventory[itemid].args = {}
                if args ~= nil then
                    societyCache[society].inventory[itemid].args = args
                end
            else -- Adding count to the item
                societyCache[society].inventory[itemid].count = societyCache[society].inventory[item].count + count 
            end

            if PlayersCache[id].inv[itemid].count - count <= 0 then
                PlayersCache[id].inv[itemid] = nil
            else
                PlayersCache[id].inv[itemid].count = PlayersCache[id].inv[itemid].count - count
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


function DoesItemExistInSociety(society, item, args)
    if arg == nil then arg = {} end
    for k,v in pairs(societyCache[society].inventory) do
        if v.item == item then
            if json.encode(v.args) == json.encode(arg) then
                return true, v.itemId
            end
        end
    end
    return false
end