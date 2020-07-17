
local items = config.items

--[[ 
id = Server ID
item = Item name, not label
count = Item count to add

/!\ This do not check player weight befor giving the item /!\
]]--
function AddItem(id, item, count)
    Citizen.CreateThread(function() -- Working in async, maybe that could fix inv issue i got without working in async, need testing i guess
        if items[item] ~= nil then
            if PlayersCache[id].inv[item] == nil then -- Item do not exist in inventory, creating it
                PlayersCache[id].inv[item] = {}
                PlayersCache[id].inv[item].label = items[item].label
                PlayersCache[id].inv[item].count = count
            else -- Item do exist, adding count
                PlayersCache[id].inv[item].count = PlayersCache[id].inv[item].count + count
            end
            TriggerClientEvent(config.prefix.."OnGetItem", id, items[item].label, count)
            TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv)
        else
            -- Item do not exist, should do some kind of error notification
            ErrorHandling(id, 1)
        end
    end)
end

--[[ 
id = Server ID
item = Item name, not label
count = Item count to remove
]]--
function RemoveItem(id, item, count)
    Citizen.CreateThread(function()
        if items[item] ~= nil then
            if PlayersCache[id].inv[item] ~= nil then -- Item do not exist in inventory
                if PlayersCache[id].inv[item].count - count <= 0 then -- If count < or = 0 after removing item count, then deleting it from player inv
                    PlayersCache[id].inv[item] = nil
                else
                    PlayersCache[id].inv[item].count = PlayersCache[id].inv[item].count - count
                end
                TriggerClientEvent(config.prefix.."OnRemoveItem", id, items[item].label, count)
                TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv)
            else
                ErrorHandling(id, 2)
            end
        else
            ErrorHandling(id, 1)
        end
    end)
end

--[[ 
id = Server ID
item = Item name, not label
count = Item count to add

/!\ This **do** check player weight befor giving the item /!\
]]--
function AddItemIf(id, item, count)
    Citizen.CreateThread(function() -- Working in async, maybe that could fix inv issue i got without working in async, need testing i guess
        if items[item] ~= nil then
            local iWeight = GetInvWeight(PlayersCache[id].inv)
            if iWeight + (items[item].weight * count) <= config.defaultWeightLimit then
                if PlayersCache[id].inv[item] == nil then -- Item do not exist in inventory, creating it
                    PlayersCache[id].inv[item] = {}
                    PlayersCache[id].inv[item].label = items[item].label
                    PlayersCache[id].inv[item].count = count
                else -- Item do exist, adding count
                    PlayersCache[id].inv[item].count = PlayersCache[id].inv[item].count + count
                end
                TriggerClientEvent(config.prefix.."OnGetItem", id, items[item].label, count)
                TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv)
            else
                -- Need to do error notification to say, you can't hold the object
                TriggerClientEvent(config.prefix.."OnWeightLimit", id, items[item].label)
            end
        else
            -- Item do not exist, should do some kind of error notification
            ErrorHandling(id, 1)
        end
    end)
end


--[[ 
id = Server ID
target = Target server id
item = Item name, not label
count = Item count to add

/!\ This **do** check player weight befor giving the item /!\
]]--
function ExhangeItem(id, target, item, count, countsee)
    Citizen.CreateThread(function()
        if items[item] ~= nil then
            local tWeight = GetInvWeight(PlayersCache[target].inv)
            if tWeight + (items[item].weight * count) <= config.defaultWeightLimit then

                -- Removing item from source
                if PlayersCache[id].inv[item] == nil then
                    -- Display errro, item can not be nil
                    return
                else
                    if PlayersCache[id].inv[item].count ~= countsee then
                        -- Display error, client count and server count are not synced, maybe try to duplicate ?
                        return
                    end

                    if PlayersCache[id].inv[item].count - count <= 0 then
                        PlayersCache[id].inv[item] = nil
                    else
                        PlayersCache[id].inv[item].count = PlayersCache[id].inv[item].coun - count
                    end
                    TriggerClientEvent(config.prefix.."OnRemoveItem", id, items[item].label, count)
                    TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv)
                end

                -- Adding item to target

                if PlayersCache[target].inv[item] == nil then -- Create item
                    PlayersCache[target].inv[item] = {}
                    PlayersCache[target].inv[item].label = items[item].label
                    PlayersCache[target].inv[item].count = count
                else -- Add to count
                    PlayersCache[target].inv[item].count = PlayersCache[target].inv[item].count + count
                end
                TriggerClientEvent(config.prefix.."OnGetItem", target, items[item].label, count)
                TriggerClientEvent(config.prefix.."OnInvRefresh", target, PlayersCache[id].inv)
            else
                -- Target don't have space, will do notification later
            end
        end
    end)
end


--[[ 
inv = Player inventory
return = weight (int) but could be float
]]--
function GetInvWeight(inv)
    local weight = 0
    for k,v in pairs(inv) do
        weight = items[k].weight * v.count
    end
    return weight
end