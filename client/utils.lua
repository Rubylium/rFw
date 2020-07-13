RegisterNetEvent(config.prefix.."OnGetItem")
AddEventHandler(config.prefix.."OnGetItem", function(item, count)
    SendNUIMessage({
		additem = true,
		item = item,
		count = count,
    })
end)

RegisterNetEvent(config.prefix.."OnRemoveItem")
AddEventHandler(config.prefix.."OnRemoveItem", function(item, count)
    SendNUIMessage({
		rmvItem = true,
		item = item,
		count = count,
    })
end)

RegisterNetEvent(config.prefix.."OnWeightLimit")
AddEventHandler(config.prefix.."OnWeightLimit", function(item)
    SendNUIMessage({
		cantTake = true,
		item = item,
    })
end)