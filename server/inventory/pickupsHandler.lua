local pickups = {}

function DropItem(id, item, count, coords)
    if RemoveItem(id, item, count) then
        pickups[#pickups+1] = {item = item, count = count, coords = coords, added = false}
        TriggerClientEvent(config.prefix.."SendAllPickups", -1, pickups)
    end
end


RegisterNetEvent(config.prefix.."TakePickup")
AddEventHandler(config.prefix.."TakePickup", function(id, item, amount, count)
    GetPickupIfCan(source, id, item, amount, count)
end)

function GetPickupIfCan(id, idPickup, item, amount, count)
    if pickups[idPickup] ~= nil then
        if pickups[idPickup].count == count then
            if AddItemIf(id, item, count) then
                if pickups[idPickup].count - amount == 0 then
                    pickups[idPickup] = nil
                elseif pickups[idPickup].count - amount > 0 then
                    pickups[idPickup].count = pickups[idPickup].count - amount
                elseif pickups[idPickup].count - amount < 0 then
                    return
                end

                TriggerClientEvent(config.prefix.."SendAllPickups", -1, pickups)
            end
        end
    end
end