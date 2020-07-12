function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            return v
        end
    end
end

local errorsCode = {
    [1] = "Trying to do action on an item that do not exist.",
    [2] = "Trying to do action on an item that do not exist in player inventory.",
}
function ErrorHandling(source, code)    
    print("^1ERROR:^7 "..errorsCode[code].." | Error triggered by ["..source.."]")
end