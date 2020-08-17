function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            return v
        end
    end
end

RegisterNetEvent("DeleteEntity")
AddEventHandler("DeleteEntity", function(list)
    for k,v in pairs(list) do
        local entity = NetworkGetEntityFromNetworkId(v)
        Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
    end
end) 

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
    [4] = "Trying to do action on invalid society name",
    [5] = "Trying to do action on invalide item count, probably server desync OR player trying duplication",
    [6] = "Trying to change player job while not being boss",
}
function ErrorHandling(source, code)    
    print("^1ERROR:^7 "..errorsCode[code].." | Error triggered by ["..source.."]")
end