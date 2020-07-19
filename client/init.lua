local PlayerLoaded = false
local player = {}

Citizen.CreateThread(function()
    TriggerServerEvent(config.prefix.."InitPlayer")
end)

RegisterNetEvent(config.prefix.."PlayerLoaded")
AddEventHandler(config.prefix.."PlayerLoaded", function(playersInfo, items)
    player = playersInfo
    config.items = items

    SetEntityCoords(GetPlayerPed(-1), player.pos, 0.0, 0.0, 0.0, 0)
    InitPosLoop()
    PlayerLoaded = true
end)

RegisterNetEvent(config.prefix.."OnJobChange")
AddEventHandler(config.prefix.."OnJobChange", function(job, grade)
    player.job = job
    player.job_grade = grade
    TriggerEvent("rFw:JobChange", job, grade)
end)

RegisterNetEvent(config.prefix.."OnInvRefresh")
AddEventHandler(config.prefix.."OnInvRefresh", function(inv, weight)
    player.inv = inv
    if weight ~= nil then
        player.weight = weight
    end
end)

function IsPlayerLoaded()
    return PlayerLoaded
end

function GetPlayerJob()
    return player.job, player.job_grade
end

function GetPlayerMoney()
    return player.money
end

function GetPlayerBank()
    return player.brank
end

function GetPlayerUniqueId()
    return player.id
end

function GetPlayerInv()
    return player.inv, player.weight
end

function GetPlayerPermLevel()
    return player.perm
end