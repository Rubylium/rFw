function RegisterNewItem(item, _label, _weight)
	if config.items[item] == nil then
		config.items[item] = {label = _label, weight = _weight}
	else
		print("^1ERROR:^7 Item already exist")
	end
end

RegisterNetEvent("RegisterNewItem")
AddEventHandler("RegisterNewItem", function(item, _label, _weight)
    if source == "" then -- Only accept item register from server side to avoid cheater registering their own items lel
        RegisterNewItem(item, _label, _weight)
    end
end)