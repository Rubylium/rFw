local open = false
local pInv = {}
local pWeight = 0
local pMoney = 0
local pBank = 0
local item = {
    item = "",
    label = "",
    count = 0,
    args = {},
    id = 0
}


RMenu.Add('inventory', 'main', RageUI.CreateMenu("Inventory", ""))
RMenu:Get('inventory', 'main'):SetSubtitle("RageUI inventory")
RMenu:Get('inventory', 'main'):DisplayGlare(false)
RMenu:Get('inventory', 'main').Closed = function()
    open = false
end;

RMenu.Add('inventory', 'item_usage', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Item", "~b~Item usage"))
RMenu:Get('inventory', 'item_usage').EnableMouse = false


function LiveRefreshMenu(inv, weight, money, bank)
    if inv ~= nil then pInv = inv end
    if weight ~= nil then pWeight = weight end
    if money ~= nil then pMoney = money end
    if bank ~= nil then pBank = bank end


    local found = false
    for k,v in pairs(pInv) do
        if v.itemId == item.id then
            found = true
            item.count = v.count
        end
    end

    if not found then
        RageUI.GoBack()
    end
end

function OpenInventoryMenu()
    if open then
        open = false
        return
    else
        open = true
        RageUI.Visible(RMenu:Get('inventory', 'main'), true)


        local inf = GetPlayerInv()
        pInv = inf.inv
        pWeight = inf.weight
        pMoney = GetPlayerMoney()
        pBank = GetPlayerBank()
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(RMenu:Get('inventory', 'main'), function()
                    -- Need to do money here
                    RageUI.Item.Button(pMoney.."~g~$", nil, {  }, true, {
                    }, RMenu:Get('inventory', "money_usage"))
                    RageUI.Item.Button(pBank.."~g~$", nil, {  }, true, {
                    }, RMenu:Get('inventory', "bank_usage"))
                    
                    RageUI.Item.Separator("↓ Weight ~b~"..pWeight.."~s~ ↓")
                    for k,v in pairs(pInv) do
                        RageUI.Item.Button(v.label.." x~b~"..v.count, nil, {  }, true, {
                            onSelected = function()
                                item.label = v.label  
                                item.count = v.count
                                item.args = v.args
                                item.item = v.item
                                item.id = v.itemId
                            end,
                        }, RMenu:Get('inventory', "item_usage"))
                    end
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'item_usage'), function()
                    RageUI.Item.Separator("↓ Item "..item.label.." x~b~"..item.count.."~s~ ↓")
                    RageUI.Item.Button("Use", nil, {  }, true, {
                        onSelected = function()
                            UseItem(item.item)
                        end,
                    })
                    RageUI.Item.Button("Give", nil, {  }, true, {
                        onSelected = function()
                            -- Will do soon #fleme
                        end,
                        onHovered = function()
                            DisplayClosetPlayer()
                        end,
                    })
                    RageUI.Item.Button("Drop", nil, {  }, true, {
                        onSelected = function()
                            local count = KeyboardAmount()
                            if count ~= nil and count > 0 and count <= item.count then
                                TriggerServerEvent("rFw:DropItem", item.item, item.id, count, GetEntityCoords(GetPlayerPed(-1)))
                            end
                        end,
                    })
                end)
                Wait(1)
            end
        end)
    end
end