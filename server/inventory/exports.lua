function RegisterNewItem(item, _label, _weight, _prop)
	if config.items[tostring(item)] == nil then
		print("^2ITEM REGISTERED: ^7"..item, _label, _weight, _prop)
		config.items[tostring(item)] = {label = tostring(_label), weight = tonumber(_weight), prop = tostring(_prop)}
	else
		print("^1ERROR:^7 Item already exist")
	end
end

RegisterNetEvent("RegisterNewItem")
AddEventHandler("RegisterNewItem", function(item, _label, _weight, prop)
    if source == "" then -- Only accept item register from server side to avoid cheater registering their own items lel
        RegisterNewItem(item, _label, _weight, prop)
    end
end)