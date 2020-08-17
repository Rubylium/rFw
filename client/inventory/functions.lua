
RegisterKeyMapping("inventory", "Open inventory", 'keyboard', config.inventoryKey)
RegisterCommand("inventory", function()
    OpenInventoryMenu()
end, false)

AddEventHandler("rFw:InvRefresh", function(inv, weight)
    LiveRefreshMenu(inv, weight)
end)