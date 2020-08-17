
RegisterKeyMapping("inventory", "Open inventory", 'keyboard', config.inventoryKey)
RegisterCommand("inventory", function()
    OpenInventoryMenu()
end, false)


-- For live refresh, could do a function call
AddEventHandler("rFw:InvRefresh", function(inv, weight)
    LiveRefreshMenu(inv, weight)
end)