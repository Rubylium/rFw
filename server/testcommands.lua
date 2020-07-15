RegisterCommand("addmoney", function(source, args, rawCommand)
    AddMoney(source, args[1])
end, false)

RegisterCommand("removemoney", function(source, args, rawCommand)
    RemoveMoney(source, args[1])
end, false)

RegisterCommand("addbank", function(source, args, rawCommand)
    AddBank(source, args[1])
end, false)

RegisterCommand("removebank", function(source, args, rawCommand)
    RemoveBank(source, args[1])
end, false)

RegisterCommand("giveitem", function(source, args, rawCommand)
    AddItemIf(source, args[1], tonumber(args[2]))
end, false)

RegisterCommand("removeitem", function(source, args, rawCommand)
    RemoveItem(source, args[1], tonumber(args[2]))
end, false)

RegisterCommand("debuginv", function(source, args, rawCommand)
    for k,v in pairs(PlayersCache[source].inv) do
        print(k, v.count)
    end
end, false)

RegisterCommand("changejob", function(source, args, rawCommand)
    ChangePlayerJob(args[1], tonumber(args[2]))
end, false)