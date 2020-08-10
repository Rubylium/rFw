local pickups = {}
local nearObjs = {}


RegisterNetEvent(config.prefix.."SendAllPickups")
AddEventHandler(config.prefix.."SendAllPickups", function(pick, id, del, newCount)
    for k,v in pairs(nearObjs) do
        DeleteEntity(v.entity)
    end
    nearObjs = {}
    pickups = pick
end)


function LoadPickups()
    
    function GetItemProp(item)
        for k,v in pairs(config.items) do
            if k == item then
                print(k, item, v.label, v.prop)
                if v.prop ~= nil then
                    return v.prop
                else
                    return "prop_cs_cardbox_01"
                end
            end
        end
        return "prop_cs_cardbox_01"
    end


    Citizen.CreateThread(function()
        while true do
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            
            for k,v in pairs(pickups) do
                if #(v.coords - pCoords) < 15 then
                    if not v.added then
                        table.insert(nearObjs, {item = v.item, count = v.count, id = k, coords = v.coords, prop = false, entity = nil})
                        pickups[k].added = true
                    end
                end
            end

            Wait(500)
        end
    end)


    Citizen.CreateThread(function()
        while true do
            local isNear = false
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)


            for k,v in pairs(nearObjs) do
                if v.count == nil then 
                    nearObjs[k] = nil
                    break
                end
                if not v.prop then
                    -- Create prop here
                    if v.id == nil then break end
                    nearObjs[k].entity = SpawnProp(GetItemProp(nearObjs[k].item), v.coords)
                    nearObjs[k].prop = true
                end
                if #(v.coords - pCoords) < 2 then
                    isNear = true
                    DrawText3d(v.coords, "Press [~b~E~s~] to interact with x~b~"..v.count.."~s~ ~g~"..v.item)
                    if IsControlJustReleased(0, 38) then
                        local amount = KeyboardAmount()
                        if amount <= v.count then
                            TriggerServerEvent(config.prefix.."TakePickup", v.id, v.item, amount, v.count)
                            if amount == v.count then
                                if v.id == nil then break end
                                pickups[v.id].added = false
                                DeleteEntity(v.entity)
                                nearObjs[k] = nil
                            end
                        end
                    end
                    break
                end


                if #(v.coords - pCoords) > 15 then
                    if v.id == nil then break end
                    pickups[v.id].added = false
                    DeleteEntity(v.entity)
                    nearObjs[k] = nil
                end
            end

            if isNear then
                Wait(1)
            else
                if #nearObjs > 0 then
                    Wait(500)
                else
                    Wait(1000)
                end
            end
        end
    end)
end