function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            return v
        end
    end
end

RegisterNetEvent(config.prefix.."RegisterNewItem")
AddEventHandler(config.prefix.."RegisterNewItem", function(item, _label, _weight)
	if config.items[item] == nil then
		config.items[item] = {label = _label, weight = _weight}
	else
		print("^1ERROR:^7 Item already exist")
	end
end)

local errorsCode = {
    [1] = "Trying to do action on an item that do not exist.",
    [2] = "Trying to do action on an item that do not exist in player inventory.",
    [3] = "Trying to transfer invalid money (value > player's money / bank)",
}
function ErrorHandling(source, code)    
    print("^1ERROR:^7 "..errorsCode[code].." | Error triggered by ["..source.."]")
end