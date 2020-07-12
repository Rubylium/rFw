Citizen.CreateThread(function()
    TriggerServerEvent(config.prefix.."InitPlayer")
end)

RegisterNetEvent(config.prefix.."PlayerLoaded")
AddEventHandler(config.prefix.."PlayerLoaded", function(pos)
    SetEntityCoords(GetPlayerPed(-1), pos, 0.0, 0.0, 0.0, 0)

    InitPosLoop()
end)