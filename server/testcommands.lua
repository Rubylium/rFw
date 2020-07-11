RegisterCommand("addmoney", function(source, args, rawCommand)
    AddMoney(source, args[1])
end, false)

RegisterCommand("removemoney", function(source, args, rawCommand)
    RemoveMoney(source, args[1])
end, false)