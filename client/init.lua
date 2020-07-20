local PlayerLoaded = false
local player = {}

Citizen.CreateThread(function()
    ShowLoadingMessage("Loading player data ...", 2, 5000)
    TriggerServerEvent(config.prefix.."InitPlayer")
end)

RegisterNetEvent(config.prefix.."PlayerLoaded")
AddEventHandler(config.prefix.."PlayerLoaded", function(playersInfo, items)
    ShowLoadingMessage("Spawning player", 2, 3500)
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

RegisterNetEvent(config.prefix.."OnAccountsRefresh")
AddEventHandler(config.prefix.."OnAccountsRefresh", function(money, bank)
    player.money = money
    player.bank = bank
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
    return player.bank
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