local pickups = {}
local nearObjs = {}


RegisterNetEvent(config.prefix.."SendAllPickups")
AddEventHandler(config.prefix.."SendAllPickups", function(pick)
    for k,v in pairs(nearObjs) do
        if v.prop then
            DeleteEntity(v.entity)
        end
    end
    nearObjs = {}
    pickups = pick
end)


function LoadPickups()
    

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
                    nearObjs[k].entity = SpawnProp("prop_cs_cardbox_01", v.coords)
                    nearObjs[k].prop = true
                end
                if #(v.coords - pCoords) < 2 then
                    isNear = true
                    DrawText3d(v.coords, "Press [~b~E~s~] to interact with x~b~"..v.count.."~s~ ~g~"..v.item)
                    if IsControlJustReleased(0, 38) then
                        local amount = KeyboardAmount()
                        if amount <= v.count then
                            TriggerServerEvent(config.prefix.."TakePickup", v.id, v.item, amount, v.count)
                        end
                    end
                    break
                end


                if #(v.coords - pCoords) > 15 then
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