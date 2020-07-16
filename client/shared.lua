function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end

function ShowAdvancedNotification(sender, subject, msg, textureDict, iconType)
	AddTextEntry('AdvancedNotification', msg)
	BeginTextCommandThefeedPost('AdvancedNotification')
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(false, false)
end

function ShowHelpNotification(msg, thisFrame)
	AddTextEntry('HelpNotification', msg)
	DisplayHelpTextThisFrame('HelpNotification', false)
end

function ShowFloatingHelpNotification(msg, coords)
	AddTextEntry('FloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('FloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end


local actionZone = {}
function RegisterActionZone(zone, text, actions)
    actionZone[#actionZone + 1] = {name = zone.name, pos = zone.pos, txt = text, action = actions}
end

function UnregisterActionZone(name)
    for k,v in pairs(actionZone) do 
        if v.name == name then
            actionZone[k] = nil
        end
    end
end

Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        local NearZone = false
        for k,v in pairs(actionZone) do
            if #(pCoords - v.pos) < 15 then
                NearZone = true
                DrawMarker(32, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 180, 1, 0, 2, 0, nil, nil, 0)
                if #(pCoords - v.pos) <= 1 then
                    ShowHelpNotification(v.txt)
                    if IsControlJustPressed(1, 38) then
                        v.action()
                    end
                end
                break
            end
        end

        if NearZone then
            Wait(1)
        else
            Wait(500)
        end
    end
end)