function InitPosLoop()
    Citizen.CreateThread(function()
        local OldCoords = vector3(0.0, 0.0, 0.0)
        while true do
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            if #(pCoords - OldCoords) > 10.0 then
                TriggerServerEvent(config.prefix.."SavePos", pCoords)
            end
            OldCoords = pCoords
            Wait(5000)
        end
    end)
end