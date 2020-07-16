RegisterCommand("repair", function(source, args, rawCommand)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    SetVehicleFixed(pVeh)
    SetVehicleDirtLevel(pVeh, 0.0)
end, false)


RegisterCommand("car", function(source, args, rawCommand)
    RequestModel(GetHashKey(args[1]))
    while not HasModelLoaded(GetHashKey(args[1])) do Wait(1) end

    local veh = CreateVehicle(GetHashKey(args[1]), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), 1, 0)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
end, false)

RegisterCommand("pos", function(source, args, rawCommand)
    print(GetEntityCoords(GetPlayerPed(-1)))
end, false)

RegisterCommand("random", function(source, args, rawCommand)
    local pVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetVehicleModKit(pVeh, 0)
    for i = 0,49 do
        local p = GetNumVehicleMods(pVeh, i)
        print(i, p)
        if p == 0 then p = 2 end
        SetVehicleMod(pVeh, i, math.random(1, p), true)
    end
end, false)
