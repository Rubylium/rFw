
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
        else
            -- Item do not exist, should do some kind of error notification
            ErrorHandling(id, 1)
        end
    end)
end