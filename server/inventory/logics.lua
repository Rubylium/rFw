
local items = config.items

--[[ 
id = Server ID
item = Item name, not label
count = Item count to add

/!\ This do not check player weight befor giving the item /!\
]]--
function AddItem(id, item, count, args)
    if items[item] ~= nil then
        local exist, itemid = DoesItemExistWithArg(id, item, args)
        if not exist then -- Item do not exist in inventory, creating it
            itemid = GenerateItemId()
            PlayersCache[id].inv[itemid] = {}
            PlayersCache[id].inv[itemid].item = item
            PlayersCache[id].inv[itemid].label = items[item].label
            PlayersCache[id].inv[itemid].count = count
            PlayersCache[id].inv[itemid].itemId = itemid
            PlayersCache[id].inv[itemid].args = {}
            if args ~= nil then
                PlayersCache[id].inv[itemid].args = args
            end
        else -- Item do exist, adding count
            PlayersCache[id].inv[itemid].count = PlayersCache[id].inv[itemid].count + count
        end
        TriggerClientEvent(config.prefix.."OnGetItem", id, items[item].label, count)
        TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv, GetInvWeight(PlayersCache[id].inv))
    else
        -- Item do not exist, should do some kind of error notification
        ErrorHandling(id, 1)
    end
end

--[[ 
id = Server ID
item = Item name, not label
count = Item count to remove
]]--
function RemoveItem(id, itemid, count)
    if items[item] ~= nil then
        if PlayersCache[id].inv[itemid] ~= nil then -- Item do not exist in inventory
            if PlayersCache[id].inv[itemid].count - count <= 0 then -- If count < or = 0 after removing item count, then deleting it from player inv
                PlayersCache[id].inv[itemid] = nil
            else
                PlayersCache[id].inv[itemid].count = PlayersCache[id].inv[itemid].count - count
            end
            TriggerClientEvent(config.prefix.."OnRemoveItem", id, items[item].label, count)
            TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv, GetInvWeight(PlayersCache[id].inv))
            return true
        else
            ErrorHandling(id, 2)
            return false
        end
    else
        ErrorHandling(id, 1)
        return false
    end
end

--[[ 
id = Server ID
item = Item name, not label
count = Item count to add

/!\ This **do** check player weight befor giving the item /!\
]]--
function AddItemIf(id, item, count, args)
    if items[item] ~= nil then
        local exist, itemid = DoesItemExistWithArg(id, item, args)
        local iWeight = GetInvWeight(PlayersCache[id].inv)
        if iWeight + (items[item].weight * count) <= config.defaultWeightLimit then
            if not exist then -- Item do not exist in inventory, creating it
                itemid = GenerateItemId()
                PlayersCache[id].inv[itemid] = {}
                PlayersCache[id].inv[itemid].item = item
                PlayersCache[id].inv[itemid].label = items[item].label
                PlayersCache[id].inv[itemid].count = count
                PlayersCache[id].inv[itemid].itemId = itemid
                PlayersCache[id].inv[itemid].args = {}
                if args ~= nil then
                    PlayersCache[id].inv[itemid].args = args
                end
            else -- Item do exist, adding count
                PlayersCache[id].inv[itemid].count = PlayersCache[id].inv[itemid].count + count
            end
            TriggerClientEvent(config.prefix.."OnGetItem", id, items[item].label, count)
            TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv, GetInvWeight(PlayersCache[id].inv))
            return true
        else
            -- Need to do error notification to say, you can't hold the object
            TriggerClientEvent(config.prefix.."OnWeightLimit", id, items[item].label)
            return false
        end
    else
        -- Item do not exist, should do some kind of error notification
        ErrorHandling(id, 1)
    end
end


--[[ 
id = Server ID
target = Target server id
item = Item name, not label
count = Item count to add

/!\ This **do** check player weight befor giving the item /!\
]]--
function ExhangeItem(id, target, item, count, countsee, args, itemid)
    if items[item] ~= nil then
        
        local tWeight = GetInvWeight(PlayersCache[target].inv)
        if tWeight + (items[item].weight * count) <= config.defaultWeightLimit then

            -- Removing item from source
            if PlayersCache[id].inv[itemid] == nil then
                -- Display errro, item can not be nil
                return
            else
                if PlayersCache[id].inv[itemid].count ~= countsee then
                    -- Display error, client count and server count are not synced, maybe trying to duplicate ?
                    return
                end

                if PlayersCache[id].inv[itemid].count - count <= 0 then
                    PlayersCache[id].inv[itemid] = nil
                else
                    PlayersCache[id].inv[itemid].count = PlayersCache[id].inv[itemid].coun - count
                end
                TriggerClientEvent(config.prefix.."OnRemoveItem", id, items[item].label, count)
                TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv, GetInvWeight(PlayersCache[id].inv))
            end

            -- Adding item to target

            local exist, itemid = DoesItemExistWithArg(id, item, args)
            if not exist then -- Create item
                itemid = GenerateItemId()
                PlayersCache[target].inv[itemid] = {}
                PlayersCache[target].inv[itemid].item = item
                PlayersCache[target].inv[itemid].label = items[item].label
                PlayersCache[target].inv[itemid].count = count
                PlayersCache[target].inv[itemid].itemId = itemid
                PlayersCache[target].inv[itemid].args = {}
                if args ~= nil then
                    PlayersCache[target].inv[itemid].args = args
                end
            else -- Add to count
                PlayersCache[target].inv[itemid].count = PlayersCache[target].inv[itemid].count + count
            end
            TriggerClientEvent(config.prefix.."OnGetItem", target, items[item].label, count)
            TriggerClientEvent(config.prefix.."OnInvRefresh", target, PlayersCache[id].inv, tWeight)
        else
            -- Target don't have space, will do notification later
        end
    end
end

--[[ 
id = player id
itemId = itemID of the item targeted
arg = item args
]]--
function SetItemArg(id, itemId, arg)
    for k,v in pairs(PlayersCache[id].inv) do
        if v.itemId == itemId then
            v.args = arg
        end
    end

    TriggerClientEvent(config.prefix.."OnInvRefresh", id, PlayersCache[id].inv, GetInvWeight(PlayersCache[id].inv))
end

--[[ 
return generated item id
]]--
function GenerateItemId()
    return ""..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009)).."-"..tostring(math.random(100001,900009))
end

--[[ 
id = player id
item = item name to check
arg = item args
]]--
function DoesItemExistWithArg(id, item, arg)
    if arg == nil then arg = {} end
    for k,v in pairs(PlayersCache[id].inv) do
        if v.item == item then
            print(json.encode(v.args), json.encode(arg), json.encode(v.args) == json.encode(arg))
            if json.encode(v.args) == json.encode(arg) then
                return true, v.itemId
            end
        end
    end
    return false
end

--[[ 
inv = Player inventory
return = weight (int) but could be float
]]--
function GetInvWeight(inv)
    local weight = 0
    for k,v in pairs(inv) do
        weight = items[v.item].weight * v.count
    end
    return weight
end