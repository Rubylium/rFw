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


function RegisterItemAction(item, action)
	if config.items[item] ~= nil then	
		config.items[item].action = action
	else
		print("^1ERROR:^7 Try to add action to invalid item")
	end
end

function UseItem(item)
	if config.items[item] ~= nil then
		if config.items[item].action ~= nil then
			config.items[item].action()
		else
			print("^1ERROR:^7 No action on item '"..item.."'")
		end
	else
		print("^1ERROR:^7 Try to use invalid item")
	end
end


function RegisterNewItem(item, _label, _weight)
	if config.items[item] == nil then
		config.items[item] = {label = _label, weight = _weight}
		TriggerServerEvent(config.prefix.."RegisterNewItem", item, _label, _weight)
	else
		print("^1ERROR:^7 Item already exist")
	end
end