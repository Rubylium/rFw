local token = nil
local tokenAcces = {
    ["TestRessource"] = 1, -- Number of allowed token request ( Token need to be stored )
}

AddEventHandler("token:RequestTokenAcces", function(ressource, cb)
    while token == nil do Wait(100) end
    local granted = false
    if tokenAcces[ressource] ~= nil then
        if tokenAcces[ressource] > 0 then
            granted = true
            tokenAcces[ressource] = tokenAcces[ressource] - 1
            cb(token)
        end
    end

    if not granted then
        TriggerServerEvent(config.prefix.."WrongTokenRequest", ressource)
    end
end)

local function GeneratePlayerToken(source)
    local token = math.random(100001,9000009).."-"..math.random(100001,9000009).."-"..math.random(100001,9000009).."-"..math.random(100001,9000009)
    return token
end

Citizen.CreateThread(function()
    local t = GeneratePlayerToken()
    TriggerServerEvent(config.prefix.."RegisterPlayerToken", t)
    token = t
end)

