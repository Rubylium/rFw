local PlayersToken = {}

function DoesPlayerHaveToken(source)
    if PlayersToken[source] == nil then
        return false
    else
        return true
    end
end

function CheckPlayerToken(source, token)
    if DoesPlayerHaveToken(source) then
        if PlayersToken[source] == token then
            return true
        else
            return false
        end
    else
        return false
    end
end

function SetPlayerToken(source, token)
    if not DoesPlayerHaveToken(source) then
        PlayersToken[source] = token
        return true
    else
        return false
    end
end

RegisterNetEvent(config.prefix.."RegisterPlayerToken")
AddEventHandler(config.prefix.."RegisterPlayerToken", function(t)
    if not SetPlayerToken(source, t) then
        DropPlayer(source, "Red is kidda sus nah ?")
    end
end)